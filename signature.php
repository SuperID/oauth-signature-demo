<?php

    function random_str($length)
    {
        //生成一个包含 大写英文字母, 小写英文字母, 数字 的数组
        $arr = array_merge(range(0, 9), range('a', 'z'), range('A', 'Z'));

        $str = '';
        $arr_len = count($arr);
        for ($i = 0; $i < $length; $i++)
        {
            $rand = mt_rand(0, $arr_len-1);
            $str.=$arr[$rand];
        }

        return $str;
    }

    function getSignature($params, $token) {

        $str = '';
        // 先将参数以其参数名的字典序升序进行排序
        ksort($params);
        $array=array();
        //遍历排序后的参数数组中的每一个key/value对
        foreach ($params as $k => $v) {
            array_push($array, "$k=".rawurlencode($v));
        }
        // 通过 `&` 字符串拼接在一起
        $str .= join("&",$array);
        // 将签名密钥拼接到签名字符串最后面
        $str .= ":".$token;
        print_r("string : ".$str."\n");
        //通过md5算法为签名字符串生成一个md5签名，该签名就是我们要追加的sign参数值
        return strtoupper(md5($str));
    }
    
    function test() {
        $app_id = "5vY4mg0Eog8SWo0mHYSWbqp l";
        $token = "Ppuj8xfvb8jltBkcDvALFcEtWvgXGdxj";

        $params = array(
            "app_id" => $app_id,
            "timestamp" => "1442198292",
            "noncestr" => "TWSm66JpFIlzdRyk"
        );

        $url = "a=2&b=3";
        parse_str($url, $urlParams);

        $all = array_merge($params, $urlParams);
        $sign = getSignature($all, $token);
        echo("signature : ".$sign."\n");
    }

    test();
?>

