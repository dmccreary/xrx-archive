xquery version "1.0";
import module namespace style='http://danmccreary.com/style' at '../../../modules/style.xqm';

declare namespace xf="http://www.w3.org/2002/xforms";
declare namespace ev="http://www.w3.org/2001/xml-events";
declare namespace xhtml="http://www.w3.org/1999/xhtml";


let $new := request:get-parameter('new', '')
let $id := request:get-parameter('id', '')
let $title :='Edit Book' 



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

     (: put in the appropriate file name :)
     let $file := if ($new)
        then ('new-instance.xml')
        else (concat('get-instance.xq?id=', $id))
  


let $model :=
      <xf:model>
         <!-- this line loads either the new instance or the current data file into the form model -->
        <xf:instance id="save-data" src="{$file}"/>
         
        <xf:submission id="save" method="post" action="{if ($new='true') then ('save-new.xq') else ('update.xq')}" 
            instance="save-data" replace="all"/>
       </xf:model>

 let $content :=
  
 <div class="content">
    <div class="block-form">
        {if ($id)
           then (
           <xf:output ref="id">
               <xf:label>ID:</xf:label>
           </xf:output>
        ) else ()}
    

        <xf:input ref="title">
            <xf:label>Title : </xf:label>
        </xf:input>
        
        <xf:input ref="author" class="author">
            <xf:label>Author : </xf:label>
        </xf:input>
        
        
        
        <xf:textarea ref="description" class="textarea">
            <xf:label>Description: </xf:label>
        </xf:textarea>
        
        <xf:input ref="format" class="format">
            <xf:label>Format: </xf:label>
        </xf:input>
        
        <xf:input ref="publisher" class="publisher">
            <xf:label>Publisher: </xf:label>
        </xf:input>
        
         <xf:input ref="publish-date" class="publish-date">
            <xf:label>Publish Date: </xf:label>
        </xf:input>
        
        <xf:input ref="license" class="license">
            <xf:label>License: </xf:label>
        </xf:input>
        
        <xf:input ref="list-price" class="list-price">
            <xf:label>List Price: </xf:label>
        </xf:input> 
       
     </div>
     {style:revision-status($id)}
        
  <br/>

        <xf:submit submission="save">
            <xf:label>Save</xf:label>
        </xf:submit>

</div>

return 
    style:assemble-form($title, (), (), $model, $content, true())
