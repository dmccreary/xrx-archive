xquery version "1.0";

declare namespace xf="http://www.w3.org/2002/xforms";
declare namespace ev="http://www.w3.org/2001/xml-events";
declare namespace exfk="http://kuberam.ro/exsltforms";

declare option exist:serialize "method=xhtml media-type=text/xml indent=yes process-xsl-pi=no";

let $title := 'eXSLTForms Test'

let $style :=
<style language="text/css">
	    <![CDATA[
		     @namespace xf url("http://www.w3.org/2002/xforms");
		     body {font-family: Helvetica, Arial, sans-serif; padding: 10px; font-size: 14px;}
		     textarea {height: 10ex; width: 100ex; font-family: Helvetica, Arial, sans-serif; font-size: 14px;}
		     xf|label {
		         font-weight: bold; display: inline-block;
		         width: 10ex;
		         vertical-align: top;
		         text-align: right; 
		         padding-right: 5px;
		         }
		     ]]>
</style>

let $model :=
<xf:model>
    <xf:instance id="save-data" src="02-sample-instance.xml"/>
</xf:model>

let $content :=
<div class="content">
   
   <p>Loading: <a href="ckeditor-test-instance.xml">02-sample-instance.xml</a></p>
   
   <xf:input ref="instance('save-data')/name" incremental="true">
       <xf:label>Name:</xf:label>
    </xf:input>
    <br/>
    <xf:textarea ref="instance('save-data')/text" incremental="true">
       <xf:label>Text:</xf:label>
    </xf:textarea>

</div>

let $form :=
<html
    xmlns="http://www.w3.org/1999/xhtml" 
    xmlns:xf="http://www.w3.org/2002/xforms" 
    xmlns:ev="http://www.w3.org/2001/xml-events"
    eXSLTFormsDataInstancesViewer="true">
    <head>
        <title>{$title}</title>
        {$model}
        {$style}
     </head>
     <body>
       <h1>{$title}</h1>
       {$content}
  </body>
</html>

let $xslt-pi := processing-instruction xml-stylesheet {'type="text/xsl" href="../utils/xsltforms/xsltforms.xsl"'}
let $debug := processing-instruction xsltforms-options {'debug="yes"'}
return ($xslt-pi, $debug, $form)