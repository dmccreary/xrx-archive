xquery version "1.0";

declare namespace xf="http://www.w3.org/2002/xforms";

declare function local:assemble-form($title as xs:string*, $content as node()) as node() {
let $set-xhmtl-serialize := util:declare-option('exist:serialize', 'method=xhtml media-type=text/html indent=yes process-xsl-pi=no'')
return
    <html
    xmlns="http://www.w3.org/1999/xhtml" 
    xmlns:xf="http://www.w3.org/2002/xforms" 
    xmlns:ev="http://www.w3.org/2001/xml-events">
        <head>
            <title>{$title}</title>
            <link rel="shortcut icon" type="image/x-icon" href="xquery.png"/>
            <style type="text/css"><![CDATA[
               #footer, #header {background-color: lavender;}
            ]]></style>
        </head>
        <body>
          {$content}
        </body>
     </html>
};


let $title := 'Page Title'

et $model :=
<xf:model>
       <xf:instance xmlns="">
          <data>
             <message>Hello World</message>
          </data>
       </xf:instance>
</xf:model>

let $content :=
<div class="content">
 <xf:input ref="PersonGivenName" incremental="true">
            <xf:label>Please enter your first name: </xf:label>
 </xf:input>
 <br />
 <xf:output value="concat('Hello ', PersonGivenName, '. We hope you like XForms!')">
    <xf:label>Output: </xf:label>
 </xf:output>
</div>

return local:assemble-page($title, $content)