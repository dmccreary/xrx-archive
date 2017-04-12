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
            width: 15ex;
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
    <link type="text/css" rel="stylesheet" href="edit.css"/>

        <div class="process-steps">
        
            <div class="block-form">

                
                <xf:input ref="process-name">
                   <xf:label>Process Name:</xf:label>
                </xf:input>
                
                <xf:textarea ref="process-description">
                   <xf:label>Process Description:</xf:label>
                </xf:textarea>
            
            </div>
            
            <xf:repeat nodeset="instance('save-data')/activity" id="activity-repeat">
                
                <div class="activity" style="display:inline;">
                    <div class="activity-label">
                        <xf:input ref="activity-name" id="activity-name"/>
                    </div>
                    <xf:trigger>
                        <xf:label>+</xf:label>
                        <xf:action ev:event="DOMActivate">
                            <xf:insert nodeset="instance('save-data')/activity" at="index('activity-repeat')" position="after"/>
                            <xf:setvalue ref="instance('save-data')/activity[index('activity-repeat')]/activity-name" value="''"/>
                            <!-- should insert on the new row -->
                            <xf:setfocus control="activity-name"/>
                        </xf:action>
                    </xf:trigger>
                    <xf:trigger>
                        <xf:label>-</xf:label>
                        <xf:delete nodeset="instance('save-data')/activity[index('activity-repeat')]" ev:event="DOMActivate"/>
                    </xf:trigger>
                </div>
            </xf:repeat>
        </div>
        
        <!-- this is always showing the selected activity-->
        <div class="inspector">
            <xf:label class="group-label">Activity Inspector:</xf:label>
            <xf:repeat nodeset="instance('save-data')/activity[index('activity-repeat')=position()]" style="display:inline">
            
                <xf:input ref="activity-name">
                    <xf:label>Step Name:</xf:label>
                </xf:input>
                
                <xf:select1 ref="activity-type-code">
                    <xf:label>Activity Type:</xf:label>
                    <xf:item>
                        <xf:label>Enrich</xf:label>
                        <xf:value>enrich</xf:value>
                    </xf:item>
                    <xf:item>
                        <xf:label>Validate</xf:label>
                        <xf:value>validate</xf:value>
                    </xf:item>
                    <xf:item>
                        <xf:label>Check Ruleset</xf:label>
                        <xf:value>check-ruleset</xf:value>
                    </xf:item>
                </xf:select1>
                
                <!--  &lt;xf:group ref="instance('views')/ruleset-view"&gt;&lt;/xf:group&gt; -->
                
                <xf:input ref="webservice-id">
                    <xf:label>Enrichment Service ID:</xf:label>
                </xf:input>
                
                <xf:input ref="ruleset-id">
                    <xf:label>Ruleset ID:</xf:label>
                </xf:input>
                
                <xf:input ref="schema-id">
                    <xf:label>Validate with Schema ID:</xf:label>
                </xf:input>
                
            </xf:repeat>
        </div>

    </div>
    
return style:assemble-form($title, (), $style, $model, $content, true())