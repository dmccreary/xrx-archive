xquery version "1.0";
import module namespace style='http://mdr.crossflow.com/style' at '/db/crossflo/modules/style.xq';
declare option exist:serialize "method=xhtml media-type=application/xhtml+xml indent=yes"; 

<html xmlns:xf="http://www.w3.org/2002/xforms"
   xmlns:ev="http://www.w3.org/2001/xml-events"
   xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <title>Demo of Suggest A JIEM Condition</title>
         {style:import-css()}
        <style type="text/css">
         <![CDATA[
           @namespace xf url("http://www.w3.org/2002/xforms");
           body {font-family: Helvetica, sans-serif}
	#suggest {
            	position: absolute;
            	top: -30;
            	margin: 0 0 0 300px;
            	width: auto;
            	border: 1px solid blue;			
	}
	#log {
		position: absolute;
		top: -100;
		width: auto;
		font-size: 8pt; 
		color: SlateGray;
		background-color: lavender; 
		border: 1px solid SlateGray;			
	}
	  ]]>
	</style>
        <xf:model>
            <xf:instance xmlns="" id="my-form">
                <data>
                    <subject-code/>
                    <element/>
                    <subject-code/>
                    <element/>
                    <subject-code/>
                    <element/>
                </data>
            </xf:instance>
            <xf:instance xmlns="" id="conditional-views">
                <data>
                    <suggest-view/>
                </data>
            </xf:instance>
            
            <xf:instance xmlns="" id="code-tables" src="/exist/rest/db/crossflo/apps/rule-manager/code-tables/subject-code-table.xq">
               <data/>
            </xf:instance>
            
            <!-- only show the suggested values if we have at least one suggestion -->
            <xf:bind nodeset="instance('conditional-views')/suggest-view" 
                     relevant="count(instance('suggest-results')/item) &gt; 1"/>
 
        	<!-- this is the place that we store the parameters that are going out to the remote suggest service -->
            <xf:instance id="suggest-query">
                <query xmlns="">
                    <prefix/>
                </query>
            </xf:instance>
 
           <!-- this is where we put an ID to the calling element  -->
            <xf:instance xmlns="" id="selected-word">
                <data>
                    <calling-element/>
                </data>
            </xf:instance>
 
           <!-- this is where we put the suggested items that are returned from the server -->
           <xf:instance id="suggest-results" xmlns="">
                <suggestions/>
            </xf:instance>
 
            <!-- This sends the request to the items suggestion service at the U of West England.  -->
            <!-- Please make a local copy if you are doing more than a few examples for learning XForms and XQuery -->
            <xf:submission id="get-suggestions" action="suggest-items.xq" 
                method="get" separator="&amp;" 
                ref="instance('suggest-query')" 
                replace="instance" instance="suggest-results">
            </xf:submission>      
 
            <!-- put the cursor in the first field when the form becomes ready -->
            <xf:action ev:event="xforms-ready">
                <xf:setfocus control="field-1"/>
            </xf:action>
        </xf:model>
    </head>
    <body>
        <h3>Demo of Suggest A JIEM Condition</h3>
        {style:header()}
        {style:breadcrumb()}
        
        <xf:select1 ref="subject-code[1]">
           <xf:itemset nodeset="instance('code-tables')/item">
              <xf:item>
                 <xf:label ref="label"/>
                 <xf:value ref="value"/>
              </xf:item>
           </xf:itemset>
        </xf:select1>
        
        <xf:input ref="instance('my-form')/element[1]" incremental="true" id="field-1">
            <xf:label>Condition 1:</xf:label>
            <xf:action ev:event="xforms-value-changed">
                <xf:setvalue ref="instance('suggest-query')/prefix" value="instance('my-form')/element[1]"/>
               <xf:send submission="get-suggestions"/>
            </xf:action>
            <xf:action ev:event="DOMFocusOut">
               <xf:setvalue ref="instance('selected-word')/calling-element" value="'1'"/>
            </xf:action>
        </xf:input>

       <xf:select1 ref="subject-code[2]">
           <xf:itemset nodeset="instance('code-tables')/item">
              <xf:item>
                 <xf:label ref="label"/>
                 <xf:value ref="value"/>
              </xf:item>
           </xf:itemset>
        </xf:select1>
        
       <xf:input ref="instance('my-form')/element[2]" incremental="true" id="field-2">
            <xf:label>Condition 2:</xf:label>
           <xf:action ev:event="DOMFocusIn">             
           </xf:action>
            <xf:action ev:event="xforms-value-changed">
               <xf:setvalue ref="instance('suggest-query')/prefix" value="instance('my-form')/element[2]"/>
               <xf:send submission="get-suggestions"/>
            </xf:action>
            <xf:action ev:event="DOMFocusOut">
               <xf:setvalue ref="instance('selected-word')/calling-element" value="2"/>
            </xf:action>
        </xf:input>

        <xf:select1 ref="subject-code[3]">
           <xf:itemset nodeset="instance('code-tables')/item">
              <xf:item>
                 <xf:label ref="label"/>
                 <xf:value ref="value"/>
              </xf:item>
           </xf:itemset>
        </xf:select1>
 
       <xf:input ref="instance('my-form')/element[3]" incremental="true" id="field-3">
            <xf:label>Condition 3:</xf:label>
            <xf:action ev:event="xforms-value-changed">
                <xf:insert nodeset="instance('log')/event" at="last()" position="after"/>
                <xf:setvalue ref="instance('log')/event[last()]" value="'Value changed in input 3'"/>
               <xf:setvalue ref="instance('suggest-query')/prefix" value="instance('my-form')/element[3]"/>
               <xf:send submission="get-suggestions"/>
            </xf:action>
            <xf:action ev:event="DOMFocusOut">
               <xf:setvalue ref="instance('selected-word')/calling-element" value="'3'"/>
            </xf:action>
       </xf:input>
 
        <xf:group ref="instance('conditional-views')/suggest-view">
            <div id="suggest">
                <span>suggestions:</span>
                <xf:repeat id="results-repeat" nodeset="instance('suggest-results')/item">
                    <xf:trigger>
                        <xf:label>
                            <xf:output ref="."/>
                        </xf:label>
                        <!-- When the use clicks on  suggestion -->
                        <xf:action ev:event="DOMActivate">
                           <xf:setvalue ref="instance('my-form')/element[number(instance('selected-word')/calling-element)]" 
                              value="instance('suggest-results')/item[index('results-repeat')]"/>
                        </xf:action>
                    </xf:trigger>
                </xf:repeat>
            </div>
        </xf:group>
        <br/>
       <xf:output ref="instance('selected-word')/calling-element"><xf:label>Prior-field: </xf:label></xf:output>
       <br/>
        {style:footer()}
    </body>
</html>
