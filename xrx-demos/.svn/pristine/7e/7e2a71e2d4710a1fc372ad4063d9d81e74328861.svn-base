xquery version "1.0";

import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";

(: Document namespaces declarations :)

declare namespace xf="http://www.w3.org/2002/xforms";
declare namespace ev="http://www.w3.org/2001/xml-events";
declare namespace xhtml="http://www.w3.org/1999/xhtml";


let $title := 'Moving Items Between Lists'

let $model :=
<xf:model>

<xf:instance id="save" xmlns="">
<data>
  <myleftdata/>
  <myleftdata/>
</data>
</xf:instance>

<xf:instance id="codes" xmlns="">
<codes>
<left-list>
   <item>one</item>
   <item>two</item>
   <item>three</item>
   <item>four</item>
   <item>five</item>
</left-list>
<right-list>
   <item>six</item>
   <item>seven</item>
   <item>eight</item>
   <item>nine</item>
   <item>ten</item>
</right-list>
</codes>
</xf:instance>
</xf:model>
  
let $content :=

    <div class="content">
      <div class="left">
       <xf:select ref="instance('save-data')/myleftdata" appearance = 'full'>
           <xf:label>List 1:</xf:label>
       </xf:select>
      </div>
      <div class="center">      
       <xf:trigger>
            <xf:label>To</xf:label>
       </xf:trigger>     
       <br/>
        <xf:trigger>
            <xf:label>From</xf:label>
       </xf:trigger>  
       </div>
           
       <div class="right">
       <xf:select ref="instance('save-data')/myrightdata"  apperance = 'full'>
           <xf:label>List 2</xf:label>
       </xf:select>
       </div>
           
    </div>
    
return style:assemble-form($title, (), (), $model, $content, true())