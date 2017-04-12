xquery version "1.0";
import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";

declare namespace xf="http://www.w3.org/2002/xforms";
declare namespace ev="http://www.w3.org/2001/xml-events";
declare namespace xhtml="http://www.w3.org/1999/xhtml";


let $new := request:get-parameter('new', '')
let $id := request:get-parameter('id', '')
let $title :='Edit Help Item' 

return
(: check for required parameters :)
if (not($new or $id))
    then (
    <error>
        <message>Parameter "new" and "id" are both missing.  One of these two arguments is required for form.</message>
    </error>)
    else
    
let $app-collection := $style:db-path-to-app
let $data-collection := concat($app-collection, '/data')
let $code-table-collection := concat($app-collection, '/code-tables')


     (: put in the appropriate file name :)
     let $file := if ($new)
        then ('new-instance.xml')
        else (concat('get-instance.xq?id=', $id))
  


let $model :=
      <xf:model>
      
        <!-- this line loads either the new instance or the current data file into the form model -->
         <xf:instance xmlns="" src="{$file}" id="save-data"/> 
         
          <xf:instance xmlns="" src="../code-tables/category-codes.xml" id="code-tables"/>
          <xf:instance xmlns="" src="../code-tables/resource-type-codes.xml" id="code-table-resource"/>
         
        <!-- Instance to hold conditional view bindings. -->
            <xf:instance xmlns="" id="views">
                <data>
                    <resource-delete-trigger/>
                </data>
            </xf:instance>

         <!-- binds for add/delete trigger visability -->
         <xf:bind id="resource-delete-trigger" nodeset="instance('views')/resource-delete-trigger" 
                                          relevant="instance('save-data')/resources/resource[2]"/>
        
        <xf:submission id="save" method="post" action="{if ($new='true') then ('save-new.xq') else ('update.xq')}" instance="my-task" replace="all"/>
       </xf:model>

 let $content :=
 <div class="content">
    <div class="block-form">
        {if ($id)
           then (
           <xf:output ref="id" class="id">
               <xf:label>ID:</xf:label>
           </xf:output>
        ) else ()}
    

        <xf:input ref="name" class="name">
            <xf:label>Name : </xf:label>
        </xf:input>
        
     <xf:select1 ref="category"  class="category">     
         <xf:label>Category : </xf:label>
          <xf:itemset nodeset="instance('code-tables')//items/item">
             <xf:label ref="label"/>
             <xf:value ref="value"/>
          </xf:itemset> 
     </xf:select1>
        
        <xf:textarea ref="help-text" class="help-text">
            <xf:label>Help Text: </xf:label>
        </xf:textarea>
        
    </div>
    
      <fieldset class="span-10">
      <legend>Resources</legend>
            
            <xf:repeat nodeset="instance('save-data')/resources/resource" id="resource-repeat">     
                   <xf:label>Name: </xf:label>                   
                   <xf:input ref="resource-name" class="resource-name"></xf:input><br/>
                   
                <xf:select1 ref="resource-type"  class="resource-type">         
                   <xf:label>Type: </xf:label>
                        <xf:itemset nodeset="instance('code-table-resource')//items/item">
                         <xf:label ref="label"/>
                         <xf:value ref="value"/>
                        </xf:itemset>
                </xf:select1>
                   <br/>
                   <xf:label>URL: </xf:label>
                   <xf:input ref="resource-url" class="resource-url"></xf:input><br/>
              
                <xf:trigger bind="resource-delete-trigger">
                    <xf:label>Delete Resource</xf:label>
                    <xf:delete nodeset="instance('save-data')/resources/resource[index('resource-repeat')]" ev:event="DOMActivate"/>
                </xf:trigger>
                <br/><br/>              
            </xf:repeat>
            <xf:trigger>
                <xf:label>Add Resource</xf:label>
                <xf:action ev:event="DOMActivate">
                    <xf:insert nodeset="instance('save-data')/resources/resource" at="last()" position="after"/>
                    <xf:setvalue ref="instance('save-data')/resources/resource[last()]/resource-name" value="''"/>
                    <xf:setvalue ref="instance('save-data')/resources/resource[last()]/resource-type" value="''"/>
                   <xf:setvalue ref="instance('save-data')/resources/resource[last()]/resource-url" value="''"/>
                </xf:action>
            </xf:trigger>
 </fieldset>
 
        {style:revision-status($id)}
        <xf:submit submission="save">
        <xf:label>Save</xf:label>
        </xf:submit>

</div>

return 
    style:assemble-form($title, (), (), $model, $content, true())
