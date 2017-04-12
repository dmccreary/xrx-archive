xquery version "1.0";

(: A listing of the last access attempts.  Logins, logouts etc. :)

import module namespace style='http://danmccreary.com/style' at '../../../modules/style.xqm';

let $title := 'Last Modified Files'
let $root-collection := concat($style:db-path-to-site, '/apps')
let $paginate := request:get-parameter('paginate', 'yes')
let $start := xs:integer(request:get-parameter('start', 0))
let $perpage := xs:integer(request:get-parameter('perpage', 30))

let $url-params := 
    string-join(
        (
        if ($paginate ne 'yes') then concat('paginate=', $paginate) else (),
        if ($perpage ne 10) then concat('perpage=', $perpage) else ()
        )
        , 
        '&amp;')


(: find all documents that have a last-modified-dateTime element :)
let $docs := collection($root-collection)/*[last-modified-datetime]

(: get a sorted list and only return valid datetimes :)
let $sorted-docs :=
   for $doc in $docs
   let $date-time := $doc/last-modified-datetime/text()
   order by $date-time descending
   return
      if ($date-time) then $doc else ()
      
let $count := count($docs)
let $results-to-display := if ($paginate eq 'no') then $sorted-docs else subsequence($sorted-docs, $start, $perpage)

let $content := 
    <div class="content">
    <p>Sorted by most recent change.</p>
         <table class="span-17">
            <thead>
               <tr>
                  <th class="span-10">Path</th>
                  <th class="span-3">Root Element</th>
                  <th class="span-2">User</th>
                  <th class="span-5 last">DateTime</th>
               </tr>
            </thead>
            <tbody>
        { for $doc in $results-to-display return
           <tr>
              <td>{util:collection-name($doc)}/{util:document-name($doc)}</td>
              <td>{$doc/name()}</td>
              <td>{$doc/last-modified-by/text()}</td>
              <!-- <td>{xsl:format-dateTime($doc/last-modified-datetime/text(), 'YYYY MM DD')}</td> -->
              <td>{ $doc/last-modified-datetime/text() }</td>
           </tr>
        }
           </tbody>
        </table>
        
        

    </div>

return 
    style:assemble-page($title, $content)