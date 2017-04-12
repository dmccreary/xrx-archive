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
            margin-left: 10ex;
        }
        
        /* make sure the select and select1 items don't float to the left */
        xf|select xf|item, xf|select1 xf|item {
            margin-left: 16ex;
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
        <xf:instance id="save-data" src="{$file}"/>
        
        <xf:instance id="code-tables" src="all-codes.xq" xmlns=""/>

        
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
            
           
            <xf:input ref="Projectid">
                <xf:label>Associated Project ID:</xf:label>
            </xf:input>
                     
            <xf:input ref="RiskName" class="riskname">
                <xf:label>Risk Name:</xf:label>
            </xf:input>
           
            <xf:textarea ref="RiskDescription" class="description">
                <xf:label>Description:</xf:label>
            </xf:textarea>
           
            <xf:input ref="RiskProbability" class="probability">
                <xf:label>Probability:</xf:label>
            </xf:input>
            
             <xf:input ref="RiskImpact" class="impact">
                <xf:label>Impact:</xf:label>
            </xf:input>
           
            <xf:input ref="RiskScore" class="score">
                <xf:label>Risk Score:</xf:label>
            </xf:input> 
            
             <xf:select1 ref="RiskStatus"  class="status">
               <xf:label>Risk Status:</xf:label>
                 <xf:itemset nodeset="instance('code-tables')/code-table[name='risk-status-codes']/items/item">
                   <xf:label ref="label"/>
                   <xf:value ref="value"/>
                </xf:itemset>
             </xf:select1>
            
            <xf:input ref="RiskOwner" class="owner">
                <xf:label>Owner:</xf:label>
            </xf:input> 
            
             <xf:select1 ref="RiskPlan" class="riskplan">
                <xf:label>Plan Status:</xf:label>
                  <xf:itemset nodeset="instance('code-tables')/code-table[name='plan-status-codes']/items/item">
                   <xf:label ref="label"/>
                   <xf:value ref="value"/>
                </xf:itemset>
            </xf:select1> 
            
             <xf:textarea ref="RiskPlanDescription" class="description">
                 <xf:label>Plan Description:</xf:label>
             </xf:textarea>
            
        </div> <!-- end of block form layout -->
       

   
      <br/>
       
       <xf:submit submission="save">
           <xf:label>Save</xf:label>
       </xf:submit>
       
              
  </div>
    
return style:assemble-form($title, (), $style, $model, $content, true())