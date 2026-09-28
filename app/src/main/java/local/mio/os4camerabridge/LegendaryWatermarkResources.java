package local.mio.os4camerabridge;

import android.app.Application;
import android.content.Context;
import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;
import java.util.zip.ZipEntry;
import java.util.zip.ZipInputStream;
import de.robv.android.xposed.XC_MethodHook;
import de.robv.android.xposed.XposedBridge;
import de.robv.android.xposed.XposedHelpers;

/** Make the complete native Live Moment template available before Camera enumerates templates. */
public final class LegendaryWatermarkResources {
    private LegendaryWatermarkResources() {}
    static void install(ClassLoader cameraLoader) throws Exception {
        // Exact runtime FileUtil identified from WmBaseManager.initData, not a guessed device-config class.
        Class<?> scan=XposedHelpers.findClass("Gg.s",cameraLoader);
        java.lang.reflect.Method method=scan.getDeclaredMethod("g",File.class,java.util.ArrayList.class,boolean.class);
        if(method.getReturnType()!=java.util.ArrayList.class)throw new IllegalStateException("watermark scan signature");
        XposedBridge.hookMethod(method,new XC_MethodHook() {
            @Override protected void beforeHookedMethod(MethodHookParam p) {
                try { ensure((File)p.args[0]); }
                catch(Throwable error){XposedBridge.log("[LegendaryWatermark] template not added: "+error);}
            }
        });
    }
    private static synchronized void ensure(File scanRoot) throws Exception {
        Application app=(Application)XposedHelpers.callStaticMethod(
                Class.forName("android.app.ActivityThread"),"currentApplication");
        if(app==null || !"com.android.camera".equals(app.getPackageName()))return;
        File expected=new File(app.getFilesDir(),"watermarks").getCanonicalFile();
        if(!expected.equals(scanRoot.getCanonicalFile()))return;
        File group=new File(expected,"leica"),dest=new File(group,"135");
        if(!group.isDirectory() || dest.exists())return; // Never overwrite an official update or user configuration.
        Context module=app.createPackageContext("local.mio.os4camerabridge",Context.CONTEXT_IGNORE_SECURITY);
        File stage=Files.createTempDirectory(app.getCacheDir().toPath(),"legend-watermark-135-").toFile();
        int count=0;long total=0;
        try(InputStream stream=module.getAssets().open("legendary/watermarks/leica-135.zip");
                ZipInputStream zip=new ZipInputStream(stream)) {
            ZipEntry entry;byte[] buffer=new byte[16384];
            while((entry=zip.getNextEntry())!=null) {
                String name=entry.getName();
                if(entry.isDirectory() || !name.matches("[A-Za-z0-9_]+\\.(json|webp)") || ++count>32)
                    throw new IllegalArgumentException("unexpected template entry");
                File file=new File(stage,name);
                if(!file.createNewFile())throw new IllegalArgumentException("duplicate template entry");
                try(FileOutputStream out=new FileOutputStream(file)) {
                    int n;while((n=zip.read(buffer))!=-1) {
                        total+=n;if(total>4*1024*1024)throw new IllegalArgumentException("template size limit");
                        out.write(buffer,0,n);
                    }
                }
                zip.closeEntry();
            }
        }
        if(count!=13 || !new File(stage,"config.json").isFile() || !new File(stage,"leica.webp").isFile())
            throw new IllegalArgumentException("incomplete native template");
        Files.move(stage.toPath(),dest.toPath(),StandardCopyOption.ATOMIC_MOVE);
        XposedBridge.log("[LegendaryWatermark] Live Moment135 installed from module assets files="+count
                +" bytes="+total+" selectionUnchanged=true noExternalDataDependency=true");
    }
}
