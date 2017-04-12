xquery version "1.0";

import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";

(: Document namespaces declarations :)

declare namespace xf="http://www.w3.org/2002/xforms";
declare namespace ev="http://www.w3.org/2001/xml-events";
declare namespace xhtml="http://www.w3.org/1999/xhtml";


let $title := 'Moving Items Between Lists'

let $model :=
<xf:model>

<xf:instance id="save-data" xmlns="">
<data>
  <myleftdata/>
  <myrightdata/>
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
      <style type ="text/css"><![CDATA[
      .right {
         position: absolute; 
         top: 149px;
         margin-left: 200px;}
       
       .center {
          position: absolute;
          top: 180px;
          margin-left: 85px;
          }
  
      ]]></style>
    
    
      <div class="left">
       <xf:select ref="instance('save-data')/myleftdata" appearance = "full">
           <xf:label>List 1</xf:label>
           <xf:itemset nodeset="instance('codes')/left-list/item">
               <xf:label ref="."/>
               <xf:value ref="."/>
            </xf:itemset>
       </xf:select>
      </div>
      <div class="center">      
       <xf:trigger>
            <xf:label>Move Right</xf:label>
            <xf:action ev:event="DOMActivate">
               <xf:insert
                    origin="instance('codes')/left-list/item"
                    nodeset="instance('codes')/right-list/item"/>
            </xf:action>
       </xf:trigger>     
       <br/>
        <xf:trigger>
            <xf:label>Move Left</xf:label>
       </xf:trigger>  
       </div>
           
       <div class="right">
       <xf:select ref="instance('save-data')/myrightdata"  appearance = "full">
           <xf:label>List 2</xf:label>
            <xf:itemset nodeset="instance('codes')/right-list/item">
               <xf:label ref="."/>
               <xf:value ref="."/>
            </xf:itemset>
       </xf:select>
       </div>
           
    </div>
    
return style:assemble-form($title, (), (), $model, $content, true())