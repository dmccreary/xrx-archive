declare option exist:serialize "method=xhtml media-type=text/xml indent=yes process-xsl-pi=no";

declare function local:xml2form($nodes, $path) {
    for $node at $count in $nodes
    return
    typeswitch($node)
        case document-node() return local:document-node2form($node, $path)
        case element() return local:element2form($node, $path)
        case text() return local:text2form($node, $path)
        case comment() return ()
        case processing-instruction() return ()
        default return ()
};

declare function local:document-node2form($node, $path) {
    <li>{
        <xf:label>document-node() for {util:document-name($node)}</xf:label>
        ,
        <ul>{local:xml2form($node/node(), $path)}</ul>
    }</li>
};

declare function local:element2form($node, $path) {
    <li>
        {
        (: 1 catch mixed content elements :)
        if ($node/text() and (count($node/text()) + count($node/element()) ge 2)) then
            (
            (: 1a show element name but warn about mixed content, show string value of node :)
            <xf:output value="'{replace(string-join(data($node), ''), '&#xA;', ' ') (: note- xsltforms doesn't like &#xA; :) }'">
                <xf:label>&lt;{name($node)}&gt; (contains mixed text and element children, cannot edit; concatenated string value is) </xf:label>
            </xf:output>
            ,
            (: 1b attributes :)
            if ($node/@*) then
                local:attribute2form($node, $path)
            else ()
            )
        (: 2 simple elements :)
        else
            (: 2a no text content :)
            if (normalize-space($node/text()) = '') then
                <xf:output value="''">
                    <xf:label>&lt;{name($node)}&gt; </xf:label>
                </xf:output>
            (: 2b text content :)
            else
                <xf:input ref="{local:get-nodepath($node, $path)}">
                    <xf:label>&lt;{name($node)}&gt; </xf:label>
                </xf:input>   
            ,
            (: 2c attributes :)
            if ($node/@*) then
                local:attribute2form($node, $path)
            else ()
            ,
            (: 2d no text content so recurse through child elements :)
            if (count($node/text()) le 1 and $node/*) then 
                <ul>{local:xml2form($node/node(), local:get-nodepath($node, $path))}</ul> 
            else ()
        }
    </li>
};

declare function local:attribute2form($node, $path) {
    <ul>{
        for $attribute in $node/@*
        return
            <li>
                <xf:input ref="{concat(local:get-nodepath($node, $path), '/@', name($attribute))}">
                    <xf:label>@{name($attribute)}: </xf:label>
                </xf:input>
            </li>
    }</ul>
};

declare function local:text2form($node, $path) {
    <li>{
        (: 5a mixed :)
        if (count($node/../node()) gt 1) then
            <xf:output value="'{normalize-space($node)}'">
                <xf:label>text() (part of mixed node, cannot edit, string value is) </xf:label>
            </xf:output>
        (: 5b just text() :)
        else
            <xf:input ref="{$path}">
                <xf:label>text() </xf:label>
            </xf:input>
    }</li>
};

declare function local:get-nodepath($node, $path) {
    concat(
        if ($path ne '') then concat($path, '/') else ()
        , 
        if (namespace-uri($node) eq '') then 
            name($node) 
        else 
            concat(
                '*[namespace-uri() = ''', namespace-uri($node), ''' and local-name()=''', local-name($node), ''']')
        , 
        '[', count($node/preceding-sibling::*[name(.) eq name($node)]) + 1, ']'
        )
};

let $doc := request:get-parameter('doc', '/db/dma/apps/xml2form/data/members.xml')


let $xml :=
<members>
    
    <member>
        <id>2</id>
        <surname>Wicentowski</surname>
        <forename>Joseph</forename>
        <email>WicentowskiJC@state.gov</email>
        <active-status>true</active-status>
        <current-plan>5</current-plan>
        <history>
            <dues-paid amount="10" date="2011-01-15"/>
            <status-change type="joined" date="2011-01-01"/>
        </history>
    </member>
    <member>
        <id>1</id>
        <surname>McCreary</surname>
        <forename>Dan</forename>
        <email>dan@danmccreary.com</email>
        <active-status>true</active-status>
        <current-plan>5</current-plan>
        <history>
            <dues-paid amount="10" date="2011-01-15"/>
            <status-change type="joined" date="2011-01-01"/>
        </history>
    </member>
    
</members>

let $form :=
<html xmlns="http://www.w3.org/1999/xhtml" 
    xmlns:ev="http://www.w3.org/2001/xml-events" 
    xmlns:xs="http://www.w3.org/2001/XMLSchema" 
    xmlns:xf="http://www.w3.org/2002/xforms">
    <head>
        <title>XML to Form</title>
        <xf:model>
            <xf:instance id="xml">
                <data xmlns="">{$xml}</data>
            </xf:instance>
            <!--still need to hook up the save button-->
            <xf:submission id="save" resource="echo-post.xq" method="post" instance="xml" replace="none"/>
        </xf:model>
    </head>
    <body>
        <h1>XML to Form</h1>
        <ul>{local:xml2form($xml, '')}</ul>    
        <!--<p>
            <xf:submit submission="save">
                <xf:label>Save</xf:label>
            </xf:submit>
        </p>-->
    </body>
</html>
    
let $xslt-pi := processing-instruction xml-stylesheet {'type="text/xsl" href="/rest/db/xforms/xsltforms/xsltforms.xsl"'}
return ($xslt-pi, $form)
