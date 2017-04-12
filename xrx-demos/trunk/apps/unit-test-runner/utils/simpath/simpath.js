/*
 * simpath - Simpathetic XPath Module
 * By Claudius Teodorescu
 * Licensed under LGPL.
 */

$x2 = {
	models : {},
	instances : {},
	compile : function() {
	},
	evaluate : function() {
	},
	xe : {},
	utils : {
		fCollectNSs : function(oXMLDoc) {
			var oNSs = $x2.oNSs;
			for ( var i = 0; (attribute = oXMLDoc.documentElement.attributes[i]); i++ ) {
				var attrValue = attribute.value, attrName = attribute.name;
				if (!attrName.match(/^xmlns:/)) {
					continue;
				}
				oNSs[ attrName.substring( 6 ) ] = attrValue;
			}
			$x2.oNSs = oNSs;
		}
	},
	//object containing namespaces
	oNSs : {},			
	nsResolver : function( prefix ) { return $x2.oNSs[ prefix ] || null; }
};

if (document.documentElement.outerHTML) {
	$x2.utils.fCollectNSs = function(oXMLDoc) {
		var oNSs = $x2.oNSs,
			sOuterHTML = oXMLDoc.documentElement.outerHTML;
		for ( var i = 0; (attribute = sOuterHTML.substring(0, sOuterHTML.indexOf("><")).substring(6).replace(/ = /g, "=").split(' ')[i]); i++ ) {
			var attrValue = attribute.substring(attribute.indexOf("\"")).replace(/"/g, ""), attrName = attribute.substring(0, attribute.indexOf("="));
			if (!attrName.match(/^xmlns:/) || oNSs.match(attrName)) {
				continue;
			}
			oNSs += " " + attribute;
		}
		$x2.oNSs = oNSs;
	};
	$x2.oNSs = "";

}



(function() {
	if (document.documentElement.outerHTML) {//IE  && !XPathResult
		window.$x = {
			//object holding the data instances
			instances : {},
			//object holding the compiled XPath expressions
			xe : {},
			instance : function(sInstanceID, oXMLDoc) {
				if (oXMLDoc) {
					$x.instances[sInstanceID] = oXMLDoc;
				}
				return {
					oXMLDoc : $x.instances[sInstanceID],
					reset : function() {
					
					},
					source : function() {
						//return serializer.serializeToString(this.oXMLDoc.documentElement);
					},
					snapshot : function() {
					
					},
					$ : function() {
						return $(this.oXMLDoc.documentElement);
					}
				}
			},
			//IE function for processing the XPath expressions
			compile : function( oXMLDoc, sXPathExpr, oXPathContext ) {
	
			},
			//IE function for XPath evalution
			evaluate : function( oXMLDoc, sXPathExpr, oXPathContext ) {
/*				$.get("http://89.33.60.139/tests/x-crypt/index.xml", function(xml) {
					
			
					var xslText =
						"<xsl:stylesheet version=\"1.0\" xmlns:xsl=\"http://www.w3.org/1999/XSL/Transform\" " + $x.oNSs + ">" +
							"<xsl:output method=\"text\"/>" + 
								"<xsl:template match=\"*\">" + 
									"<xsl:value-of select=\"" + sXPathExpr + "\"/>" +
								"</xsl:template>" +
						"</xsl:stylesheet>";
					var xsl = new ActiveXObject("Msxml2.DOMDocument");
					xsl.loadXML(xslText);
					try
					{
						var result = testPlan.transformNode(xsl);
					}
					catch(error)
					{
						alert("XPath error: " + error.description);
					}
					alert('result: ' + result);
			
			
				}, "xml").error(function() { alert("Cannot load file: " + this.url + "."); });*/
	
	
			},
			//IE function for collecting namespaces
			utils : {
				DOMParser : function(sXMLstring) {
					var oXMLDoc = new ActiveXObject("Msxml2.DOMDocument");
					oXMLDoc.async = false;
					oXMLDoc.loadXML(sXMLstring);
					return oXMLDoc;
				}
			},
			//string containing namespaces
			oNSs : ""
		};
	} else {//nonIE
		//enrich XPathResult object
		XPathResult.prototype.attributeValue = function() {
			return (this.iterateNext()).nodeValue;
		};
		XPathResult.prototype.item = function() {
			return $(this.singleNodeValue);
		};		
		XPathResult.prototype.items = function() {
			var aItems = new Array();
			for ( var i=0 ; i < this.snapshotLength; i++ ) {
				aItems.push($(this.snapshotItem(i)));
			}
			return $(aItems);
		};
		window.$x = {
			//object holding the data instances
			instances : {},
			//object holding the compiled XPath expressions
			xe : {},
			instance : function(sInstanceID, oXMLDoc) {
				if (oXMLDoc) {
					$x.instances[sInstanceID] = oXMLDoc;
				}
				return {
					oXMLDoc : $x.instances[sInstanceID],
					reset : function() {
					
					},
					source : function() {
						return serializer.serializeToString(this.oXMLDoc.documentElement);
					},
					snapshot : function() {
					
					},
					$ : function() {
						return $(this.oXMLDoc.documentElement);
					}
				}
			},
			//nonIE function for processing the XPath expressions
			compile : function( sXMLDocID, sXPathExpr, sSelectionType ) {
				var sXPathExprProcessed = sXPathExpr
					//.replace( new RegExp( "avg\\(", "gi" ), " \" + window.avg\(\"" )
					//.replace( new RegExp( "\\)", "gi" ), "\") + \"" )
				, fXPathExprCompiled = new Function( "return (\"" + sXPathExprProcessed + "\")" )()
				, nXPathExprID = $.now();
				var fXPathResult = function() {
					var oXPathResultArgument = "var oXMLDoc = $x.instance('" + sXMLDocID + "').oXMLDoc; return oXMLDoc.evaluate(\"" + fXPathExprCompiled + "\", oXMLDoc, $x2.nsResolver, 0, null);",
					oXPathResult = null;
					try {
						oXPathResult = (new Function( oXPathResultArgument )());
					}
					catch(err) {
						return null;
					}
					var nXPathResultType = oXPathResult.resultType,
					fXPathResultHandler = "";//alert('nXPathResultType: ' + nXPathResultType);
					switch( nXPathResultType ) {
						case 1:
							fXPathResultHandler = "['numberValue']";
						break;
						case 2:
							fXPathResultHandler = "['stringValue']";
						break;
						case 3:
							fXPathResultHandler = "['booleanValue']";
						break;
						case 4:
							switch ( sSelectionType ) {
								case "select-item":
									nXPathResultType = 9;
									fXPathResultHandler = ".item()";
								break;
								case "select-items":
									nXPathResultType = 7;
									fXPathResultHandler = ".items()";
								break;
							}
						break;
					}


					var oCompiledXPathResult = {
						oXPathResult : "var oXMLDoc = $x.instance('" + sXMLDocID + "').oXMLDoc; return oXMLDoc.evaluate(\"" + fXPathExprCompiled + "\", oXMLDoc, $x2.nsResolver, " + nXPathResultType + ", null)" + fXPathResultHandler + ";"
					}
					return oCompiledXPathResult;
				}
				$x.xe[nXPathExprID] = fXPathResult();
				return nXPathExprID;
			},
			//nonIE function for evaluating the XPath expressions
			evaluate : function( nXPathExprID, oXPathContext ) {
				var sXPathExpr = $x.xe[nXPathExprID].oXPathResult;
				if (oXPathContext) {
					$x.xe[nXPathExprID]['oXPathContext'] = oXPathContext;
					sXPathExpr = "var oXPathContext = $x.xe['" + nXPathExprID + "'].oXPathContext; " + sXPathExpr.replace(/, oXMLDoc,/, ", oXPathContext,");
				}
				try {
					var XPathResult = (new Function( sXPathExpr )());
				}
				catch(err) {
					return null;
				}
				return XPathResult;
			},
			//object containing namespaces
			oNSs : {},			
			nsResolver : function( prefix ) { return $x.oNSs[ prefix ] || null; }
		};
	}
	//collection of namespaces for base document
})();

$x2.utils.fCollectNSs( document );

//TODO:
//IE; throw Simpath Error (see XPath 2.0 errors); $x.xpath()
//$x.instance(instanceID).snapshot()
//$x.instance(instanceID).reset()
//$x.instance(instanceID).source()


// $.fn.extend({
// selfText: function() {
// return this.clone().find("*").remove().end().text();
// }
// });

// Extensibility for DOM 3 XPath
//window.avg = function(a) {return 17;};
//alert($x.evaluate($x.compile("test-plan", "17 + avg(//div) + avg(//div)")));



//Examples of usage
	//numeric value
	//alert($x.evaluate($x.compile(document, "count(//kert:result) div 2"))); //result: 4, number

	//boolean value
// 	if ($x.evaluate($x.compile(document, "count(//kert:result) div 2 = 4"))) { //result: true, boolean
// 		alert('result is true');
// 	} else {
// 		alert('result is false');
// 	}

	//item
	//alert($x.evaluate($x.compile(document, "//kert:result[1]", "select-item")).text()); //object

	//items
// 	$x.evaluate($x.compile(document, "//kert:result", "select-items")).each(function(index) {
// 		alert( index + ": " + serializer.serializeToString( this[0] ) );
// 	});

	//attribute node
// 	alert($x.evaluate($x.compile(document, "//kert:result[1]/@icon-url", "select-item")).val());

	//attribute nodes
// 	$x.evaluate($x.compile(document, "//@icon-url", "select-items")).each(function(index) {
// 		alert( index + ": " + this.val() );
// 	});