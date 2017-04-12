xquery version "1.0";

import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";
declare namespace xf="http://www.w3.org/2002/xforms";
declare namespace ev="http://www.w3.org/2001/xml-events";
declare namespace sch="http://purl.oclc.org/dsdl/schematron";
declare namespace xhtml="http://www.w3.org/1999/xhtml";

let $title := 'Schematron Rules Editor'
let $new := request:get-parameter('new', '')
let $id := request:get-parameter('id', '')
let $test := request:get-parameter('test', '')
let $form := 'Ruleset Editor'
let $form-version := '0.01'

return

(: check for required parameters :)
if (not($new or $id))
    then 
    <error>
        <message>Parameter "new" and "id" are both missing.  One of these two arguments is required for this web
                 service.</message>
    </error>
    else
        let $file := if ($new)
           then ('new-instance.xml')
           else concat( '../rule-sets/', $id)
           
let $style :=
<xhtml:style language="text/css">
    <![CDATA[
        @namespace xf url("http://www.w3.org/2002/xforms");
        .block-form xf|label {
            width: 15ex;
        }
        
        .inline xf|label {
            display: inline-block;
            margin: 0 1ex 0 1em;
            text-align: right;
        }
        
        /* make sure the select and select1 items don't float to the left */
        xf|select xf|item, xf|select1 xf|item {
            margin-left: 16ex;
        }

        .uri .xforms-value, .url .xforms-value {width: 90ex;}
        .assert textarea {
            height: 5ex;
            width: 97%;
        }
        
        .rule {
          background-color: lavender;
          padding: 5px;
          margin: 5px;
        }
    ]]>
 </xhtml:style>
 
let $model :=
<xf:model>
    <xf:instance xmlns="http://purl.oclc.org/dsdl/schematron" id="my-ruleset" src="{$file}"/>

    
    <!-- a template for inserting new nodes -->
        <xf:instance xmlns="http://purl.oclc.org/dsdl/schematron" id="template">
            <sch:template xmlns:sch="http://purl.oclc.org/dsdl/schematron">
                <sch:rule context="">
                        <sch:assert subject="" test=""></sch:assert>
                </sch:rule> 
                <sch:pattern name="">
                    <sch:rule context="">
                        <sch:assert subject="" test=""></sch:assert>
                    </sch:rule>
                </sch:pattern>
            </sch:template>
        </xf:instance>
        
    <xf:instance xmlns="" id="views">
        <data>
            <pattern-delete-trigger/>
            <rule-delete-trigger/>
        </data>
    </xf:instance>
    
    <xf:bind id="pattern-delete-trigger" nodeset="instance('views')/pattern-delete-trigger" 
       relevant="instance('my-ruleset')/sch:pattern[2]"/>
    
    <xf:bind id="rule-delete-trigger" nodeset="instance('views')/rule-delete-trigger"
      relevant="instance('my-ruleset')/sch:pattern[index('pattern-repeat')]/sch:rule[2]"/>
    
    <xf:submission id="save-submission" method="post" 
       action="{if ($new) then 'save-new.xq' else 'update.xq'}" 
       instance="my-ruleset" replace="all"/>
</xf:model>

let $content :=
<div class="content">

    <div class="block-form">
        
        { if ($id)
        then
        <xf:output ref="instance('my-ruleset')/filename">
            <xf:label>Filename:</xf:label>
        </xf:output>
        else
        <xf:output ref="instance('my-ruleset')/filename">
            <xf:label>Filename:</xf:label>
        </xf:output>
        }
        
        <xf:input ref="instance('my-ruleset')/sch:title">
            <xf:label>Ruleset Title:</xf:label>
        </xf:input>
        
        <xf:input ref="instance('my-ruleset')/sch:ns/@uri" class="url">
            <xf:label>Namespace URL:</xf:label>
        </xf:input>
    </div>
                    
    <xf:repeat id="pattern-repeat" nodeset="instance('my-ruleset')/sch:pattern">
        <fieldset>
        <legend>Pattern <xf:output value="position()"/></legend>
        
        <xf:input ref="@name" class="pattern inline-delete">
            <xf:label>Rule (Pattern) Name:</xf:label>
        </xf:input>
        

            <xf:repeat id="rule-repeat" nodeset="sch:rule">
                <fieldset class="rule">
                    <legend>Rule <xf:output value="position()"/></legend>
                    <xf:input ref="sch:assert/@subject" class="subject inline">
                        <xf:label>Subject:</xf:label>
                    </xf:input>
                    
                    <xf:input ref="sch:assert/@test" class="test inline">
                        <xf:label>Test:</xf:label>
                    </xf:input>
                    <br/>
                    <xf:textarea ref="sch:assert" class="assert">
                        <xf:label>Error Message:</xf:label>
                    </xf:textarea>
                    
                    <!-- bind="rule-delete-trigger" -->
                    <xf:trigger class="inline-delete">
                        <xf:label>Delete Rule</xf:label>
                        <xf:delete nodeset="." ev:event="DOMActivate"/>
                    </xf:trigger>
                 </fieldset>
            </xf:repeat>
            <xf:trigger>
                <xf:label>Insert New Rule</xf:label>

                <xf:insert ev:event="DOMActivate" 
                    nodeset="instance('my-ruleset')/sch:pattern[index('pattern-repeat')]/sch:rule" 
                    at="last()" 
                    position="after"
                    origin="instance('template')/sch:rule"/>
                      
            </xf:trigger>
            <hr/>
            <!-- bind="pattern-delete-trigger" -->
        <xf:trigger  class="inline-delete">
            <xf:label>Delete Pattern</xf:label>
            <xf:delete nodeset="." ev:event="DOMActivate"/>
        </xf:trigger>
        </fieldset>
    </xf:repeat>
        
        <xf:trigger>
            <xf:label>Insert New Pattern</xf:label>

                <xf:insert ev:event="DOMActivate" nodeset="instance('my-ruleset')/sch:pattern" at="last()" position="after"
                    origin="instance('template')/sch:pattern"/>

        </xf:trigger>
        

        <xf:submit submission="save-submission">
            <xf:label>Save</xf:label>
        </xf:submit>
</div>

let $dummy-attributes := ()

return style:assemble-form($title, $dummy-attributes, $style, $model, $content, true())