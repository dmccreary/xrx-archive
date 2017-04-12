xquery version "1.0";

(: List of Training Samples :)

import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";

let $title := 'Training Sample Queries and Data'

let $collection := request:get-parameter('collection', '')

let $sample-collection :=
   if ($collection)
      then concat($style:db-path-to-app, "/samples/", $collection)
      else concat($style:db-path-to-app, "/samples")
      
let $files := xmldb:get-child-resources($sample-collection)

let $sub-collections := xmldb:get-child-collections($sample-collection)

let $content := 
<div class="content">
Main Resources:<br/>
    {for $file in $files
       order by $file
       return
         if ($file != 'index.xq')
         then
         <div>
            <a href="{if ($collection) then concat($collection, '/') else ()}{$file}">{$file}</a>
         </div> else ()
    }
    
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
