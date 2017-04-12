xquery version "1.0";
import module namespace style='http://danmccreary.com/style' at '../../../modules/style.xqm';
declare namespace pmml="http://www.dmg.org/PMML-4_0";
let $title := 'List Items'

let $app-collection := $style:db-path-to-app
let $data-collection := concat($app-collection, '/data')
let $sorted-models :=
   for $model at $count in collection($data-collection)/pmml:PMML
   order by util:document-name($model)
   return $model

let $content :=
<div class="content">
       <table>
           <thead>
           <tr>
              <th>File Name</th>
              <th>Description</th>
              <th>Version</th>
              <th>Copyright</th>
              <th>Application</th>
              <th>View</th>
           </tr>
        </thead>
        <tbody>{
          for $model at $count in $sorted-models
             let $file-name := util:document-name($model)
             return
             <tr>
                 {if ($count mod 2)
                    then attribute class {'odd'}
                    else attribute class {'even'}
                 }
                 <td>{$file-name}</td>
                 <td>{$model/pmml:Header/@description/string()}</td>
                 <td>{$model/@version/string()}</td>
                 <td>{$model/pmml:Header/@copyright/string()}</td>
                 <td>{$model/pmml:Header/pmml:Application/@name/string()}</td>
                 <td><a href="../data/{$file-name}">View XML</a></td>
             </tr> 
       }</tbody></table>
  
</div>

return style:assemble-page($title, $content)