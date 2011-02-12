// ==UserScript==
// @name           aes
// @namespace      aes
// @include        *
// ==/UserScript==

var d= unsafeWindow.document;
window.d = d;

if (String(d.location).indexOf('127.0.0.1')>0 || String(d.location).indexOf('aesdirect.gov')>0)  {

var button = d.createElement("a");
button.innerHTML = "LOAD";
button.href = "javascript: DoTheMagic();";
d.getElementById("shipmentreferencenumber").parentNode.appendChild(button);

unsafeWindow.Propagate = function () {
    var varlist = String(GM_getValue("varlist")).split('|');
//    var sss = "DATA<br>";   
//    sss += GM_getValue("varlist")+"<br>";
    for (key in varlist) {
//        alert(varlist[key]);
        if (document.getElementsByName(varlist[key]).length > 0) {
            document.getElementsByName(varlist[key])[0].value = GM_getValue(varlist[key],"default");
        } else {
            var input = document.createElement("input");
            input.name = varlist[key];
            input.type = "HIDDEN";
            input.value = GM_getValue(varlist[key],"default");
            document.getElementsByName("edit")[0].appendChild(input);
        }
//        sss += varlist[key]+" = "+GM_getValue(varlist[key],"***")+"<br>";
    }
//    var ppp = d.createElement("p");
//    ppp.innerHTML = sss;
//    d.body.appendChild(ppp);
}

unsafeWindow.DoTheMagic = function (){
    var ref = d.getElementById("shipmentreferencenumber").value;
    var iframe = d.createElement("iframe");
    iframe.onload = unsafeWindow.Propagate;
    iframe.src = "http://unitedmotorsjax.com/data/"+ref;
    unsafeWindow.iframe = iframe;
    d.body.appendChild(iframe);
}

}


if (String(d.location).indexOf('unitedmotorsjax.com')>0)  {

var dataform = d.getElementsByName("data")[0].elements;
var varlist = "";

for (var item=0; item < dataform.length; item++) {
    varlist += dataform[item].name+"|";
    GM_setValue(dataform[item].name,dataform[item].value);   
}
varlist = varlist.substr(0, varlist.length-1); // Delete trailing '|'

GM_setValue("varlist",varlist);    // varlist contains key names of parameters to pass.
}


