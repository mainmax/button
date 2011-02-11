// ==UserScript==
// @name           getdata
// @namespace      getdata
// @description    Retrive Data through Iframe
// ==/UserScript==

var d= unsafeWindow.document;

if (String(d.location).indexOf('127.0.0.1')>0)  {
d.getElementsByName('val1')[0].value = "Start";

var info = d.createElement("p");
info.innerHTML = "this is " + d.location;
d.body.appendChild(info);

var button = d.createElement("a");
button.innerHTML = "BUTTON";
button.href = "javascript: DoTheMagic();";
d.body.appendChild(button);

unsafeWindow.Propagate = function () {
	var varlist = String(GM_getValue("varlist")).split('|');
	for (key in varlist) {
		document.getElementsByName(varlist[key])[0].value = GM_getValue(varlist[key],"default");
	}
}

unsafeWindow.DoTheMagic = function (){
	var iframe = d.createElement("iframe");
	iframe.onload = unsafeWindow.Propagate;
	iframe.src = "http://unitedmotorsjax.com/data/amr062";
	unsafeWindow.iframe = iframe;
	d.body.appendChild(iframe);
}


d.getElementsByName('val3')[0].value = "Finish";
}

if (String(d.location).indexOf('unitedmotorsjax.com')>0)  {

// varlist contains key names of parameters to pass.
GM_setValue("varlist","val1|val2");
GM_setValue("val1","test");

var info = d.createElement("p");
info.innerHTML = "this is " + d.location;
d.body.appendChild(info);

}




