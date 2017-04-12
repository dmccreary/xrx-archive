xquery version "1.0";
import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";
declare namespace xf="http://www.w3.org/2002/xforms";
declare namespace ev="http://www.w3.org/2001/xml-events";

let $title := 'Edit Pattern'
let $new := request:get-parameter('new', '')
let $id := request:get-parameter('id', '')
 
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
        then 'new-instance.xml'
        else concat('get-instance.xq?id=', $id)
     
     let $image-path := concat($app-collection, '/images/', doc($file)/Pattern/Image/text())
     
let $model :=
    <xf:model>
       <xf:instance xmlns="" id="save-data" src="{$file}"/>
            
        <xf:instance xmlns="" id="views">
            <data>
                <pattern-delete-trigger/>
                <rule-delete-trigger/>
            </data>
        </xf:instance>
        
        <xf:instance xmlns="" id="code-tables" src="all-codes.xq"/>
        
        <xf:submission id="save" method="post" 
            action="{if ($new) then 'save-new.xq' else 'update.xq'}" 
            instance="save-data" replace="all"/>
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
          
        <xf:input ref="instance('save-data')/PatternName" class="PatternName">
            <xf:label>Pattern Name:</xf:label>
        </xf:input>
        
        <xf:input ref="instance('save-data')/Classifier"  class="Classifier">
            <xf:label>Classifier:</xf:label>
        </xf:input>
        
        <xf:input ref="instance('save-data')/Image" class="Image">
        
             <xf:label>Image:</xf:label>
             <img src="{$image-path}" alt="Image"/>
        </xf:input>
         
        <xf:textarea ref="instance('save-data')/Description" class="Description">
            <xf:label>Descritpion:</xf:label>
        </xf:textarea>

        <xf:textarea ref="instance('save-data')/Question"   class="Question">
            <xf:label>Question:</xf:label>
        </xf:textarea>
        
       <xf:textarea ref="instance('save-data')/Answer"   class="Answer">
            <xf:label>Answer:</xf:label>
        </xf:textarea>

       <xf:textarea ref="instance('save-data')/Context"   class="Context">
            <xf:label>Context:</xf:label>
        </xf:textarea>
        
       <xf:textarea ref="instance('save-data')/NoteText"   class="NoteText">
            <xf:label>Notes:</xf:label>
        </xf:textarea>
        
        <xf:input ref="instance('save-data')/Reference"   class="Reference">
            <xf:label>Reference:</xf:label>
        </xf:input>
        </div>
        
        <table>
           <thead>
              <tr>
                 <th>Project</th>
                 <th>Usage Description</th>
              </tr>
           </thead>
        </table>
         <xf:repeat id="usage-repeat" nodeset="instance('save-data')/Usages/Usage">
                <xf:select1 ref="ProjectCode">
                   <xf:itemset nodeset="instance('code-tables')/code-table[code-table-name='ProjectCode']/items/item">
                      <xf:label ref="label"/>
                      <xf:value ref="value"/>
                   </xf:itemset>
                 </xf:select1>
                <xf:input ref="ProjectUsageText" class="ProjectUsageText" id="ProjectUsageText">
                </xf:input>
                <xf:input ref="ProjectReferenceURL" class="ProjectReferenceURL" id="ProjectReferenceURI">
                    <xf:label>Reference:</xf:label>
                    <xf:hint>A link to a document that describes how this was used on the project.</xf:hint>
                </xf:input>
                <xf:trigger id="usage-delete-trigger" class="inline-delete">
                    <xf:label>Delete Usage</xf:label>
                    <xf:delete nodeset="instance('save-data')/Usages/Usage[index('usage-repeat')]" ev:event="DOMActivate"/>
                </xf:trigger>
            </xf:repeat>
            <xf:trigger>
                <xf:label>Insert New Use</xf:label>
                <xf:action ev:event="DOMActivate">
                    <xf:insert nodeset="instance('save-data')/Usages/Usage" at="last()" position="after"/>
                    <xf:setvalue ref="instance('save-data')/Usages/Usage[index('usage-repeat')]" value=""/>
                </xf:action>
            </xf:trigger>
        
        <xf:trigger appearance="minimal" class="url">
            <xf:label>Test Link: <xf:output ref="instance('save-data')/Reference" class="link"/></xf:label>
            <xf:action ev:event="DOMActivate">
              <xf:load ref="instance('save-data')/Reference"/>
            </xf:action>
        </xf:trigger>
       <br/>
       <xf:submit submission="save">
            <xf:label>Save</xf:label>
        </xf:submit>
    </div>
    
return style:assemble-form($title, (), (), $model, $content, true())