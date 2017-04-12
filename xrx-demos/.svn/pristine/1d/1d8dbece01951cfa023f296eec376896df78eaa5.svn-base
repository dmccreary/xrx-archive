xquery version "1.0";


(: Post a Book :)

declare namespace xf="http://www.w3.org/2002/xforms";
declare namespace ev="http://www.w3.org/2001/xml-events";
declare namespace xhtml="http://www.w3.org/1999/xhtml";

    util:declare-option('exist:serialize', 'method=xhtml media-type=text/xml indent=yes process-xsl-pi=no')
    ,
    processing-instruction xml-stylesheet {concat('type="text/xsl" href="', request:get-context-path(), '/rest', '/db/xforms/xsltforms/xsltforms.xsl"')}
    ,
  
let $title :='Post Tester'
return
 <html 
    xmlns="http://www.w3.org/1999/xhtml" 
    xmlns:xf="http://www.w3.org/2002/xforms" 
    xmlns:ev="http://www.w3.org/2001/xml-events"
    eXSLTFormsDataInstancesViewer="true"
    >
<head>
    <xf:model>
        <xf:instance id="save-data">
        <book>
        <id>1</id>
        <title>XQuery</title>
        <author>Priscilla Walmsley</author>
        <description>This book is a highly detailed, through and complete tour of the W3C Query language.  It covers all the
            key aspects of the language as well as</description>
        <format>softcover</format>
        <publisher>O'Reilly Media Inc.</publisher>
        <publish-date>2007</publish-date>
        <license>commercial</license>
        <list-price>49.95</list-price>
    </book>
        </xf:instance>
       
        
        <xf:submission id="save" method="post" action="echo-post.xq" 
            instance="save-data" replace="all"/>
            
    </xf:model>
        
</head>
<body>
    
        <xf:submit submission="save">
           <xf:label>Send HTTP POST to echo-post.xq</xf:label>
        </xf:submit>
 </body>
</html> 
 