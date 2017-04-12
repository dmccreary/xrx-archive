xquery version "1.0";

import module namespace style='http://mdr.crossflow.com/style' at '/db/crossflo/modules/style.xq';
declare namespace xhtml="http://www.w3.org/1999/xhtml";
(: XQuery to construct an XForm for either a new item or update item :)
declare option exist:serialize "method=xhtml media-type=application/xhtml+xml indent=yes"; 

let $app-collection := style:app-base-uri()
let $code-table-collection := concat($app-collection, '/code-tables')

let $code-tables := collection($code-table-collection)/code-table

return
<html xmlns="http://www.w3.org/1999/xhtml" 
xmlns:xf="http://www.w3.org/2002/xforms" 
xmlns:ev="http://www.w3.org/2001/xml-events">
   <head>
      <title>XForms Selection List Tester</title>
      {style:import-css()}
      <link type="text/css" rel="stylesheet" href="block-form.css"/>
      <xf:model>
         <!-- This instance holds the value of each code -->
         <xf:instance xmlns="" id="save-data" src="">
            <data>
               {for $code-table in $code-tables
                 return
                    element {$code-table/code-table-name/text()} {$code-table/items/item[1]/value/text()}}
            </data>
         </xf:instance>
         
      </xf:model>
   </head>
   <body>
      {style:header()}
      {style:breadcrumb()}
      <h1>Sample with a Model in the XForm</h1>
      {for $code-table in $code-tables
         let $code-table-name := $code-table/*:code-table-name/text()
      return
         <xf:select1 ref="{$code-table-name}">
            <xf:label>{$code-table-name}: </xf:label>
            {for $item in $code-table/*:items/*:item
              return
                 <xf:item>
                    <xf:label>{$item/*:label/text()}</xf:label>
                    <xf:value>{$item/*:value/text()}</xf:value>
                 </xf:item>}
            <xf:hint>{$code-table/*:definition/text()}</xf:hint>
         </xf:select1>
      }

      {style:footer()}
   </body>
</html>
