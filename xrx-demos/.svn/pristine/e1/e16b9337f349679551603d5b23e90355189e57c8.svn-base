xquery version "1.0";
import module namespace style='http://www.mnhs.org/style' at '/db/cust/mhs/modules/style.xqm';
(: XQuery to construct an XForm for either a new item or update item :)
declare option exist:serialize "method=xhtml media-type=text/xml indent=no process-xsl-pi=no";

let $new := request:get-parameter('new', '')
let $id := request:get-parameter('id', '')
 
return
(: check for required parameters :)
if (not($new or $id))
    then (
    <error>
        <message>Parameter "new" and "id" are both missing.  One of these two arguments is required for form.</message>
    </error>)
    else
      let $app-collection := style:app-base-url()
      let $data-collection := concat($app-collection, '/data')

     (: put in the appropriate file name :)
     let $file := if ($new)
        then ('new-instance.xml')
        else (concat($data-collection, '/', $id, '.xml'))

let $form :=
<html xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xf="http://www.w3.org/2002/xforms" 
    xmlns:xs="http://www.w3.org/2001/XMLSchema" 
    xmlns:ev="http://www.w3.org/2001/xml-events" >
    <head>
       <title>Edit Dublin Core Item</title>
        {style:import-xsltforms()}
       <style type="text/css">
       <![CDATA[
          /* this is how you change the dimensions of the form elements */
          .title .xforms-value {width: 50ex;}
          .description .xforms-value {
           
                height: 5em;
                width: 600px;
           }
       ]]>
       </style>
       <xf:model>
           <!-- this line loads either the new instance or the current data file into the form model -->
           <xf:instance xmlns="" src="{$file}" id="save-data"/>
           <xf:bind nodeset="instance('save-data')/date" type="xs:date"/>
           <xf:submission id="save" method="post" action="{if ($new='true') then ('save-new.xq') else ('update.xq')}" instance="my-task" replace="all"/>
       </xf:model>
    </head>
    <body>
    {style:header()}
    {style:breadcrumb()} &gt;
      <a href="../index.xq">Dublin Core Home</a>
      &gt; <a href="../views/list-items.xq">List all Items</a>
    <h2>Edit Dublin Core Item</h2>
    
    <xf:submit submission="save">
       <xf:label>Save</xf:label>
    </xf:submit>
    
    <div class="block-form">
    
     {if ($id)
        then (
           <xf:output ref="id" class="id">
               <xf:label>ID:</xf:label>
           </xf:output>
        ) else ()}
       
       <xf:input ref="title" class="title">
           <xf:label>Title:</xf:label>
           <xf:hint>A name given to the resource.</xf:hint>
       </xf:input>
       <xf:input ref="creator">
           <xf:label>Creator:</xf:label>
           <xf:hint>An entity primarily responsible for making the resource.</xf:hint>
       </xf:input>
       <xf:input ref="subject">
           <xf:label>Subject:</xf:label>
           <xf:hint>The topic of the resource.</xf:hint>
       </xf:input>
       <xf:textarea ref="description" class="description">
           <xf:label>Description:</xf:label>
           <xf:hint>An account of the resource.</xf:hint>
       </xf:textarea>
       
       <xf:input ref="publisher">
           <xf:label>Publisher:</xf:label>
           <xf:hint>An entity responsible for making the resource available.</xf:hint>
       </xf:input>
       
       <xf:input ref="contributor">
           <xf:label>Contributor:</xf:label>
           <xf:hint>An entity responsible for making contributions to the resource.</xf:hint>
       </xf:input>
       
       <xf:input ref="date">
           <xf:label>Date:</xf:label>
           <xf:hint>A point or period of time associated with an event in the lifecycle of the resource</xf:hint>
       </xf:input>
       
       <xf:input ref="type">
           <xf:label>Type:</xf:label>
           <xf:hint>The nature or genre of the resource.</xf:hint>
       </xf:input>
       
       <xf:input ref="format">
           <xf:label>Format:</xf:label>
           <xf:hint>The file format, physical medium, or dimensions of the resource.</xf:hint>
       </xf:input>
       
       <xf:input ref="identifier">
           <xf:label>Identifier:</xf:label>
           <xf:hint>An unambiguous reference to the resource within a given context.</xf:hint>
       </xf:input>

       <xf:input ref="source">
           <xf:label>Source:</xf:label>
           <xf:hint>A related resource from which the described resource is derived.</xf:hint>
       </xf:input>
       
       <xf:select1 ref="language">
           <xf:label>Language:</xf:label>
           <xf:hint>The natural language of the resource.</xf:hint>
           <xf:item>
               <xf:label>English</xf:label>
               <xf:value>english</xf:value>
           </xf:item>
           <xf:item>
               <xf:label>French</xf:label>
               <xf:value>french</xf:value>
           </xf:item>
           <xf:item>
               <xf:label>German</xf:label>
               <xf:value>german</xf:value>
           </xf:item>
       </xf:select1>
       
       <xf:input ref="relation">
           <xf:label>Relation:</xf:label>
           <xf:hint>A related resource.</xf:hint>
       </xf:input>
       
       <xf:input ref="coverage">
           <xf:label>Coverage:</xf:label>
           <xf:hint>The spatial or temporal topic of the resource, 
           the spatial applicability of the resource, or the jurisdiction under which the resource is relevant.</xf:hint>
       </xf:input>
       
       <xf:input ref="rights">
           <xf:label>Rights:</xf:label>
           <xf:hint>Information about rights held in and over the resource.</xf:hint>
       </xf:input>
       
       </div>
       
       <xf:submit submission="save">
           <xf:label>Save</xf:label>
       </xf:submit>
       {style:footer()}
    </body>
</html>

let $xslt-pi := processing-instruction xml-stylesheet {'type="text/xsl" href="/exist/rest/db/xforms/xsltforms/xsltforms.xsl"'}

(: let $debug := processing-instruction xsltforms-options {'debug="yes"'} :)

return ($xslt-pi, $form)