xquery version "1.0";
import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";

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
    .condition {
       border: 1px solid orange;
       margin: 10px;
       padding: 10px;
    }
	  ]]>
	</style>
        <xf:model>
            <xf:instance xmlns="" id="conditions">
                <data>
                    <condition>
                        <subject-code>subject</subject-code>
                        <predicate/>
                     </condition>
                    <condition>
                        <subject-code>court</subject-code>
                        <predicate/>
                     </condition>
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
 
           <!-- this is where we put an ID to the calling predicate  -->
            <xf:instance xmlns="" id="selected-item">
                <data>
                    <calling-predicate/>
                </data>
            </xf:instance>
 
           <!-- this is where we put the suggested items that are returned from the server -->
           <xf:instance id="suggest-results" xmlns="">
                <suggestions/>
            </xf:instance>
            
           <xf:instance xmlns="" id="views">
               <data>
                  <condition-delete-trigger/>
               </data>
           </xf:instance>
           
           <!-- only display the trigger if we have a second condition -->
            <xf:bind id="condition-delete-trigger" 
               nodeset="instance('views')/condition-delete-trigger" 
               relevant="instance('conditions')/condition[2]"/>
 
            <!-- This sends the request to the items suggestion service at the U of West England.  -->
            <!-- Please make a local copy if you are doing more than a few examples for learning XForms and XQuery -->
            <xf:submission id="get-suggestions" action="suggest-items.xq" 
                method="get" separator="&amp;" 
                ref="instance('suggest-query')" 
                replace="instance" instance="suggest-results">
            </xf:submission>      
 
            <!-- put the cursor in the first field when the form becomes ready -->
            <xf:action ev:event="xforms-ready">
                <xf:setfocus control="input-field"/>
            </xf:action>
        </xf:model>
    </head>
    <body>
        <h3>Demo of Suggest A JIEM Condition</h3>
        {style:header()}
        {style:breadcrumb()}
        
        <xf:repeat nodeset="instance('conditions')/condition" id="condition-repeat">
            <div class="condition">
                Rule #<xf:output value="position()"/>:
               
                <xf:select1 ref="subject-code">
                   <xf:label>If </xf:label>
                   <xf:itemset nodeset="instance('code-tables')/item">
                      <xf:item>
                         <xf:label ref="label"/>
                         <xf:value ref="value"/>
                      </xf:item>
                   </xf:itemset>
                </xf:select1>
            
                <xf:input ref="predicate" incremental="true" id="input-field">
                    <xf:action ev:event="xforms-value-changed">
                        <xf:setvalue ref="instance('suggest-query')/prefix" 
                            value="instance('conditions')/condition[index('condition-repeat')=position()]/predicate"/>
                       <xf:send submission="get-suggestions"/>
                    </xf:action>
                </xf:input>
                
               <xf:trigger bind="condition-delete-trigger" class="inline-delete">
                   <xf:label>Delete Condition</xf:label>
                   <xf:delete nodeset="instance('conditions')/condition[index('condition-repeat')=position()]" ev:event="DOMActivate"/>
               </xf:trigger>
           </div>
       </xf:repeat>
       
        <xf:trigger>
           <xf:label>Add Condition</xf:label>
           <xf:action ev:event="DOMActivate">
               <xf:insert nodeset="instance('conditions')/condition" at="last()" position="after"/>
               <xf:setvalue ref="instance('conditions')/condition[last()]/predicate" value=""/>
               <xf:setfocus control="input-field"/>
           </xf:action>
       </xf:trigger>
       
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
                           <xf:setvalue ref="instance('conditions')/condition[index('condition-repeat')]/predicate" 
                              value="instance('suggest-results')/item[index('results-repeat')]"/>
                        </xf:action>
                    </xf:trigger>
                </xf:repeat>
            </div>
        </xf:group>
        <br/>
       <xf:output ref="instance('selected-item')/calling-predicate"><xf:label>Prior-field: </xf:label></xf:output>
       <br/>
        {style:footer()}
    </body>
</html>
