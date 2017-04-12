xquery version "1.0";
import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";

let $page-title := 'Listing of Code Tables'

let $data-collection := concat($style:db-path-to-app, '/code-tables')
let $code-tables := collection($data-collection)/code-table
let $count := count($code-tables)

let $content := 
    <div class="content">
       
       <p>Code Table Collection: {$data-collection}</p>
       <p>{$count} Code Tables Found</p>
       <table>
          <thead>
             <tr>
                <th class="span-3">Code Table Name</th>
                <th class="span-9">Description</th>
                <th class="span-1">View</th>
             </tr>
          </thead>
       
       {
         for $item in $code-tables
            let $id := $item/code-table-name/text()
            order by $id
            return
               <tr>
                  <td>{$id}</td>
                  <td>{$item/description/text()}</td>
                  <td><a href="view-code-table.xq?id={$id}">View</a></td>
               </tr>
               
      }</table>
</div>

return style:assemble-page($page-title, $content)

