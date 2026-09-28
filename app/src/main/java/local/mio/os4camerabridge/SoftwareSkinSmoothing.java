package local.mio.os4camerabridge;

import android.graphics.Bitmap;
import android.opengl.*;
import java.nio.ByteBuffer;
import java.nio.ByteOrder;
import static android.opengl.GLES30.*;

/** Hardware-independent, edge-aware skin smoothing. No LUT, reshape or vendor HAL tags. */
public final class SoftwareSkinSmoothing {
    private EGLContext context;
    private int program;
    private static final String VERTEX = "#version 300 es\n"
            + "out vec2 uv; void main(){vec2 p=vec2((gl_VertexID<<1)&2,gl_VertexID&2);"
            + "uv=p;gl_Position=vec4(p*2.0-1.0,0.0,1.0);}";
    private static final String FRAGMENT = "#version 300 es\nprecision highp float;\n"
            + "uniform sampler2D image; uniform vec2 stepSize; uniform float amount; in vec2 uv; out vec4 result;"
            + "void main(){vec4 src=texture(image,uv);vec3 sum=vec3(0.0);float total=0.0;"
            + "for(int y=-2;y<=2;y++){for(int x=-2;x<=2;x++){vec2 d=vec2(float(x),float(y));"
            + "vec3 n=texture(image,uv+d*stepSize).rgb;vec3 diff=n-src.rgb;"
            + "float w=exp(-dot(d,d)*0.24-dot(diff,diff)*55.0);sum+=n*w;total+=w;}}"
            + "float l=dot(src.rgb,vec3(0.299,0.587,0.114));"
            + "float cb=0.5+(src.b-l)*0.564;float cr=0.5+(src.r-l)*0.713;"
            + "float skin=smoothstep(0.49,0.55,cr)*(1.0-smoothstep(0.66,0.73,cr))"
            + "*smoothstep(0.22,0.29,cb)*(1.0-smoothstep(0.53,0.59,cb))"
            + "*smoothstep(0.06,0.18,l)*(1.0-smoothstep(0.91,0.99,l));"
            + "result=vec4(mix(src.rgb,sum/max(total,0.001),amount*skin*0.85),src.a);}";

    public boolean draw(int inputTexture, int outputFramebuffer, int width, int height, float amount) {
        if (amount <= 0 || inputTexture <= 0 || outputFramebuffer <= 0 || width <= 0 || height <= 0) return false;
        EGLContext current = EGL14.eglGetCurrentContext();
        if (current == null || EGL14.EGL_NO_CONTEXT.equals(current) || glGetString(GL_VERSION) == null) return false;
        State state = new State();
        try {
            if (!current.equals(context)) { context = current; program = 0; }
            if (program == 0) program = createProgram();
            glBindFramebuffer(GL_DRAW_FRAMEBUFFER, outputFramebuffer);
            if (glCheckFramebufferStatus(GL_DRAW_FRAMEBUFFER) != GL_FRAMEBUFFER_COMPLETE)
                throw new IllegalStateException("beauty FBO incomplete");
            for (int cap : State.CAPS) glDisable(cap);
            glColorMask(true, true, true, true);
            glViewport(0, 0, width, height);
            glUseProgram(program);
            glActiveTexture(GL_TEXTURE0);
            glBindSampler(0, 0);
            glBindTexture(GL_TEXTURE_2D, inputTexture);
            glUniform1i(glGetUniformLocation(program, "image"), 0);
            // Radius follows image scale so still and preview have similar spatial strength.
            float step = Math.max(1f, Math.min(width, height) / 540f);
            glUniform2f(glGetUniformLocation(program, "stepSize"), step / width, step / height);
            glUniform1f(glGetUniformLocation(program, "amount"), Math.min(1f, amount));
            glDrawArrays(GL_TRIANGLES, 0, 3);
            int error = glGetError();
            if (error != GL_NO_ERROR) throw new IllegalStateException("beauty GL error=" + error);
            return true;
        } finally { state.restore(); }
    }

