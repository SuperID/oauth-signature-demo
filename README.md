# SuperID OAuth 接口签名Demo

## 签名的生成

以下所有请求均必须带上以下参数：

参数          | 说明
:------------|:-----------------
app_id       | 应用ID
timestamp    | 当前秒时间戳
noncestr     | 随机字符串（每次请求生成不同的随机字符串，建议不超过16字符）
signature    | 签名

假设参与参数签名计算的请求参数分别是`k1`、`k2`、`k3`，它们的值分别是`v1`、`v2`、`v3`，则参数签名计算方法如下：

- 将请求参数格式化为 `key=value` 格式，即 `k1=v1`、`k2=v2`、`k3=v3`；
- 将格式化好的参数键值对以字典序升序排列后，通过 `&` 字符串拼接在一起，即 `k1=v1&k2=v2&k3=v3`；
- 在拼接好的字符串末尾拼接 `:` 字符并追加上在开发者中心获得的 `Token` 参数；
- 将上述字符串的MD5值即为签名的值。

注意：

1. 计算签名时的请求参数中不要包含 `signature`（签名）参数，因为 `signature` 参数的值此时还不知道，有待计算
2. 文件不参与签名;
3. 所有参数必须经过 `urlencode/uriencode`

## Demo

  - [Java](/blob/master/signature.java)
  - [Node.js](/blob/master/signature.js)
  - [php](/blob/master/signature.php)