xquery version "1.0";
import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";

(: Document namespaces declarations :)

declare namespace xf="http://www.w3.org/2002/xforms";
declare namespace ev="http://www.w3.org/2001/xml-events";
declare namespace xhtml="http://www.w3.org/1999/xhtml";

let $title := 'Employee Editor'
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
      else  concat('../views/view-item?id=', $id)

let $model :=
<xf:model>
    <!-- this line loads either the new instance or the current data file into the form model -->
    <xf:instance xmlns="" src="{$file}" id="save-data"/>
    
    <xf:bind nodeset="instance('save-data')/EmployeeName" required="true()"/>
    
    <!-- load the code tables from the code tables service -->
    <xf:instance xmlns="" id="code-tables" src="code-tables.xq"/>
    
     <xf:instance xmlns="" id="views">
            <data>
                <classifier-delete-trigger/>
            </data>
      </xf:instance>

    <xf:bind id="classifier-delete-trigger" nodeset="instance('views')/classifier-delete-trigger" 
                                     relevant="instance('save-data')/Classifiers/Classifier[2]"/>
    
    <xf:submission id="save" method="post" action="{if ($new='true') then ('save-new.xq') else ('update.xq')}" instance="my-task" replace="all"/>
</xf:model>

let $style :=
<xhtml:style language="text/css">
<![CDATA[
    @namespace xf url("http://www.w3.org/2002/xforms");
    .block-form xf|label {
        width: 16ex;
    }
    
    /* make sure the select and select1 items don't float to the left */
    xf|select xf|item, xf|select1 xf|item {
        margin-left: 16ex;
    }
    
    .EmployeeName .xforms-value { 
         width: 50ex;
    }

    .uri .xforms-value {width: 90ex;}
    .Notes textarea {
        height: 10ex;
        width:930px;
    }

]]>
</xhtml:style>
       
let $content :=
<div class="content">
    
    <div class="block-form">
     {if ($id)
        then (
           <xf:output ref="id" class="id">
               <xf:label>ID:</xf:label>
           </xf:output>
        ) else ()}
       
       <xf:input ref="Extension" class="Extension">
           <xf:label>Extension:</xf:label>
           <xf:hint>4 or fewer characters.</xf:hint>
       </xf:input>
       
       <xf:input ref="EmployeeName" class="EmployeeName">
           <xf:label>Person Name:</xf:label>
           <xf:hint>Last, first fewer than 50 characters.</xf:hint>
       </xf:input>
       
       <xf:input ref="Title" class="Title">
           <xf:label>Title:</xf:label>
           <xf:hint>Under 50 characters.</xf:hint>
       </xf:input>
       

      <xf:input ref="DirectDial" class="DirectDial">
           <xf:label>Direct Dial:</xf:label>
           <xf:hint>Include country code, area code and dashes</xf:hint>
       </xf:input>
        
      <xf:input ref="CellPhone" class="CellPhone">
           <xf:label>Cell Phone:</xf:label>
           <xf:hint>Include country code, area code and dashes</xf:hint>
       </xf:input>
 
       <xf:input ref="Home" class="Home">
           <xf:label>Home:</xf:label>
           <xf:hint>Include country code, area code and dashes</xf:hint>
       </xf:input>
       
        <xf:input ref="EMail" class="Home">
           <xf:label>Email:</xf:label>
        </xf:input> 
 
       <xf:select1 ref="State">
             <xf:label>State:</xf:label>
             <xf:hint>The location state for this person.</xf:hint>
             <xf:itemset nodeset="instance('code-tables')/code-table[code-table-name='USStateCode']/items/item">
                 <xf:label ref="label"/>
                 <xf:value ref="value"/>
             </xf:itemset>
        </xf:select1>
       
       <xf:select1 ref="EmployeeContractorStatusCode">
             <xf:label>Employment Type:</xf:label>
             <xf:hint>The employment type for this person (employee or contractor).</xf:hint>
             <xf:itemset nodeset="instance('code-tables')/code-table[code-table-name='EmployeeContractorStatusCode']/items/item">
                 <xf:label ref="label"/>
                 <xf:value ref="value"/>
             </xf:itemset>
        </xf:select1>
</div>
<div>


            <xf:group>
               <xf:label>Classifiers:</xf:label><br/>
                  <xf:repeat id="classifier-repeat" nodeset="instance('save-data')/Classifiers/Classifier">
                     <xf:select1 ref="." class="inline-delete" id="classifier-select">
                         <xf:label>Classifier:</xf:label>
                         <xf:hint>A classifiction for each employee.</xf:hint>
                         <xf:itemset nodeset="instance('code-tables')/code-table[code-table-name='EmployeeRoleCode']/items/item">
                             <xf:label ref="label"/>
                             <xf:value ref="value"/>
                         </xf:itemset>
                     </xf:select1>
                     
                     <xf:trigger bind="classifier-delete-trigger" class="inline-delete">
                         <xf:label>Delete Classifier</xf:label>
                         <xf:delete nodeset="instance('save-data')/Classifiers/Classifier[index('classifier-repeat')]" ev:event="DOMActivate"/>
                     </xf:trigger>
                 </xf:repeat>
                 
                 <xf:trigger>
                     <xf:label>Add Classifier</xf:label>
                     <xf:action ev:event="DOMActivate">
                         <xf:insert nodeset="instance('save-data')/Classifiers/Classifier" at="last()" position="after"/>
                         <xf:setvalue ref="instance('save-data')/Classifiers/Classifier[last()]" value=""/>
                         <xf:setfocus control="classifier-select"/>
                     </xf:action>
                 </xf:trigger>
                
           </xf:group>
       <br/>  
       <xf:textarea ref="instance('save-data')/Notes" class="Notes">
           <xf:label>Notes:</xf:label>
       </xf:textarea>

       </div>
       
       {style:revision-status($id)}

       
       <xf:submit submission="save">
           <xf:label>Save</xf:label>
       </xf:submit>
</div>

(:
    @param $title the text node containing the title of the page
    @param $dummy-attributes an optional sequence of attributes to add to the HTML element
    @param $style an optional style node containing CDATA-encased CSS definitions
    @param $model an XForms model node
    @param $content nodes for the body of the page
    @param $debug boolean to activate XSLTForms debug mode
    
:)
    
return style:assemble-form($title, (), $style, $model, $content,  true())