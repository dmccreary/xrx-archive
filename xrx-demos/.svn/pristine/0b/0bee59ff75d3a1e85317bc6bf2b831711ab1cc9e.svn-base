xquery version "1.0";
import module namespace style = "http://surescripts.com/style" at "../../../modules/style.xqm";

(: list all the data in a given taxonomy file :)

let $file := request:get-parameter('file', 'security-documents.xml')

let $title := "List Document Categories"

let $app-collection := $style:db-path-to-app
let $data-collection := concat($app-collection, '/data')
let $doc-path := concat($data-collection, '/', $file)
return

let $content :=
<div class="content">
    
      
       {
          for $top-level-category in doc($doc-path)/taxonomy/category
             let $name := $top-level-category/category-name/text()
             let $top-cat-id := $top-level-category/category-id/text()
          return
             <form method="GET" action="../../docs/search/echo-url-parameters.xq" >
                <label>{$name}</label><br/>
                <select name="{$top-cat-id}" multiple="yes">
   
                   {for $sub-category in $top-level-category/category
                   let $cat-id := $sub-category/category-id/text()
                   return
                      <option value="{$cat-id}">{$sub-category/category-name/text()}</option>
                   }
                
                </select>
                <br/>
                <input type="submit" value="Search for Documents in This Category"/>
                <br/><br/>
             </form>
             
       }
       <form method="GET" action="../../docs/search/echo-url-parameters.xq">
                            <p>
                                <strong>Keyword:</strong>
                                <input name="q" type="text" value="" size="60" />
                                <input type="submit" value="Search" />
                            </p>
                        </form>

   
</div>

return style:assemble-page($title, $content)