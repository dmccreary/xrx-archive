xquery version "1.0";


import module namespace style='http://danmccreary.com/style' at '../../../modules/style.xqm';
import module namespace kwic="http://exist-db.org/xquery/kwic";

declare namespace tei = "http://www.tei-c.org/ns/1.0";

let $data-collection := $style:db-path-to-app-data
let $shakespeare := concat($data-collection, '/shakespeare')
(: set up the configuration for the KWIC system.  This tell you how many characters around the Keyword to display. :)
let $config := <config xmlns="" width="60"/>

(: get the search query string from the command line :)
let $q := request:get-parameter('q', '')
let $title := 'Search Results'
(: contains search for children of volume elements that match this string :)
let $hits := collection($shakespeare)/tei:TEI//tei:l[contains(., $q)]

let $form := 
    <form method="GET" action="search.xq">
        <strong>Search:</strong>
        <input name="q" type="text" value="{$q}" size="60" title="Search volume metadata."/>
        <input type="submit" value="search"/>
    </form>

let $content := 
    <div id="searchform">
        {$form}
        {
        if ($q and count($hits) gt 0) then 
            (
            <p><strong>Search results for: </strong>{$q}<strong> In collection: </strong>{$shakespeare}</p>
            ,
            <ol>{
             for $hit in $hits
                let $score := ft:score($hit)
                let $doc := $hit/ancestor::tei:TEI
                let $id := string($hit/@xml:id)
                let $summary := kwic:summarize($hit, $config)
                order by $score descending
                return
                    <li class="hit-result">
                        <div class="kwic-summary"><span class="speaker-label">{$hit/ancestor::tei:sp/tei:speaker/text()}: </span> <span>{$summary}</span></div>
                        
                        Source: <a href="../views/view-play.xq?id={ $id }">
                            {$doc//tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title/text()}  
                        </a>
                        {' '  (: Put in a link to the Scene :)}
                        <a href="../views/view-scene.xq?id={$id}"> {$hit/ancestor::tei:div[1]/tei:head/text()}</a> {' '}<span class="id">{$id}</span>
                        
                        

                    </li>
            }</ol>
            ,
            $form
            )
        else if ($q) then
            <p><strong>No search results for: </strong>{$q}<strong> In collection: </strong>{$data-collection}</p>
        else ()
        }
    </div>
    
return 
    style:assemble-page($title, $content)