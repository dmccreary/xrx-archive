import module namespace style='http://danmccreary.com/style' at "../../../modules/style.xqm";

let $data-collection := $style:db-path-to-app-data

let $title := 'List Security Roles'

let $roles := for $item in collection($data-collection)/security-role order by $item/name/text() return $item
let $count := count($roles)

let $content := 
    <div class="content">
            
        <table>
        <thead>
          <tr>
             <th>ID</th>
             <th>Name</th>
             <th>Label</th>
             <th>Description</th>
             <th>Public Web</th>
             <th>Intranet</th>
             <th>Status</th>
          </tr>
        </thead>
        <tbody>
        {
          for $security-role in $roles
             let $name := $security-role/name/text()
             let $label := $security-role/label/text()
             let $id := $security-role/id/text()
             let $public := if ($security-role/category/text() = 'public-web-site') then 'true' else 'false'
             let $intranet := if ($security-role/category/text() = 'intranet') then 'true' else 'false'
          return
            if (not($security-role/status/text() eq 'disabled'))
              then
              <tr>
                 <td>{$id}</td>
                 <td><a href="view-item.xq?id={$id}">{$label}</a></td>
                 <td>{$security-role/description/text()}</td>
                 <td>{$public}</td>
                 <td>{$intranet}</td>
                 <td>{$security-role/status/text()}</td>
              </tr>
              else ()
       }
          </tbody>
       </table>
    </div>

return 
    style:assemble-page($title, $content)
