xquery version "1.0";
import module namespace style = "http://danmccreary.com/style" at "../../modules/style.xqm";

let $title := 'Sample OWL Reports'

let $app-collection := $style:web-path-to-app
let $views-collection := concat($app-collection, '/owl/views')

let $queries :=
   for $query in xmldb:get-child-resources($views-collection)
   return
      if (ends-with($query, '.xq')) then $query else ()
      
let $content :=
<div class="content">
      <h1>{$title}</h1>
      
      The purpose of the application is to show how OWL files can be parsed using XQuery.
      
      The sample file used here is the K-12 ontology created for the Minnesota Department of Education.
      
      App Collection: {$app-collection}<br/>
      Document: education.owl
      <br/>
      
      <ol>
      {for $link in $queries
         order by $link
      return
        <li><a href="/rest{$views-collection}/{$link}">{$link}</a></li>
      }
      </ol>

</div>


return style:assemble-page($title, $content)