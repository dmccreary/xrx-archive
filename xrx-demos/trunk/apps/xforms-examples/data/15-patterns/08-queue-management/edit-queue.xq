xquery version "1.0";
import module namespace style = "http://danmccreary.com/style" at "/db/dma/modules/style.xqm";

declare namespace xf="http://www.w3.org/2002/xforms";
declare namespace ev="http://www.w3.org/2001/xml-events";
declare namespace xhtml="http://www.w3.org/1999/xhtml";

let $title := 'Queue Manager'

let $style := ()

let $model :=
<xf:model>
    <xf:instance id="save-data" xmlns="">
    <queue>
       <item>
          <id>1</id>
          <title>Item One Title</title>
       </item>
       <item>
          <id>2</id>
          <title>Item Two Title</title>
       </item>
       <item>
          <id>3</id>
          <title>Item Three Title</title>
       </item>
       <item>
          <id>4</id>
          <title>Item Four Title</title>
       </item>
       <item>
          <id>5</id>
          <title>Item Five Title</title>
       </item>
    </queue>
    </xf:instance>
    
    <xf:instance xmlns="" id="views">
        <data>
            <delete-topic-trigger/>
            <tmp/>
        </data>
    </xf:instance>
    
    <xf:bind id="delete-topic-trigger" nodeset="instance('views')/delete-topic-trigger" 
        relevant="instance('save-data')/item[2]"/>
        
</xf:model>
    

let $content := 
<div class="content">
<link type="text/css" rel="stylesheet" href="style.css"/>
<p>Note that the operation currently only works on the highlighted row, not the row you select a button on.</p>

<xf:repeat nodeset="instance('save-data')/item" id="id-repeat">
  <div class="row1">
     <span class="row">
          <xf:output ref="title" class="title"/>              
     </span>
     <xf:input ref="id" class="id"/> 
    
    <xf:trigger>
        <xf:label><img src="images/up.png" alt="Move Up" height="23" width="23"></img></xf:label>
        <xf:action ev:event="DOMActivate">
            <xf:setvalue ref="instance('views')/tmp" value="index('id-repeat')"/> 
            <xf:insert origin="instance('save-data')/item[index('id-repeat')]" 
                       nodeset="instance('save-data')/item" at="index('id-repeat')-1" position="before"/>
           <xf:delete nodeset="instance('save-data')/item[instance('views')/tmp +1]"/>  
        </xf:action>
    </xf:trigger>
    
    <xf:trigger>
        <xf:label><img src="images/down.png" alt="Move Down" height="23" width="23"></img></xf:label>
        <xf:action ev:event="DOMActivate">
             <xf:setvalue ref="instance('views')/tmp" value="index('id-repeat')"/> 
            <xf:insert origin="instance('save-data')/item[index('id-repeat')]" 
                       nodeset="instance('save-data')/item" at="index('id-repeat') +1"/>
            <xf:delete nodeset="instance('save-data')/item[instance('views')/tmp]"/>   
        </xf:action>
    </xf:trigger>
    
    <xf:trigger>
        <xf:label><img src="images/top.png" alt="Move to Top" height="23" width="23"></img></xf:label>
        <xf:action ev:event="DOMActivate">
            <xf:setvalue ref="instance('views')/tmp" value="index('id-repeat')"/>   
            <xf:insert origin="instance('save-data')/item[index('id-repeat')]" nodeset="instance('save-data')/item[1]" at="1" position="before"/>          
            <xf:delete nodeset="instance('save-data')/item[instance('views')/tmp + 1]"/> 
        </xf:action>
    </xf:trigger>
    
     <xf:trigger bind="delete-topic-trigger">
        <xf:label>Delete</xf:label>
        <xf:delete nodeset="instance('save-data')/item[index('id-repeat')]" ev:event="DOMActivate"/>
     </xf:trigger>  
   </div>  
</xf:repeat>  
       
</div>
         
return style:assemble-form($title, (), $style, $model, $content, true())