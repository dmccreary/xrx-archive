xquery version "1.0";
import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";
declare namespace xrx="http://code.google.com/p/xrx";

(: Edit AppInfo File :)

declare namespace xf="http://www.w3.org/2002/xforms";
declare namespace ev="http://www.w3.org/2001/xml-events";
declare namespace xhtml="http://www.w3.org/1999/xhtml";

let $new := request:get-parameter('new', '')
let $id := request:get-parameter('id', '')

return
(: check for required parameters :)
    if (not($new or $id)) then 
        <error>
            <message>Parameter "new" and "id" are both missing.  One of these two arguments is required for form.</message>
        </error>
    else

(: proceed :)

let $title := concat('Edit ', $id)
let $app-collection := $style:db-path-to-app
let $code-table-collection := concat($app-collection, '/code-tables')

(: put in the appropriate file name :)
let $file := 
    if ($new) then 
        'new-instance.xml'
    else 
        concat('get-instance.xq?id=', $id)

let $cancel :=
   if ($new)
      then '../'
      else  concat('../views/view-item.xq?id=', $id)

let $style :=
<xhtml:style language="text/css">
    <![CDATA[
        @namespace xf url("http://www.w3.org/2002/xforms");
        .block-form xf|label {
            width: 25ex;
        }
        
        /* make sure the select and select1 items don't float to the left */
        xf|select xf|item, xf|select1 xf|item {
            margin-left: 26ex;
        }

        .uri .xforms-value {width: 90ex;}
        .description textarea {
            height: 10ex;
            width:630px;
        }
        .note textarea {
            height: 10ex;
            width:630px;
        }
    ]]>
 </xhtml:style>

let $model :=
    <xf:model>
        <xf:instance id="save-data" src="{$file}" xmlns="http://code.google.com/p/xrx"/>
        
        <xf:instance id="code-tables" src="all-codes.xq" xmlns=""/>
        
        <xf:instance xmlns="" id="views">
            <data>
               <delete-classifier-trigger/>
            </data>
        </xf:instance>
        
        <xf:bind id="delete-classifier-trigger" nodeset="instance('views')/delete-classifier-trigger" 
            relevant="instance('save-data')/xrx:classifiers/xrx:classifier[2]"/>
        
        <xf:submission id="save" method="post" action="{if ($new='true') then ('save-new.xq') else ('update.xq')}" 
            instance="save-data" replace="all"/>
            
    </xf:model>
        
let $content :=
    <div class="content">
    
        <xf:submit submission="save">
           <xf:label>Save</xf:label>
        </xf:submit>
       
        <div class="block-form">
    
            { (: only display the ID if we are not creating a new item :)
            if ($id) then 
                <xf:output ref="xrx:app-id" class="id">
                   <xf:label>ID:</xf:label>
                </xf:output>
            else ()}
            
           
            <xf:input ref="xrx:app-name">
                <xf:label>App Name:</xf:label>
            </xf:input>
            
            <xf:input ref="xrx:app-version-id">
                <xf:label>App Version:</xf:label>
            </xf:input>
            
            <xf:textarea ref="xrx:app-description-text" class="description">
                <xf:label>App Description:</xf:label>
            </xf:textarea>
            
            <xf:input ref="xrx:app-creator-text">
                <xf:label>App Creator:</xf:label>
            </xf:input>
            
            <xf:select1 ref="xrx:app-license-type-code">
                <xf:label>License Type:</xf:label>
                <xf:itemset nodeset="instance('code-tables')/code-table[name='license-type-code']/items/item">
                   <xf:label ref="label"/>
                   <xf:value ref="value"/>
                </xf:itemset>
            </xf:select1>
            
            <xf:input ref="xrx:app-license-uri" class="uri">
                <xf:label>App License URI:</xf:label>
            </xf:input>
            
             <xf:input ref="xrx:breadcrumb-label">
                <xf:label>Breadcrumb Label:</xf:label>
             </xf:input>
             
             <xf:input ref="xrx:data-collection">
                <xf:label>Data Collection:</xf:label>
             </xf:input>
           
           <xf:select1 ref="status"  class="status">
           <xf:label>Pub Status:</xf:label>
                 <xf:itemset nodeset="instance('code-tables')/code-table[name='publish-status-code']/items/item">
                   <xf:label ref="label"/>
                   <xf:value ref="value"/>
                </xf:itemset>
           </xf:select1>
       
        </div> <!-- end of block form layout -->
       
       <xf:repeat nodeset="instance('save-data')/xrx:classifiers/xrx:classifier" id="classifier-repeat">
           <xf:select1 ref=".">
                <xf:label>classifier:</xf:label>
                <xf:itemset nodeset="instance('code-tables')/code-table[name='app-classifier-code']/items/item">
                   <xf:label ref="label"/>
                   <xf:value ref="value"/>
                </xf:itemset>
           </xf:select1>
           
           <xf:trigger bind="delete-classifier-trigger">
                   <xf:label>Delete</xf:label>
                   <xf:delete nodeset="instance('save-data')/xrx:classifiers/xrx:classifier[index('classifier-repeat')]" ev:event="DOMActivate"/>
           </xf:trigger>
       </xf:repeat>
       
       <xf:trigger>
            <xf:label>Add classifier</xf:label>
            <xf:action ev:event="DOMActivate">
               <xf:insert nodeset="instance('save-data')/xrx:classifiers/xrx:classifier" at="last()" position="after"/>

               <xf:setvalue ref="instance('save-data')/xrx:classifiers/xrx:classifier[index('classifier-repeat')]" value=""/>
               
            </xf:action>
       </xf:trigger>
      
      <br/>
       
       <xf:submit submission="save">
           <xf:label>Save</xf:label>
       </xf:submit>
       
              
    </div>

let $att := attribute xrx:dummy {'dummy'}
return style:assemble-form($title, $att, $style, $model, $content, true())