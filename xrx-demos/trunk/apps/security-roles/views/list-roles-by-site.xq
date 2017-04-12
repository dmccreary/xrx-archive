xquery version "1.0";
import module namespace style='http://danmccreary.com/style' at "../../../modules/style.xqm";
declare option exist:serialize "method=xhtml media-type=text/html indent=yes";

 
let $title := 'List Roles by Category'

let $app-collection := style:app-base-uri()
let $data-collection := concat($app-collection, '/data')
let $all-security-roles := collection($data-collection)/security-role
let $categories := distinct-values($all-security-roles/category/text())

return
<html>
    <head>
       <title>{$title}</title>
       {style:import-css()}
    </head>
    <body>
      {style:header()}
      {style:breadcrumb()}
      <h1>{$title}</h1>
      
      {for $category in $categories
      
        return
        <div>
                <h2>{$category}</h2>
                
                <p>All active roles on site ordered by role label.</p>
                
                 {
                 for $security-role in $all-security-roles[./category/text() = $category]
                    let $id := $security-role/id/text()
                    let $label := $security-role/label/text()
                    order by $label
                    return
                      if ($security-role/status/text() ne 'disabled')
                        then
                          <li>
                             <b><a href="view-item?id={$id}">{$label}</a></b> {' '} {$security-role/description/text()}
                          </li>
                        else ()
                  }
                
         </div>
         }
        
        {style:footer()}
    </body>
</html>
