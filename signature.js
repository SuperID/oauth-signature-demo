require('./md5.js')
var md5 = faultylabs.MD5;

function parseUrl (url) {
  url = url.trim();
  var query = {};
  if (url) {
    url.split('&').forEach(function (line) {
      var s = line.split('=');
      if (s.length !== 2) {
        throw new Error('URL格式不正确');
      }
      query[s[0]] = s[1];
    });
  }
  return query;
}

function getSignature (query, token) {
  var string = Object.keys(query).sort().map(function (k) {
    return k + '=' + encodeURIComponent(query[k]);
  }).join('&') + ':' + token;
  console.log(string);
  return md5(string);
}

function test() {
  var app_id = "5vY4mg0Eog8SWo0mHYSWbqpl";
  var token = "Ppuj8xfvb8jltBkcDvALFcEtWvgXGdxj";

  var url = "a=2&b=3";
  var urlParams = parseUrl(url);
  
  urlParams["app_id"] = app_id;
  urlParams["timestamp"] = "1442198292";
  urlParams["noncestr"] = "TWSm66JpFIlzdRyk";

  var sign = getSignature(urlParams, token);
  console.log(sign)
}

test()