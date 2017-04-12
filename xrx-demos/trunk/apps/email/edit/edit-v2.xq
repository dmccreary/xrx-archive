xquery version "1.0";

(: import module namespace style = "http://style.syntactica.com/us-state-hist" at "../../../modules/style.xqm";' :)

declare namespace html="http://www.w3.org/1999/xhtml";
declare namespace xf="http://www.w3.org/2002/xforms";
declare namespace ev="http://www.w3.org/2001/xml-events";
declare namespace dc="http://purl.org/dc/elements/1.1/";
declare namespace mods="http://www.loc.gov/mods/v3";

declare option exist:serialize "method=xhtml media-type=text/xml indent=yes process-xsl-pi=no";

let $id := request:get-parameter('id', '')

let $style :=
<html:style language="text/css"><![CDATA[
@namespace xf url("http://www.w3.org/2002/xforms");

.tabs xf|trigger {
    color: black;
    background: #CCC;
    border: 0.1em outset #BBB;	/* Make it look like a button */
    border-bottom: 0.1em solid #CCC;
    font-weight: bold;
    font-family: Helvetica, sans-serif;
    text-decoration: none;
    margin-right: 5px;
    padding: 0.2em;
    /* round the top corners - works under FireFox */
    -moz-border-radius: .5em .5em 0em 0em;
 }
 
body {
  font-family: Hevetica, Arial, sans-serif;
}

img {border: none;}

legend {font-weight:bold;}

.block-form xf|output,
.block-form xf|input,
.block-form xf|select,
.block-form xf|select1,
.block-form xf|textarea 
   {display:block; width:100%; margin:10px 0;}
   
.block-form xf|label {
    width: 15ex;
}

/* make sure the select and select1 items don't float to the left */
xf|select xf|item, xf|select1 xf|item {
    margin-left: 16ex;
}

.uri .xforms-value {width: 90ex;}
.url .xforms-value {width: 70ex;}
		

/* Make the selected (targeted) item or default selection to appear on top */
xf|trigger:target {
   border-bottom: 0.1em solid #CCC;   /* Visually connect tab and tab body */
   background: yellow;                          /* Set active tab to light gray */
}
 
xf|switch xf|case div {
  background: #CCC;		/* Light gray */
  padding: 0.3em;		/* Looks better */
}	

        
]]></html:style>

let $model :=
<xf:model>
   <xf:instance id="save-data" src="new-instance.xml" xmlns=""/>
</xf:model>

let $content :=
<div class="content">
   <br/>
   <div class="tabs">
    <xf:trigger appearance="minimal">
        <xf:label>Citation Information</xf:label>
        <xf:action ev:event="DOMActivate">
            <xf:toggle case="citation-information-case"/>
        </xf:action>
    </xf:trigger>
    
    <xf:trigger appearance="minimal">
        <xf:label>Resource Description</xf:label>
        <xf:action ev:event="DOMActivate">
            <xf:toggle case="resource-description-case"/>
        </xf:action>
    </xf:trigger>
    
    <xf:trigger appearance="minimal">
        <xf:label>Subject Analysis</xf:label>
        <xf:action ev:event="DOMActivate">
            <xf:toggle case="subject-analysis-case"/>
        </xf:action>
    </xf:trigger>
    
    <xf:trigger appearance="minimal">
        <xf:label>Relationships</xf:label>
        <xf:action ev:event="DOMActivate">
            <xf:toggle case="relationships-case"/>
        </xf:action>
    </xf:trigger>
    
    <xf:trigger appearance="minimal">
        <xf:label>Administrative</xf:label>
        <xf:action ev:event="DOMActivate">
            <xf:toggle case="administrative-case"/>
        </xf:action>
    </xf:trigger>
   </div>
    
    <xf:switch>
        <!-- the default view -->
        <xf:case id="citation-information-case" selected="true">
            <h1>Citation Information</h1>
            <fieldset>
                <legend>Title</legend>
                <xf:repeat nodeset="mods:titleInfo" id="titleInfo">
                <div class="block-form">
                   <xf:input ref="mods:title">
                     <xf:label>Title: </xf:label>
                   </xf:input>
                   
                   <xf:select1 ref="mods:title/@type" id="titleType">
                    <xf:label class="mods-label">Type:     </xf:label>
                    <xf:item>
                        <xf:label>Abbreviated</xf:label>
                        <xf:value>abbreviated</xf:value>
                    </xf:item>
                    <xf:item>
                        
                        <xf:label>Alternative</xf:label>
                        <xf:value>alternative </xf:value>
                    </xf:item>
                    <xf:item>
                        <xf:label>Translated</xf:label>
                        <xf:value>translated</xf:value>
                    </xf:item>
                    
                    <xf:item>
                        <xf:label>Uniform</xf:label>
                        <xf:value>uniform</xf:value>
                    </xf:item>
                </xf:select1>
                
                <xf:input ref="mods:title/@authority" class="attribute">
                    <xf:label class="mods-label">Authority: </xf:label>
                </xf:input>
                
                </div>
                   
                   <xf:trigger ref="self::node()[count(../mods:titleInfo) &gt; 1]">
                      <xf:label>Delete This Title</xf:label>
                      <xf:delete ev:event="DOMActivate" nodeset="mods:titleInfo/mods:title" at="index('titleInfo')"/>
                   </xf:trigger>
                </xf:repeat>
                

            <xf:trigger class="add">
                <xf:label>Add Additional Title</xf:label>
                <xf:insert ev:event="DOMActivate" nodeset="mods:titleInfo[last()]" at="index('titleInfo')" position="after"/>
                <xf:setvalue ref="mods:titleInfo/mods:title[last()]" value="''"/>
            </xf:trigger>
            </fieldset>
            
            <fieldset>
                <legend>Name</legend>
            

            </fieldset>
            
            <fieldset>
                <legend>Publisher Information</legend>
            

            </fieldset>
            
        </xf:case>
        
        <xf:case id="resource-description-case">
            <h1>Resource Description</h1>
            <fieldset>
                <legend>Resource Description Fields</legend>
            

            </fieldset>
        </xf:case>
        
        <xf:case id="subject-analysis-case">
            <h1>Subject Analysis</h1>
            <fieldset>
                <legend>Subject Analysis Fields</legend>
            

            </fieldset>
        </xf:case>
        
        <xf:case id="resource-description-case">
            <h1>Resource Description</h1>
            <fieldset>
                <legend>Resource Description Fields</legend>
            

            </fieldset>
        </xf:case>
        
        <xf:case id="relationships-case">
            <h1>Relationships</h1>
            <fieldset>
                <legend>Relationships Fields</legend>
            

            </fieldset>
        </xf:case>
        
        <xf:case id="administrative-case">
            <h1>Administrative</h1>
             <fieldset>
                <legend>Administrative Fields</legend>
            

            </fieldset>
        </xf:case>
    </xf:switch>

</div>

let $page :=
<html
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xf="http://www.w3.org/2002/xforms"
    xmlns:ev="http://www.w3.org/2001/xml-events"
    xmlns:dc="http://purl.org/dc/elements/1.1/"
    xmlns:mods="http://www.loc.gov/mods/v3"
    mods:dummy1="dummy1"
    dc:dummy2="dummy2"
    >
    <head>
        {$style}
        {$model}
    </head>
    <body>
        {$content}
    </body>
</html>

let $xslt-pi := processing-instruction xml-stylesheet {'type="text/xsl" href="/rest/db/xforms/xsltforms/xsltforms.xsl"'}
let $debug := processing-instruction xsltforms-options {'debug="yes"'}
return ($xslt-pi, $debug, $page)
