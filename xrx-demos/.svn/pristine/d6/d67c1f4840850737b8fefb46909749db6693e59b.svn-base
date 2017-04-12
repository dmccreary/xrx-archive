xquery version "1.0";

import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";

(: Document namespaces declarations :)

declare namespace xf="http://www.w3.org/2002/xforms";
declare namespace ev="http://www.w3.org/2001/xml-events";
declare namespace xhtml="http://www.w3.org/1999/xhtml";

(: proceed :)

let $title := 'Edit Queue'

(: put in the appropriate file name :)
let $file := 'enrich-queue.xq'

let $style := ()

let $model :=
    <xf:model>
        <xf:instance id="save-data" src="{$file}"/>
        
            <xf:instance xmlns="" id="template">
                <data>           
                    <name/>
                    <priority/>
                </data>
            </xf:instance>
            
            <xf:instance xmlns="" id="views">
                <data>
                    <delete-topic-trigger/>
                    <tmp/>
                </data>
            </xf:instance>
    
    
        <xf:submission id="save" method="post" action="store-queue.xq" 
            instance="save-data" replace="all"/>
        
        <!--
        <xf:bind id="delete-topic-trigger" nodeset="instance('views')/delete-topic-trigger" 
        relevant="instance('save-data')/item[2]"/>
        -->
        
    </xf:model>
        
let $content :=
    <div class="content">
    <link type="text/css" rel="stylesheet" href="style.css"/>
       
       <xf:repeat nodeset="instance('save-data')/item" id="id-repeat">
           <!-- both on the same line -->
           <span class="row">
              <xf:input ref="name" class="name"/> [<xf:output ref="id" class="id"/>]
           </span>
             
            <!-- Up Trigger Version 2 -->
           <xf:trigger>
                <xf:label><img src="../images/up.png" alt="Move Up" height="23" width="23"></img></xf:label>
                
                <!-- this is not working  if="position() != 1 -->
                <xf:action ev:event="DOMActivate">
                    <xf:insert origin="." nodeset="preceding-sibling::item[1]" position="before"/>
                    <xf:delete nodeset="."/>
                </xf:action>
            </xf:trigger>
            
            
            <!-- Down Trigger -->
            
            <xf:trigger>
                <xf:label><img src="../images/down.png" alt="Move Down" height="23" width="23"></img></xf:label>
                
                <!-- this is not working if="position() != last() -->
                <xf:action ev:event="DOMActivate">
                    <xf:insert origin="." nodeset="following-sibling::item[1]" position="after"/>
                    <xf:delete nodeset="."/>
                </xf:action>
            </xf:trigger>
            
            <xf:trigger>
                <xf:label><img src="../images/top.png" alt="Move to Top" height="23" width="23"></img></xf:label>
                <xf:action ev:event="DOMActivate">
                    <xf:setvalue ref="instance('views')/tmp" value="index('id-repeat')"/>   
                    <xf:insert origin="instance('save-data')/item[index('id-repeat')]" nodeset="instance('save-data')/item[1]" at="1" position="before"/>          
                    <xf:delete nodeset="instance('save-data')/item[instance('views')/tmp + 1]"/> 
                </xf:action>
            </xf:trigger>
            
             <!-- bind="delete-topic-trigger" -->
               <xf:trigger >
                   <xf:label>Delete</xf:label>
                   <xf:delete nodeset="." ev:event="DOMActivate"/>
               </xf:trigger>
       </xf:repeat>
       
       <xf:switch>
         <xf:case id="initial">
            <xf:trigger>
                 <xf:label>Add New Item To Queue</xf:label>
                 <xf:action ev:event="DOMActivate">
                    <xf:toggle case="add"/>
                 </xf:action>
            </xf:trigger>
          </xf:case>
          <xf:case id="add">
            <xf:input ref="instance('template')/name">
                <xf:label>Name: </xf:label>
            </xf:input>
            <xf:input ref="instance('template')/priority">
                <xf:label>Priority: </xf:label>
            </xf:input>
            <xf:trigger>
                 <xf:label>Add</xf:label>
                 <xf:action ev:event="DOMActivate">
                    <xf:insert origin="instance('template')/item" 
                       nodeset="instance('save-data')/item[last()]" at="last()" position="after"/>
                    <xf:setvalue ref="instance('save-data')/item[last()]/name"
                                 value="instance('template')/name"/>
                 </xf:action>
            </xf:trigger>
            <xf:trigger>
                 <xf:label>Done</xf:label>
                 <xf:action ev:event="DOMActivate">
                    <xf:toggle case="initial"/>
                 </xf:action>
            </xf:trigger>
          </xf:case>
         </xf:switch>

       
       <!--
       <xf:submit submission="save">
           <xf:label>Save</xf:label>
       </xf:submit>
       -->
       
       <a href="{$file}">View XML</a>

    </div>
    
return style:assemble-form($title, (), $style, $model, $content, true())