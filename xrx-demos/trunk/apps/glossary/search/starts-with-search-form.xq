xquery version "1.0";
import module namespace style = "http://style.syntactica.com/us-state-hist" at "../../../modules/style.xqm";

(: Default function and element declarations :)
declare default function namespace "http://www.w3.org/2005/xpath-functions";
declare namespace html="http://www.w3.org/1999/xhtml";

(: Document namespaces declarations :)
declare namespace hist="http://history.state.gov/ns/1.0";
declare namespace tei="http://www.tei-c.org/ns/1.0";
declare namespace xf="http://www.w3.org/2002/xforms";
declare namespace ev="http://www.w3.org/2001/xml-events";

let $model :=
<xf:model>

   <!-- the outgoing search parameters -->
    <xf:instance id="search-params">
        <root xmlns="">
            <prefix/>
        </root>
    </xf:instance>
    
    <!-- the search results are loaded into this instance and have the format
        results
           items
              id
              id
              id
    -->
    <xf:instance id="results">
        <root xmlns=""/>
    </xf:instance>
    
    <xf:submission ref="instance('search-params')" id="search" method="get" replace="instance" instance="results"
       action="starts-with.xq">
    </xf:submission>
    
</xf:model>

let $content := 
<div class="content">
        <xf:input ref="instance('search-params')/prefix" incremental="true">
            <xf:label>Term ID: </xf:label>
            <xf:send submission="search" ev:event="xforms-value-changed"/>
        </xf:input>
        
        <xf:submit submission="search">
           <xf:label>Search</xf:label>
        </xf:submit>
        <br/>
        <xf:output value="count(instance('results')/items/id)"/> items found<br/>
        
        <xf:repeat nodeset="instance('results')/items/id">
            <xf:trigger>
              <xf:label><xf:output value="."/> </xf:label>
            </xf:trigger>
        </xf:repeat>
</div>

return style:assemble-form($model, $content, true())

