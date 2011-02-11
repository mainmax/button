// ==UserScript==
// @name           getdata
// @namespace      getdata
// @description    Retrive Data through Iframe
// ==/UserScript==

var d= unsafeWindow.document;
window.d = d;

if (String(d.location).indexOf('127.0.0.1')>0 || String(d.location).indexOf('aesdirect.gov')>0)  {

var info = d.createElement("p");
info.innerHTML = "this is " + d.location;
d.body.appendChild(info);

var button = d.createElement("a");
button.innerHTML = "BUTTON";
button.href = "javascript: DoTheMagic();";
d.body.appendChild(button);

unsafeWindow.Propagate = function () {
	var varlist = String(GM_getValue("varlist")).split('|');
//	var sss = "DATA<br>";	
//	sss += GM_getValue("varlist")+"<br>";
	for (key in varlist) {
	//	alert(varlist[key]);
		if (document.getElementsByName(varlist[key])) {
			document.getElementsByName(varlist[key])[0].value = GM_getValue(varlist[key],"default");
		}
//		sss += varlist[key]+" = "+GM_getValue(varlist[key],"***")+"<br>";
	}
//	var ppp = d.createElement("p");
//	ppp.innerHTML = sss;
//	d.body.appendChild(ppp);
}

unsafeWindow.DoTheMagic = function (){
	var iframe = d.createElement("iframe");
	iframe.onload = unsafeWindow.Propagate;
	iframe.src = "http://unitedmotorsjax.com/data/amr062";
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

GM_setValue("varlist",varlist);	// varlist contains key names of parameters to pass.

var info = d.createElement("p");
info.innerHTML = "this is " + d.location;
d.body.appendChild(info);

}




