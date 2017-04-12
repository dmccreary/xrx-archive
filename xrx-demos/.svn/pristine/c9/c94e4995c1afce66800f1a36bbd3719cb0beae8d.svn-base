xquery version "1.0";

(: Search Form :)

import module namespace style = "http://style.syntactica.com/us-state-hist" at "../../../modules/style.xqm";

declare namespace xf="http://www.w3.org/2002/xforms";
declare namespace ev="http://www.w3.org/2001/xml-events";
        
let $model :=
    <xf:model>
        <xf:instance xmlns="">
            <data>
                <q/>
            </data>
        </xf:instance>
       <!-- this puts the input in the search field -->
        <xf:action ev:event="xforms-ready">
            <xf:setfocus control="search-field"/>
        </xf:action>
        <xf:submission id="search" method="get" action="search" replace="all"/>
    </xf:model>
let $content := 
    <div>
        <xf:input ref="q" id="search-field" incremental="true">
            <xf:label>Search:</xf:label>
            <!-- this makes the return perform a search -->
            <xf:action ev:event="DOMActivate">
                <xf:send submission="search"/>
            </xf:action>
        </xf:input>
        <xf:submit submission="search">
            <xf:label>Search</xf:label>
        </xf:submit>
    </div>
    
return 
    style:assemble-form($model, $content)