    /** Dedicated EGL context; commits to the caller's bitmap only after complete GPU readback. */
    public static boolean apply(Bitmap bitmap, float amount) {
        if (bitmap == null || bitmap.isRecycled() || !bitmap.isMutable() || amount <= 0) return false;
        if ((long) bitmap.getWidth() * bitmap.getHeight() > 14000000L) return false;
        EGLDisplay previousDisplay = EGL14.eglGetCurrentDisplay();
        EGLContext previousContext = EGL14.eglGetCurrentContext();
        EGLSurface previousDraw = EGL14.eglGetCurrentSurface(EGL14.EGL_DRAW);
        EGLSurface previousRead = EGL14.eglGetCurrentSurface(EGL14.EGL_READ);
        EGLDisplay display = EGL14.eglGetDisplay(EGL14.EGL_DEFAULT_DISPLAY);
        EGLContext offscreen = EGL14.EGL_NO_CONTEXT;
        EGLSurface surface = EGL14.EGL_NO_SURFACE;
        boolean initialized = false;
        int[] textures = new int[2];
        int[] fbo = new int[1];
        SoftwareSkinSmoothing filter = new SoftwareSkinSmoothing();
        try {
            initialized = EGL14.eglInitialize(display, new int[2], 0, new int[2], 0);
            if (!initialized) throw new IllegalStateException("beauty eglInitialize");
            EGLConfig[] config = new EGLConfig[1];
            int[] count = new int[1];
            int[] spec = {EGL14.EGL_RENDERABLE_TYPE, 0x40, EGL14.EGL_SURFACE_TYPE, EGL14.EGL_PBUFFER_BIT,
                    EGL14.EGL_RED_SIZE,8,EGL14.EGL_GREEN_SIZE,8,EGL14.EGL_BLUE_SIZE,8,EGL14.EGL_ALPHA_SIZE,8,EGL14.EGL_NONE};
            if (!EGL14.eglChooseConfig(display,spec,0,config,0,1,count,0) || count[0] == 0)
                throw new IllegalStateException("beauty ES3 config");
            offscreen = EGL14.eglCreateContext(display,config[0],EGL14.EGL_NO_CONTEXT,
                    new int[]{EGL14.EGL_CONTEXT_CLIENT_VERSION,3,EGL14.EGL_NONE},0);
            surface = EGL14.eglCreatePbufferSurface(display,config[0],
                    new int[]{EGL14.EGL_WIDTH,1,EGL14.EGL_HEIGHT,1,EGL14.EGL_NONE},0);
            if (!EGL14.eglMakeCurrent(display,surface,surface,offscreen)) throw new IllegalStateException("beauty makeCurrent");
            int width = bitmap.getWidth(), height = bitmap.getHeight();
            if (width > integer(GL_MAX_TEXTURE_SIZE) || height > integer(GL_MAX_TEXTURE_SIZE)) return false;
            glGenTextures(2,textures,0);
            for (int texture : textures) {
                glBindTexture(GL_TEXTURE_2D,texture);
                glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_MIN_FILTER,GL_LINEAR);
                glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_MAG_FILTER,GL_LINEAR);
                glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_WRAP_S,GL_CLAMP_TO_EDGE);
                glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_WRAP_T,GL_CLAMP_TO_EDGE);
            }
            glBindTexture(GL_TEXTURE_2D,textures[0]);
            GLUtils.texImage2D(GL_TEXTURE_2D,0,bitmap,0);
            glBindTexture(GL_TEXTURE_2D,textures[1]);
            glTexImage2D(GL_TEXTURE_2D,0,GL_RGBA8,width,height,0,GL_RGBA,GL_UNSIGNED_BYTE,null);
            glGenFramebuffers(1,fbo,0);
            glBindFramebuffer(GL_FRAMEBUFFER,fbo[0]);
            glFramebufferTexture2D(GL_FRAMEBUFFER,GL_COLOR_ATTACHMENT0,GL_TEXTURE_2D,textures[1],0);
            if (!filter.draw(textures[0],fbo[0],width,height,amount)) return false;
            ByteBuffer pixels = ByteBuffer.allocateDirect(width*height*4).order(ByteOrder.nativeOrder());
            glBindFramebuffer(GL_READ_FRAMEBUFFER,fbo[0]);
            glPixelStorei(GL_PACK_ALIGNMENT,1);
            glReadPixels(0,0,width,height,GL_RGBA,GL_UNSIGNED_BYTE,pixels);
            int error = glGetError();
            if (error != GL_NO_ERROR) throw new IllegalStateException("beauty readback=" + error);
            pixels.rewind();
            bitmap.copyPixelsFromBuffer(pixels);
            return true;
        } finally {
            if (!EGL14.EGL_NO_CONTEXT.equals(offscreen) && offscreen.equals(EGL14.eglGetCurrentContext())) {
                glDeleteFramebuffers(1,fbo,0);
                glDeleteTextures(2,textures,0);
                if (filter.program != 0) glDeleteProgram(filter.program);
            }
            if (!EGL14.EGL_NO_DISPLAY.equals(previousDisplay))
                EGL14.eglMakeCurrent(previousDisplay,previousDraw,previousRead,previousContext);
            else if (initialized) EGL14.eglMakeCurrent(display,EGL14.EGL_NO_SURFACE,EGL14.EGL_NO_SURFACE,EGL14.EGL_NO_CONTEXT);
            if (!EGL14.EGL_NO_SURFACE.equals(surface)) EGL14.eglDestroySurface(display,surface);
            if (!EGL14.EGL_NO_CONTEXT.equals(offscreen)) EGL14.eglDestroyContext(display,offscreen);
            // Never eglTerminate the process-wide display used by the camera's preview.
        }
    }

    private static int createProgram() {
        int vertex = shader(GL_VERTEX_SHADER,VERTEX), fragment = 0, linked = 0;
        try {
            fragment = shader(GL_FRAGMENT_SHADER,FRAGMENT);
            linked = glCreateProgram();
            glAttachShader(linked,vertex); glAttachShader(linked,fragment); glLinkProgram(linked);
            int[] status = new int[1]; glGetProgramiv(linked,GL_LINK_STATUS,status,0);
            if (status[0] == 0) throw new IllegalStateException(glGetProgramInfoLog(linked));
            int result = linked; linked = 0; return result;
        } finally { glDeleteShader(vertex); if (fragment != 0) glDeleteShader(fragment); if (linked != 0) glDeleteProgram(linked); }
    }
    private static int shader(int type,String source) {
        int shader = glCreateShader(type); glShaderSource(shader,source); glCompileShader(shader);
        int[] status = new int[1]; glGetShaderiv(shader,GL_COMPILE_STATUS,status,0);
        if (status[0] == 0) { String error = glGetShaderInfoLog(shader); glDeleteShader(shader); throw new IllegalStateException(error); }
        return shader;
    }
    private static int integer(int name) { int[] value = new int[1]; glGetIntegerv(name,value,0); return value[0]; }
    private static final class State {
        static final int[] CAPS = {GL_BLEND,GL_DEPTH_TEST,GL_SCISSOR_TEST,GL_CULL_FACE,GL_STENCIL_TEST,GL_RASTERIZER_DISCARD};
        final int draw=integer(GL_DRAW_FRAMEBUFFER_BINDING),read=integer(GL_READ_FRAMEBUFFER_BINDING),
                program=integer(GL_CURRENT_PROGRAM),active=integer(GL_ACTIVE_TEXTURE);
        final int texture, sampler;
        final int[] viewport = new int[4], mask = new int[4];
        final boolean[] enabled = new boolean[CAPS.length];
        State() {
            glGetIntegerv(GL_VIEWPORT,viewport,0); glGetIntegerv(GL_COLOR_WRITEMASK,mask,0);
            for(int i=0;i<CAPS.length;i++) enabled[i]=glIsEnabled(CAPS[i]);
            glActiveTexture(GL_TEXTURE0); texture=integer(GL_TEXTURE_BINDING_2D); sampler=integer(GL_SAMPLER_BINDING);
        }
        void restore() {
            glBindTexture(GL_TEXTURE_2D,texture); glBindSampler(0,sampler); glActiveTexture(active);
            glUseProgram(program); glBindFramebuffer(GL_DRAW_FRAMEBUFFER,draw); glBindFramebuffer(GL_READ_FRAMEBUFFER,read);
            glViewport(viewport[0],viewport[1],viewport[2],viewport[3]);
            glColorMask(mask[0]!=0,mask[1]!=0,mask[2]!=0,mask[3]!=0);
            for(int i=0;i<CAPS.length;i++) if(enabled[i]) glEnable(CAPS[i]); else glDisable(CAPS[i]);
        }
    }
}
