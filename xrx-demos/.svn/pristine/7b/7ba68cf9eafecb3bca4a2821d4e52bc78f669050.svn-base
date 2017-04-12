xquery version "1.0";

import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";
declare namespace xf="http://www.w3.org/2002/xforms";
declare namespace xforms="http://www.w3.org/2002/xforms";
declare namespace ev="http://www.w3.org/2001/xml-events";

declare default element namespace "http://www.w3.org/1999/xhtml";

let $title := 'Email Message Classification Editor'
let $new := request:get-parameter('new', '')
let $id := request:get-parameter('id', '')
let $user := xmldb:get-current-user()
return
(: check for required parameters :)
if (not($new or $id))
    then (
    <error>
        <message>Parameter "new" and "id" are both missing.  One of these two arguments is required for form.</message>
    </error>)
    else
    
    let $file := if ($new)
        then 'new-instance.xml'
        else concat('../views/get-instance.xq?id=', $id)

let $model :=
    <xf:model>
       <xf:instance id="save-data" src="{$file}"/>
       <xf:instance xmlns="" id="code-tables" src="all-codes.xq"/>
            
       <xf:submission id="save-submission" method="post"
          action= "{if ($new='true') then ('save-message.xq') else ('update.xq')}" instance="save-data" replace="all"/>
    </xf:model>

let $content :=
<div class="content">
   <div class="block-form">
 
        <xf:output ref="headers/date">
           <xf:label>Date: </xf:label>
        </xf:output>
        
        <xf:output ref="headers/from/address">
           <xf:label>From: </xf:label>
        </xf:output>
        
        <xf:output ref="headers/to/address">
           <xf:label>To: </xf:label>
        </xf:output>
        
        <xf:output ref="headers/subject">
           <xf:label>Subject: </xf:label>
        </xf:output>
        
        <xf:select1 ref="headers/categories/category" >
        <xf:label>Categories: </xf:label>
             <xf:itemset nodeset="instance('code-tables')/code-table[code-table-name='message-classification-code']/items/item">
                 <xf:label ref="label"/>
                 <xf:value ref="value"/>
             </xf:itemset>
         </xf:select1>
   </div>
   
        <xf:submit submission="save-submission">
          <xf:label>Save</xf:label>
        </xf:submit>

        
        <br/>
        <xf:output ref="body/text">
           <xf:label>Message: </xf:label>
        </xf:output>
</div>

return style:assemble-form($title, (), (), $model, $content, true())
