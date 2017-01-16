import java.util.*;
import java.security.*;
import java.net.URLEncoder;

class Untitled {
    public static void main(String[] args) {
        HashMap<String, String> params = new HashMap<String,String>();
        params.put("app_id","5vY4mg0Eog8SWo0mHYSWbqpl");
        params.put("timestamp","1442198292");
        params.put("noncestr","TWSm66JpFIlzdRyk");
        params.put("a","2");
        params.put("b","3");
        try {
            System.out.println(getSignature(params,"Ppuj8xfvb8jltBkcDvALFcEtWvgXGdxj"));
        } catch (Exception ex) {
            System.out.println(ex);
        }

        
    }
    /**
     * 签名生成算法
     * @param HashMap<String,String> params 请求参数集，所有参数必须已转换为字符串类型，值已进行encode
     * @param String secret 签名密钥
     * @return 签名
     * @throws IOException
     */
    public static String getSignature(HashMap<String,String> params, String secret) throws Exception
    {
        // 先将参数以其参数名的字典序升序进行排序
        Map<String, String> sortedParams = new TreeMap<String, String>(params);
        Set<Map.Entry<String, String>> entrys = sortedParams.entrySet();
     
        // 遍历排序后的字典，将所有参数按"key=value"格式拼接在一起
        StringBuilder basestring = new StringBuilder();
        for (Map.Entry<String, String> param : entrys) {
            basestring.append(param.getKey()).append("=").append(URLEncoder.encode(param.getValue()).replaceAll("\\+", "%20")).append("&");
        }
        basestring.delete(basestring.length()-1, basestring.length()).append(":").append(secret);
        // System.out.println(basestring);
        // 使用MD5对待签名串求签
        byte[] bytes;
        try {
            MessageDigest md5 = MessageDigest.getInstance("MD5");
            bytes = md5.digest(basestring.toString().getBytes("UTF-8"));
        } catch (GeneralSecurityException ex) {
            throw new Exception(ex);
        }
     
        // 将MD5输出的二进制结果转换为小写的十六进制
        StringBuilder sign = new StringBuilder();
        for (int i = 0; i < bytes.length; i++) {
            String hex = Integer.toHexString(bytes[i] & 0xFF);
            if (hex.length() == 1) {
                sign.append("0");
            }
            sign.append(hex);
        }
        return sign.toString().toUpperCase();
    }
}
