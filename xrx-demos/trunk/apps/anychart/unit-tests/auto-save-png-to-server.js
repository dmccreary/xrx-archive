function makeMultipartFormDataPostRequest(path, params) {
	
	var xmlhttp = false;
	/*@cc_on @*/
	/*@if (@_jscript_version >= 5)
	// JScript gives us Conditional compilation, we can cope with old IE versions.
	// and security blocked creation of the objects.
	try {
		xmlhttp = new ActiveXObject("Msxml2.XMLHTTP");
	} catch (e) {
		try {
			xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
		} catch (E) {
			xmlhttp = false;
		}
	}
	@end @*/

	if (!xmlhttp && typeof XMLHttpRequest!='undefined') {
		try {
			xmlhttp = new XMLHttpRequest();
		} catch (e) {
			xmlhttp=false;
		}
	}

	if (!xmlhttp && window.createRequest) {
		try {
			xmlhttp = window.createRequest();
		}catch (e) {
			xmlhttp=false;
		}
	}

	xmlhttp.open("POST", path, false);
	
	var boundary = "Boundary_" + new Date().getMilliseconds() + ";";
	
	// xmlhttp.setRequestHeader("Content-Type","multipart/form-data; boundary="+boundary);
	
	xmlhttp.setRequestHeader("Content-Type","image/png; boundary="+boundary);
	
	var dataString = "";
	
	for (var propName in params) {
		dataString += '--' + boundary + '\r\n';
		dataString += 'content-disposition: form-data; name="' + propName + '"' + '\r\n';
		dataString += 'content-type: application/octet-stream;\r\n\r\n\r\n';
		dataString += params[propName] + '\r\n';
	}
	dataString += "--"+boundary;
	
	xmlhttp.send(dataString);
	return xmlhttp.responseText ;
}


AnyChart.swfFile = "/rest/db/dma/resources/js/anychart/swf/AnyChart.swf";

function saveChartAsImage(chart) {
	var requestData = {};
	requestData['imgData'] = chart.getPng(); //chart.getJPEG();
	requestData['imgType'] = 'png';
	requestData['timestamp'] = new Date().getTime();
	
	var path = makeMultipartFormDataPostRequest('save-png.xq',requestData);
	if (path != null) {
		alert ("Image was saved to the server\nIt will be shown in a new window: "+path);
		var w = window.open('','',false);
		w.document.write('<img src="'+path+'" />');					
	}
}

var chart = new AnyChart();
	chart.setXMLFile("./test-chart.xml");
	chart.addEventListener("draw", function() {
		saveChartAsImage(chart);
	});
	chart.write("chart_container");