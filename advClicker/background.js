
var startsessiondt = + new Date();
var xhr = new XMLHttpRequest();
var json = JSON.stringify({
    "startsessiondt": startsessiondt
      });
    
xhr.open("POST", 'http://localhost:80/userurlapi/sessiondata/myValue', true, '_SYSTEM', 'SYS');
xhr.setRequestHeader('Content-type', 'application/json; charset=utf-8');
xhr.send(json);
  
var xhr = new XMLHttpRequest();
xhr.open("GET", 'http://localhost:80/userurlapi/dbdata/myValue', true, '_SYSTEM', 'SYS');
xhr.responseType = 'json';
xhr.send();
xhr.onreadystatechange = function() {
  if (xhr.readyState == 4) {
    var resp = xhr.response;
    var respcntadv = resp.cntadv;
    var resprecommendation = resp.recommendation;
    var respcntallclicks = resp.cntallclicks
    console.log('response:', resp);

    document.getElementById("cntadv").textContent = String(respcntadv);
    document.getElementById("recommendation").textContent = resprecommendation;
    document.getElementById("allclicks").textContent = respcntallclicks;
      
    }
  }

chrome.webRequest.onCompleted.addListener(function(info)
{
  if (info.url.slice(0, 19) != 'chrome-extension://')
  {
    console.log("onCompleted: ", info.url, info.timeStamp);
    var xhr = new XMLHttpRequest();
    var json = JSON.stringify({
      "userid": 1,
      "sessionid": 1,
      "startsessiondt": startsessiondt,
      "endsessiondt": -1,
      "url": info.url,
      "urldt": info.timeStamp
    });
    
    xhr.open("POST", 'http://localhost:80/userurlapi/plugindata/myValue', true, '_SYSTEM', 'SYS');
    xhr.setRequestHeader('Content-type', 'application/json; charset=utf-8');
  
    xhr.send(json);
  }
},
{
  urls: [
    "<all_urls>"
  ],
  types: ["main_frame"]
}
);


