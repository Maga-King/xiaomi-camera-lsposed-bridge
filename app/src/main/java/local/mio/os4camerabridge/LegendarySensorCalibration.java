package local.mio.os4camerabridge;

/** Optional donor chart fit in linear sensor RGB. Not an OEM model, JPEG LUT, or OnePlus calibration. */
public final class LegendarySensorCalibration {
    private static final float[] DAY = {1.1601496f,.00931647f,.0098905f,-.04f,1.0608945f,.03539111f,-.03367824f,.03030827f,1.1229829f};
    private static final float[] WARM = {1.1801496f,-.0006835257f,-.0001094971f,-.04823627f,1.0234718f,.04378996f,-.0235442f,.04008009f,1.0967389f};
    private LegendarySensorCalibration() {}
    public static float[] select(int cct) {
        if (cct < 1800 || cct > 12000) return null;
        float weight = cct >= 7115 ? 0 : cct <= 2787 ? 1 : clamp((1000000f/cct - 140.54814f)/218.2606f);
        float[] result = new float[9];
        for (int i=0;i<9;i++) result[i]=DAY[i]+(WARM[i]-DAY[i])*weight;
        float mired=1000000f/cct, mid;
        if(mired<=192.3077f || mired>=277.77777f) mid=0;
        else if(mired>=222.22223f && mired<=243.90244f) mid=1;
        else if(mired<222.22223f) mid=smooth((mired-192.3077f)/29.914536f);
        else mid=smooth((277.77777f-mired)/33.875336f);
        result[3]+=.01f*mid;result[4]-=.02f*mid;result[5]+=.01f*mid;
        return result;
    }
    /** Input already uses the mandatory sqrt10 BGGR cloud encoding, but is not encrypted here. */
    public static long transform(byte[] raw, int width, int height, int stride, float[] matrix) {
        if(raw==null || width<=0 || height<=0 || (width&3)!=0 || (height&1)!=0 || stride<width*5/4
                || (long)stride*height!=raw.length || matrix==null || matrix.length!=9)
            throw new IllegalArgumentException("Invalid cloud RAW geometry/matrix");
        for(float coefficient:matrix) if(!Float.isFinite(coefficient)) throw new IllegalArgumentException("Non-finite matrix");
        int[] first=new int[4],second=new int[4]; long changed=0;
        for(int y=0;y<height;y+=2) for(int x=0;x<width*5/4;x+=5) {
            int top=y*stride+x,bottom=top+stride;
            for(int pair=0;pair<2;pair++) {
                int phase=pair*2, b=read(raw,top,phase),gb=read(raw,top,phase+1),gr=read(raw,bottom,phase),r=read(raw,bottom,phase+1);
                int[] out=pair==0?first:second;
                cell(b,gb,gr,r,matrix,out);
                changed+=(b==out[0]?0:1)+(gb==out[1]?0:1)+(gr==out[2]?0:1)+(r==out[3]?0:1);
            }
            write(raw,top,first[0],first[1],second[0],second[1]);
            write(raw,bottom,first[2],first[3],second[2],second[3]);
        }
        return changed;
    }
    private static void cell(int b,int gb,int gr,int r,float[] m,int[] out) {
        float red=linear(r),g1=linear(gb),g2=linear(gr),green=(g1+g2)*.5f,blue=linear(b);
        float rr=clamp(m[0]*red+m[1]*green+m[2]*blue);
        float gg=clamp(m[3]*red+m[4]*green+m[5]*blue);
        float bb=clamp(m[6]*red+m[7]*green+m[8]*blue);
        if(green>1e-12f) { float scale=gg/green;g1*=scale;g2*=scale; } else { g1=gg;g2=gg; }
        out[0]=encode(bb);out[1]=encode(g1);out[2]=encode(g2);out[3]=encode(rr);
    }
    private static int read(byte[] bytes,int offset,int p) { return ((bytes[offset+p]&255)<<2)|((bytes[offset+4]>>>(p*2))&3); }
    private static void write(byte[] bytes,int o,int a,int b,int c,int d) {
        bytes[o]=(byte)(a>>>2);bytes[o+1]=(byte)(b>>>2);bytes[o+2]=(byte)(c>>>2);bytes[o+3]=(byte)(d>>>2);
        bytes[o+4]=(byte)((a&3)|((b&3)<<2)|((c&3)<<4)|((d&3)<<6));
    }
    private static float linear(int sample) { float v=sample*9.775171e-4f;return v*v; }
    private static int encode(float value) { return (int)Math.min(1023f,(float)Math.sqrt(clamp(value))*1023f); }
    private static float clamp(float v) { return Math.max(0f,Math.min(1f,v)); }
    private static float smooth(float v) { v=clamp(v);return v*v*(3f-2f*v); }
}
