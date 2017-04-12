xquery version "1.0";
import module namespace style = "http://danmccreary.com/style" at "../../modules/style.xqm";
import module namespace sandbox-interface = "http://danmccreary.com/sandbox" at "modules/interface-module.xqm";
(: $Id: sandbox.xql 10286 2009-10-29 17:43:00Z wolfgang_m $ :)
(: modified by Dan McCreary in July of 2010 :)

(:~ Main XQuery script for the sandbox application. Generates the
	HTML page and handles actions like export, saving queries
	and syntax checks.

	The actual user-supplied queries are not executed via this script. The
	controller directly forwards them to XQueryServlet and post-processes
	the result via session.xql.
:)
declare namespace sandbox="http://exist-db.org/xquery/sandbox";
declare namespace system="http://exist-db.org/xquery/system";

import module namespace util="http://exist-db.org/xquery/util";
import module namespace request="http://exist-db.org/xquery/request";
import module namespace session="http://exist-db.org/xquery/session";
import module namespace xdb="http://exist-db.org/xquery/xmldb";

declare option exist:serialize "method=xhtml indent=no highlight-matches=elements";

declare function sandbox:init-slots() as element()+ {
    for $i in 1 to 10 return
        <li><span class="num">[{$i}]</span> <a href="#" id="slot{$i}" onclick="switchSlot(this)">--- empty ---</a></li>
};

(:~ Export the current query results into a new document in the database. :)
declare function sandbox:export($docName as xs:string) as element() {
    let $collection := request:get-parameter("collection", ())
    let $wrapper0 := request:get-parameter("wrapper", ())
    let $wrapper := if ($wrapper0) then $wrapper0 else "exist:result"
    let $cached := session:get-attribute("cached")
    return
        if (empty($cached)) then
            <error>No query results to export!</error>
        else
            let $newDoc :=
                element { $wrapper } { $cached }
            return
                util:catch("java.lang.Exception",
                    (let $dummy := xdb:store($collection, $docName, $newDoc, "text/xml") return <ajax-response/>),
                    <error>{$util:exception-message}</error>
                )
};

(:~ Append the given query to the query examples file or update an existing old query. :) 
declare function sandbox:save-query($query as xs:string, $description as xs:string) as element() {
    let $root0 := /example-queries
    let $root :=
        if ($root0) then
            $root0
        else
            xdb:store("/db/org/northwestern/apps/sandbox/data", "examples.xml", <example-queries/>, "text/xml")
    let $existing := $root/query[description = $description][1]
    let $newEntry := 
            <query>
                <description>{$description}</description>
                <code>{$query}</code>
            </query>
    return (
        if ($existing) then
            update replace $existing with $newEntry
        else
            update insert $newEntry into $root,
        <ajax-response/>
    )
};

(:~ Check if the passed query string would correctly compile. :)
declare function sandbox:check-query($query as xs:string) as element() {
    util:declare-option("exist:serialize", "media-type=text/xml omit-xml-declaration=no"),
    <ajax-response>
        { util:compile($query) }
    </ajax-response>
};

declare function sandbox:display-page($id as xs:string) as element() {
    let $serialize := util:declare-option("exist:serialize", "media-type=text/html method=xhtml")
    let $queries := collection('/db/org/northwestern/apps/sandbox/data')/example-queries[id=$id]
    let $file-name := util:document-name($queries)
    return
    <html>
        <head>
            <title>XQuery Sandbox</title>
            <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
			<link rel="stylesheet" type="text/css" href="scripts/yui/yui-skin.css"/>
            <link type="text/css" href="styles/sandbox.css" rel="stylesheet"/>
            
			<script src="scripts/yui/yui-combined2.7.0.js"/>
            <script language="Javascript" type="text/javascript" src="scripts/sandbox.js"/>
        </head>
        <body class="yui-skin-sam">

            <div class="content">
            
                <form name="main">
                    <div id="top-panel">
                        <div id="messages"></div>
                        <div id="errors" style="display: none">
                            <div id="error-text"></div>
                            <a href="#" id="error-close">Close</a>
                        </div>
                        <div id="right-panel">
                            <div id="query-panel">
                                <a href="#" id="maximize">Maximize</a>
                                <fieldset id="queries">
                                    <label for="saved">Select an Example from <a href="data/{$file-name}">{$file-name}</a></label>
                                    {sandbox-interface:get-select($id)}
                                </fieldset>
                                <textarea id="codeEditor" 
                                    class="codepress xquery linenumbers-on readonly-off" name="qu"></textarea>
                                <fieldset class="bottom">
                                    <div id="buttons">
                                        <button type="button" id="submit">Send</button>
                                        <button type="button" id="clear">Clear</button>
                                        <button type="button" id="check">Check</button>
                                    </div>
                                    <label for="howmany">Display</label>
                                    <select id="howmany">
                                        <option>20</option>
                                        <option>50</option>
                                        <option>100</option>
                                    </select>
                                </fieldset>
                            </div>
                        </div>
                    </div>
                </form>
                <div id="query-output">
                    <div id="query-result"/>
                    <div id="navbar">
                        <a id="previous" href="#">&lt;&lt;</a>
                        <a id="next" href="#">&gt;&gt;</a>
                        <div id="current">Query Result</div>
                    </div>
                    <div id="output"/>
                </div>
            </div>
        </body>
    </html>
};

session:create(),
let $id := request:get-parameter("id", '1')
let $save := request:get-parameter("save", ())
let $query := request:get-parameter("qu", ())
let $check := request:get-parameter("check", ())
let $export := request:get-parameter("export", ())
return
    if ($save) then
        sandbox:save-query($query, $save)
    else if ($export) then
        sandbox:export($export)
    else if ($check) then
        sandbox:check-query($check)
    else
        sandbox:display-page($id)
