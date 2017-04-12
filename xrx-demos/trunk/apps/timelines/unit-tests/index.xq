xquery version "1.0";

(: List of Training Samples :)

import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";

let $title := 'List Unit Tests'
let $test-stats := doc(concat($style:db-path-to-app, '/unit-tests/test-status.xml'))//test

let $collection := request:get-parameter('collection', '')

let $sample-collection :=
   if ($collection)
      then concat($style:db-path-to-app, "/unit-tests/", $collection)
      else concat($style:db-path-to-app, "/unit-tests")
      
let $files := xmldb:get-child-resources($sample-collection)

let $sub-collections := xmldb:get-child-collections($sample-collection)

let $content := 
<div class="content">
Unit Tests:<br/>
<table>
   <thead>
      <tr>
        <th>Test</th>
        <th>Description</th>
        <th>Status</th>
      </tr>
   </thead>
    {for $file in $files
       let $test-stat := $test-stats[file=$file]
       order by $file
       return
         if ($file != 'index.xq')
         then
         <tr>
            <th><a href="{if ($collection) then concat($collection, '/') else ()}{$file}">{$file}</a></th>
            <td>{$test-stat/desc/text()}</td>
            <td>{$test-stat/status/text()}</td>
         </tr> else ()
    }
</table>
    { if (exists($sub-collections))
    then
    <div class="subcollections">
    Sub Collections:<br/>
        {for $sub-collection in $sub-collections
           order by $sub-collection
           return
             <div>
                <a href="index.xq?collection={$sub-collection}">{$sub-collection}</a>
             </div>
        }
    </div> else ()
    }
</div>

return 
    style:assemble-page($title, $content)
