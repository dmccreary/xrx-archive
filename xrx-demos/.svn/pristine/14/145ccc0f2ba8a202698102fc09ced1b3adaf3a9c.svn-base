xquery version "1.0";

import module namespace style = "http://danmccreary.com/style" at "/db/dma/modules/style.xqm";

(: Document namespaces declarations :)

declare namespace xf="http://www.w3.org/2002/xforms";
declare namespace ev="http://www.w3.org/2001/xml-events";
declare namespace xhtml="http://www.w3.org/1999/xhtml";


let $title := 'Moving Items Between Lists'

let $style :=
<xhtml:style type="text/css">
    <![CDATA[
        @namespace xf url("http://www.w3.org/2002/xforms");
        .left, .middle, .right {border: solid gray 1px; background-color: lavender;}
        .xforms-repeat-item-selected {color: blue; background-color: white;}
    ]]>
 </xhtml:style>

let $model :=
<xf:model>
    <xf:instance id="save-data" xmlns="">
     <data>
        <left-list>
           <item>Item One</item>
           <item>Item Two</item>
           <item>Item Three</item>
           <item>Item Four</item>
           <item>Item Five</item>
         </left-list>
         <right-list>
            <item>Item Six</item>
            <item>Item Seven</item>
            <item>Item Eight</item>
            <item>Item Nine</item>
            <item>Item Ten</item>
         </right-list>
     </data>
    </xf:instance>
</xf:model>
        
let $content :=
<div class="content last">
    <p>Select an item from either list and then click "Move Right" or "Move Left".</p>
    <div class="span-12 last">
    
       <div class="span-12">
       <div class="left span-3">
         <h3>Left</h3>
         <xf:repeat nodeset="instance('save-data')/left-list/item" id="left-repeat">
            <xf:output ref="."/>
         </xf:repeat>
     
        <xf:output value="index('left-repeat')">
           <xf:label>Left Index: </xf:label>
        </xf:output>
      </div>


     <div class="middle span-3">
        <xf:trigger>
            <xf:label>Move &gt; Right</xf:label>
            <xf:action ev:event="DOMActivate">
               <xf:insert nodeset="instance('save-data')/right-list/item" 
                          origin="instance('save-data')/left-list/item[index('left-repeat')]" 
                          at="last()" position="after" />
               <xf:delete nodeset="instance('save-data')/left-list/item[index('left-repeat')]" />  
        </xf:action>
        </xf:trigger>
        <xf:trigger>
            <xf:label>Move &lt; Left</xf:label>
            <xf:action ev:event="DOMActivate">
               <xf:insert nodeset="instance('save-data')/left-list/item" 
                          origin="instance('save-data')/right-list/item[index('right-repeat')]" 
                          at="last()" position="after" />
               <xf:delete nodeset="instance('save-data')/right-list/item[index('right-repeat')]" />
               </xf:action>
        </xf:trigger>
     </div>

     <div class="right span-3">
        <h3>Right</h3>
        <xf:repeat nodeset="instance('save-data')/right-list/item" id="right-repeat">
           <xf:output ref="."/>
        </xf:repeat>
        
         <xf:output value="index('right-repeat')">
           <xf:label>Right Index: </xf:label>
         </xf:output>
     </div>
     
     </div>
   </div>
   <br/><br/><br/><br/><br/><br/><br/><br/><br/>
</div>
    
return style:assemble-form($title, (), $style, $model, $content, true())