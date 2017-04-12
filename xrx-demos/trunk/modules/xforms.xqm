xquery version "1.0";

module namespace xfm = "http://danmccreary.com/xforms";

declare namespace xf="http://www.w3.org/2002/xforms";
declare namespace ev="http://www.w3.org/2001/xml-events";

(: general utilities functions for XForms modules :)

declare function xfm:resources() as node() {
<fieldset>
    <legend>Resources</legend>
    <xf:repeat nodeset="instance('save-data')/resources/resource" id="resource-repeat">     
    
         <xf:label>Resource:</xf:label>
               
               <xf:label>Resource Name: </xf:label>                   
                  <xf:input ref="resource-name" class="name">
               </xf:input>
               
               <br/>
               
            <xf:select1 ref="resource-type">         
               <xf:label>Resource Type:  </xf:label>
               <xf:itemset nodeset="instance('code-tables')/code-table[name = 'resource-type-code']/items/item">
                  <xf:label ref="label"/>
                  <xf:value ref="value"/>
                </xf:itemset>
             </xf:select1>
             
             <br/>
             
             <xf:input ref="resource-url" class="url">
                <xf:label>Resource URL:  </xf:label>
             </xf:input><br/>
     
            <xf:trigger>
                <xf:label>Delete Resource</xf:label>
                <xf:delete nodeset="instance('save-data')/resources/resource[index('resource-repeat')]" ev:event="DOMActivate"/>
            </xf:trigger>
            
        </xf:repeat>
        
        <xf:trigger>
             <xf:label>Add New Resource</xf:label>
             <xf:action ev:event="DOMActivate">
                <xf:insert nodeset="instance('save-data')/resources/resource" at="last()" position="after"/>
               <xf:setvalue ref="instance('save-data')/resources/resource[index('resource-repeat')]/resource-name" value=""/>
               <xf:setvalue ref="instance('save-data')/resources/resource[index('resource-repeat')]/resource-type" value=""/>
               <xf:setvalue ref="instance('save-data')/resources/resource[index('resource-repeat')]/resource-url" value=""/>
            </xf:action>
        </xf:trigger>
</fieldset>
};