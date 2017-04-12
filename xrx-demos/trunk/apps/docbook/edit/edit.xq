xquery version "1.0";

import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";

(: Document namespaces declarations :)

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

let $title := concat('Book Info Edit for Document ID=', $id)
let $app-collection := $style:db-path-to-app
let $code-table-collection := concat($app-collection, '/code-tables')

(: put in the appropriate file name :)
let $file := 
    if ($new) then 
        'new-instance.xml'
    else 
        concat('get-book-info.xq?id=', $id)


let $style :=
<xhtml:style language="text/css">
    <![CDATA[
        @namespace xf url("http://www.w3.org/2002/xforms");
        .block-form xf|label {
            width: 15ex;
        }
        
        /* make sure the select and select1 items don't float to the left */
        xf|select xf|item, xf|select1 xf|item {
            margin-left: 16ex;
        }
        .productname .xforms-value {width: 90ex;}
        .title .xforms-value {width: 90ex;}
        .subject .xforms-value {width: 90ex;}
        .email .xforms-value {width: 90ex;}
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
        <xf:instance xmlns="" id="save-data" src="{$file}"/>
        
        <xf:instance id="code-tables" src="all-codes.xq" xmlns=""/>
        
        <xf:submission id="save" method="post" action="{if ($new='true') then ('save-new.xq') else concat('update.xq?id=', $id) }" 
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
                <xf:output value="{$id}" class="id">
                   <xf:label>ID:</xf:label>
                </xf:output>
            else ()}
            
           
           <xf:input ref="productname" class="productname">
                <xf:label>Product Name:</xf:label>
            </xf:input>
            
            <xf:input ref="title" class="title">
                <xf:label>Title:</xf:label>
            </xf:input>
            
            <xf:input ref="subject" class="subject">
                <xf:label>Subject:</xf:label>
            </xf:input>
            
            <fieldset>
               <legend>Author Information</legend>
                <xf:input ref="author/firstname">
                    <xf:label>First Name:</xf:label>
                </xf:input>
                
                <xf:input ref="author/surname">
                    <xf:label>Last Name:</xf:label>
                </xf:input>
                
                <xf:input ref="author/affiliation/address/email" class="email">
                    <xf:label>E-mail:</xf:label>
                </xf:input>
            </fieldset>
       </div>
            
       <xf:submit submission="save">
           <xf:label>Save</xf:label>
       </xf:submit>
       
       <br/>
       <a href="get-instance.xq?id={$id}">View XML</a>
</div>
    
return style:assemble-form($title, (), $style, $model, $content, true())