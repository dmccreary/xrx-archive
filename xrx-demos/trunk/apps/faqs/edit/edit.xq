xquery version "1.0";
import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";
declare namespace ev="http://www.w3.org/2001/xml-events";
declare namespace xf="http://www.w3.org/2002/xforms";

let $title := 'Edit an FAQ'

let $set-header-1 := response:set-header("Cache-Control", 'no-cache')
let $set-header-2 := response:set-header("pragma", 'no-cache')

let $new := request:get-parameter('new', '')
let $id := request:get-parameter('id', '')
let $user := xmldb:get-current-user()
let $form := 'FAQ Editor'
let $form-version := '0.10'

return
(: check for required parameters :)
if (not($new or $id))
    then (
    <error>
        <message>Parameter "new" and "id" are both missing.  One of these two arguments is required for this web service.</message>
    </error>)
    else
        let $app-collection := $style:db-path-to-app
        let $data-collection := concat($app-collection, '/data')
        
(: put in the appropriate file name :)
let $file := if ($new)
   then ('new-instance.xml')
   else concat('get-instance.xq?id=', $id)

let $model :=
       <xf:model>
           <!-- this line loads either the new instance or the current data file into the form model -->
           <xf:instance xmlns="" src="{$file}" id="my-faq"/>
           
           <xf:instance xmlns="" src="../code-tables/faq-category-codes.xml" id="code-tables"/>
           
           <xf:instance xmlns="" id="views">
               <data>
                  <faq-category-id-delete-trigger/>
               </data>
           </xf:instance>
           
           <!-- only display the trigger if we have a second category -->
            <xf:bind id="faq-category-id-delete-trigger" 
            nodeset="instance('views')/faq-category-id-delete-trigger" 
            relevant="instance('my-faq')/faq-category-id[2]"/>

           <xf:submission id="save" method="post" action="{if ($new='true') then ('save-new.xq') else ('update.xq')}" instance="my-task" replace="all"/>
       </xf:model>

 
let $content :=
<div class="content">

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
    </div>
           
       <xf:repeat id="faq-category-id-repeat" nodeset="instance('my-faq')/faq-category-id">
          <xf:select1 ref=".">
               <xf:label>Classification:</xf:label>
               <xf:hint>A way to classify each FAQ.</xf:hint>
               <xf:itemset nodeset="instance('code-tables')/items/item">
                 <xf:label ref="label"/>
                 <xf:value ref="value"/>
              </xf:itemset>
           </xf:select1>
           
           <xf:trigger bind="faq-category-id-delete-trigger">
               <xf:label>Delete Classification</xf:label>
               <xf:delete nodeset="instance('my-faq')/faq-category-id[index('faq-category-id-repeat')]" ev:event="DOMActivate"/>
           </xf:trigger>          
       </xf:repeat>
       
       
       
       
       <xf:trigger>
           <xf:label>Include in Additional Category</xf:label>
           <xf:action ev:event="DOMActivate">
               <xf:insert nodeset="instance('my-faq')/faq-category-id" at="last()" position="after"/>
               <xf:setvalue ref="instance('my-faq')/faq-category-id[last()]" value="''"/>
           </xf:action>
       </xf:trigger>

<br/>
       <div class="block-form">
               <xf:textarea ref="question" class="question">
                   <xf:label>Question:</xf:label>
               </xf:textarea>
               <br/>
               
               <xf:textarea ref="answer" class="answer">
                   <xf:label>Answer:</xf:label>
               </xf:textarea>
               
               
       </div>
       
       {style:revision-status($id)}
       
     <xf:submit submission="save">
         <xf:label>Save</xf:label>
     </xf:submit>
</div>



return style:assemble-form($title, (), (), $model, $content, true() )