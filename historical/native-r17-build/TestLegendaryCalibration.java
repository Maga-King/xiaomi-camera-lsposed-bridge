import local.mio.os4camerabridge.LegendarySensorCalibration;
import java.util.Arrays;
public final class TestLegendaryCalibration {
    public static void main(String[] args) {
        if(LegendarySensorCalibration.select(1799)!=null || LegendarySensorCalibration.select(12001)!=null)throw new AssertionError("CCT boundaries");
        float[] identity={1,0,0,0,1,0,0,0,1};
        byte[] raw=new byte[24];Arrays.fill(raw,(byte)0x55);
        // Two active four-pixel groups per row, padded by two sentinel bytes.
        for(int y=0;y<2;y++)for(int group=0;group<2;group++)write(raw,y*12+group*5,320,500,650,750);
        byte[] original=raw.clone();
        LegendarySensorCalibration.transform(raw,8,2,12,identity);
        for(int y=0;y<2;y++)for(int group=0;group<2;group++)for(int p=0;p<4;p++)
            if(Math.abs(read(raw,y*12+group*5,p)-read(original,y*12+group*5,p))>1)throw new AssertionError("Identity drift");
        long changed=LegendarySensorCalibration.transform(raw,8,2,12,LegendarySensorCalibration.select(5181));
        if(changed==0)throw new AssertionError("Chart matrix was a no-op");
        for(int p:new int[]{10,11,22,23})if(raw[p]!=(byte)0x55)throw new AssertionError("Padding overwritten");
        for(int cct:new int[]{1800,2787,3600,4100,4300,4500,5200,7115,12000}) {
            float[] matrix=LegendarySensorCalibration.select(cct);
            for(float value:matrix)if(!Float.isFinite(value))throw new AssertionError("Invalid interpolation");
        }
        try{LegendarySensorCalibration.transform(raw,7,2,12,identity);throw new AssertionError("Odd geometry accepted");}
        catch(IllegalArgumentException expected){}
        System.out.println("PASS: calibration CCT boundaries, finite interpolation, identity quantization, active pixels, padding and invalid geometry");
    }
    private static int read(byte[] v,int o,int p){return ((v[o+p]&255)<<2)|((v[o+4]>>>(2*p))&3);}
    private static void write(byte[] v,int o,int a,int b,int c,int d){v[o]=(byte)(a>>2);v[o+1]=(byte)(b>>2);v[o+2]=(byte)(c>>2);v[o+3]=(byte)(d>>2);v[o+4]=(byte)((a&3)|((b&3)<<2)|((c&3)<<4)|((d&3)<<6));}
}
