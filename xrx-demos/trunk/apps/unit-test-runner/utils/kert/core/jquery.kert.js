$(document).ready(function() {
	var $dialog = $("#open-test-dialog")
		.dialog({
			autoOpen: false,
			width : 700,
			buttons: {
				"Open": function() {
					openPlan( $( "#plan-uri" ).val() );
					$( this ).dialog( "close" );
				},
				Cancel: function() {
					$( this ).dialog( "close" );
				}
			}
	});
	$('#open-test').click(function() {
		$dialog.dialog('open');
		return false;
	});
	$("ul.sf-menu").superfish();
 } );
function openPlan(planURI) {
	$.get(planURI, function(xml) {
		//register the test plan data instance with simpath
		$x.instance('test-plan', xml);

		var sXPathExpr = "//kert:result";
		var sXPathExpr2 = "kert:wrap(.)";
		var xslText =
			"<xsl:stylesheet version=\"1.0\" " +
				"xmlns:xsl=\"http://www.w3.org/1999/XSL/Transform\" " +
				"xmlns:msxsl=\"urn:schemas-microsoft-com:xslt\" " +
				"exclude-result-prefixes=\"xforms msxsl\" " +

				"xmlns:xforms=\"http://www.w3.org/2002/xforms\" " +
				$x2.oNSs + ">" +
				"<msxsl:script language=\"javascript\" implements-prefix=\"kert\">" +
					"<![CDATA[" +
						"function wrap(result) {" + "return result;" +
// 							"if (typeof result == 'object') {" +
// 								"return '<result>' + result + '</result>';" +
// 							"} else {" +
// 								"return result;" + 
// 							"}" +
						"}" +
					"]]>" +
				"</msxsl:script>" +
				"<msxsl:script language=\"javascript\" implements-prefix=\"xforms\">" +
					"<![CDATA[" +
						"function $() {return 22;};" +
						"function avg(values) {" +
						"var obj = {'a' : 1, 'b' : 2};"+
							"return obj['a'];" +
						"};" +
						"function sum(values) {" +
							"return 17;" +
						"};" +
					"]]>" +
				"</msxsl:script>" +
				"<xsl:output method=\"html\"/>" +
// 				"<xsl:template match=\"/\">" +
// 					"<xsl:for-each select=\"" + sXPathExpr + "\">" +
// 						"<xsl:value-of select=\".\"/>" +
// 					"</xsl:for-each>" +
// 				"</xsl:template>" +
				"<xsl:template match=\"/\">" +
					"<xsl:copy-of select=\"kert:wrap(" + sXPathExpr + ")\"/>" +
				"</xsl:template>" +
			"</xsl:stylesheet>";//alert(xslText);
// 		var xsl = new ActiveXObject("Msxml2.DOMDocument");
// 		xsl.loadXML(xslText);
// 		try {
// 			var result = $x.instance('test-plan').oXMLDoc.transformNode(xsl);
// 		}
// 		catch(error) {
// 			alert("simpath error: " + error.description);
// 		}
// 		result = $x.utils.DOMParser('<result>' + result + '</result>');
// 
// 		alert(result.nodeName);

		//clear results' summary
		$("#custom-tests").empty();

		//render the collections of tests
		$("#dynatree-data").html($x.evaluate($x.compile("test-plan", "//kert:test-tree/*", "select-item")).clone());

		var testPlanResults = $x.evaluate($x.compile("test-plan", "//kert:result", "select-items")),
		testPlanTests = $x.evaluate($x.compile("test-plan", "//kert:test", "select-items")),
		resultTokens = testPlanResults.map(function() {return $(this).attr("id");}).get().join(' '),
		oUnfoundResultDescription = $x.evaluate($x.compile("test-plan", "//kert:result[@id = 'unfound']", "select-item"));

		if ($("#test-plan-tree > ul").hasClass('dynatree-container')) {
			$("#test-plan-tree").html($("#dynatree-data").html());
			$("#test-plan-tree").dynatree("getTree").reload();
		} else {
			$("#test-plan-tree").html($("#dynatree-data").html());
			$("#test-plan-tree").dynatree();
		}
		$("#plan-description").text($x.evaluate($x.compile("test-plan", "/*/*", "select-item")).text());
		//render results' summary
		$("#all-tests output").text($x.evaluate($x.compile("test-plan", "count(//kert:test)")));
		testPlanResults.each(function(index) {
			//$("<div/>", {"id": $(this).attr("id") + "-tests", "class": "field"}).appendTo("#custom-tests");
			$("<div class=\"field\" id=\"" + $(this).attr("id") + "-tests\"><label>" + $(this).text() + " tests:</label><output>0</output></div>").appendTo("#custom-tests");
		});
		//run tests
		testPlanTests.each(function(index) {
			var testPlanTest = $(this);alert($x.evaluate($x.compile("test-plan", "kert:test-url", "select-item"), testPlanTest[0]).text());
		//$("<div/>", {"id" : "unit-div-" + index}).appendTo("body").load($(this).children("test-url").text(), function(){$("#b1").click();}).error(function(){alert('error');});
			$.ajax({url: $x.evaluate($x.compile("test-plan", "kert:test-url", "select-item"), testPlanTest[0]).text(), testId: testPlanTest.attr("id")})
				.error(function() {
					//oTable.fnUpdate( "Test not found", index, 2 );
					//$(tr).css({"background-color": "white", "color": "black"});
					//update status of test in tree view

					//update status of test in test plan
					$x.evaluate($x.compile("test-plan", "//kert:test[@id = '" + this.id + "']/kert:run-status", "select-item")).text('unfound').attr("timestamp", new Date().toUTCString());
					//update summary
					$("#unfound-tests > output").text(Number($("#results-summary #unfound > output").text()) + 1);
					//update result score
					oUnfoundResultDescription.attr("score", Number(oUnfoundResultDescription.attr("score")) + 1);
				})
				.success(function() {
					$("<iframe/>", {"id" : this.testId, "src" : this.url, testId : this.testId})
						.appendTo("#iframes-host")
						.load(function(){
							var resultId = $(this).contents().find($x.evaluate($x.compile("test-plan", "//kert:test[@id = '" + this.id + "']/kert:evaluation", "select-item")).text()).text(),
							resultId = resultId ? resultId : 'unknown';
							if (resultTokens.indexOf(resultId) == -1) {
								resultId = 'undefined-result-token';
							}
							var resultDescription = $x.evaluate($x.compile("test-plan", "//kert:result[@id = '" + resultId + "']", "select-item"));
							//update status of test in tree view
//							$(tr).css({"background-color": resultDescription.attr("background-color"), "color": resultDescription.attr("font-color")});
							var iconURL = resultDescription.attr("icon-url"),
								backgroundImageURL = iconURL ? iconURL : 'resources/images/warning.png';
							$("#test-plan-tree").dynatree("getTree").getNodeByKey("tree-" + $(this).attr("id"))
								.span.children[1].style.backgroundImage = 'url(' + backgroundImageURL + ')';
							//update status of test in test plan
							$x.evaluate($x.compile("test-plan", "//kert:test[@id = '" + this.id + "']/kert:run-status", "select-item")).text('unfound').attr("timestamp", new Date().toUTCString());
							//update summary
							$("#" + resultId + "-tests > output").text(Number($("#" + resultId + "-tests > output").text()) + 1);
							//update result score
							resultDescription.attr("score", Number(resultDescription.attr("score")) + 1);
							$(this).remove();
							//alert(serializer.serializeToString( $x.evaluate($x.compile("test-plan", "//kert:results", "select-item"))[0] ));
					});
				});
		});
	}, "xml").error(function() { alert("Cannot load file: " + this.url + "."); });
}
var q = document.location.search || document.location.hash;
if (q) {
	openPlan(q.substring(10));	
}