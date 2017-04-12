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

let $title := concat('Edit Event ID #', $id)
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
            width: 15ex;
        }
        
        /* make sure the select and select1 items don't float to the left */
        xf|select xf|item, xf|select1 xf|item {
            margin-left: 16ex;
        }

        .uri .xforms-value {width: 90ex;}
        .description textarea {
            height: 20ex;
            width:650px;
        }
        .note textarea {
            height: 10ex;
            width:630px;
        }
        
        }
        .event-location textarea {
            height: 5ex;
            width:650px;
        }
        
        .event-information textarea {
            height: 5ex;
            width:350px;
            
        }
        
        
    ]]>
 </xhtml:style>

let $model :=
    <xf:model>
        <xf:instance id="save-data" src="{$file}"/>
        
        <xf:instance id="code-tables" src="all-codes.xq" xmlns=""/>
        
        <xf:instance xmlns="" id="views">
            <data>
               <delete-category-trigger/>
               <delete-tag-trigger/>
            </data>
        </xf:instance>
        
        <!-- <xf:bind id="delete-category-trigger" nodeset="instance('views')/delete-category-trigger" 
            relevant="instance('save-data')/category[2]"/> -->
                        
        <!-- If there is a second element, make the delete button visible. -->
        <xf:bind id="delete-tag-trigger" nodeset="instance('views')/delete-tag-trigger" 
            relevant="instance('save-data')/tag[2]"/>
        
        <xf:submission id="save" method="post" action="{if ($new='true') then ('save-new.xq') else ('update.xq')}" 
            instance="save-data" replace="all"/>
            
    </xf:model>
        
let $content :=
    <div class="content">
        <div class="block-form">
    
            { (: only display the ID if we are not creating a new item :)
            if ($id) then 
                <xf:output ref="id" class="id">
                   <xf:label>ID:</xf:label>
                </xf:output>
            else ()}
            
           
            <xf:textarea ref="event-location" class="event-location">
                <xf:label>Event Location:</xf:label>
            </xf:textarea>
            
            <xf:input ref="event-date">
                <xf:label>Event Date:</xf:label>
            </xf:input>
            
            <xf:input ref="lat">
                <xf:label>Lat:</xf:label>
            </xf:input>
            
            <xf:input ref="long">
                <xf:label>Long:</xf:label>
            </xf:input>
            
            <xf:input ref="scale">
                <xf:label>Scale:</xf:label>
            </xf:input>
            
            <xf:input ref="Event_Type">
                <xf:label>Event Type:</xf:label>
            </xf:input>
            
             <xf:textarea ref="Shorter_description_for_map" class="event-information">
                <xf:label>Short Description:</xf:label>
             </xf:textarea>
             
             <xf:textarea ref="Excerpt_Description" class="description">
                <xf:label>Description:</xf:label>
            </xf:textarea>
            
             <xf:input ref="Army">
                <xf:label>Army:</xf:label>
             </xf:input>
            
             <xf:input ref="Report_Author">
                <xf:label>Report Author:</xf:label>
            </xf:input>
            
             <xf:input ref="Author_Rank">
                <xf:label>Author Rank:</xf:label>
             </xf:input>
             
              <xf:input ref="Report_or_Article_Date">
                <xf:label>Report Date:</xf:label>
             </xf:input>
             
              <xf:textarea ref="Report_or_Article_Location" class="event-information">
                <xf:label>Report Location:</xf:label>
             </xf:textarea>
             
             <xf:input ref="Report_recipient">
                <xf:label>Report Recipient:</xf:label>
             </xf:input>
                      
           
            <xf:select1 ref="category"  class="category">
                <xf:label>Category:</xf:label>
                <xf:itemset nodeset="instance('code-tables')/code-table[name='category-code']/items/item">
                   <xf:label ref="label"/>
                   <xf:value ref="value"/>
                </xf:itemset>
            </xf:select1>
           
           <xf:select1 ref="status"  class="status">
           <xf:label>Pub Status:</xf:label>
                 <xf:itemset nodeset="instance('code-tables')/code-table[name='publish-status-code']/items/item">
                   <xf:label ref="label"/>
                   <xf:value ref="value"/>
                </xf:itemset>
           </xf:select1>
       
        </div> <!-- end of block form layout -->
       
       <xf:repeat nodeset="instance('save-data')/tag" id="tag-repeat">
           <!-- both on the same line -->
           <xf:input ref=".">
                <xf:label>Tag:</xf:label>
           </xf:input>
           <xf:trigger bind="delete-tag-trigger">
                   <xf:label>Delete</xf:label>
                   <xf:delete nodeset="instance('save-data')/tag[index('tag-repeat')]" ev:event="DOMActivate"/>
           </xf:trigger>
       </xf:repeat>
       
      
      <br/>
      
      {style:revision-status($id)}
       
       <xf:submit submission="save">
           <xf:label>Save</xf:label>
       </xf:submit>
       
              
       <xf:trigger>
         <xf:label>Cancel</xf:label>
          <xf:action ev:event="DOMActivate">
             <xf:load show="replace">
                <xf:resource value="'{$cancel}'"/>
             </xf:load>
          </xf:action>
       </xf:trigger>

    </div>
    
return style:assemble-form($title, (), $style, $model, $content, true())