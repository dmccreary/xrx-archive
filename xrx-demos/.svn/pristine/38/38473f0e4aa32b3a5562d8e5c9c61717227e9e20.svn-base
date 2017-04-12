xquery version "1.0";
import module namespace style='http://danmccreary.com/style' at '../../../modules/style.xqm';

let $title := 'List of Twitter Widget Unit Tests'

let $app-collection := $style:db-path-to-app
let $data-collection := concat($app-collection, '/unit-tests')
let $files := xmldb:get-child-resources($data-collection)
let $descriptions := doc(concat($style:db-path-to-app, '/unit-tests/unit-test-descriptions.xml'))//unit-test

let $content :=
<div class="content">
       <table class="span-16">
           <thead>
           <tr>
              <th>File</th>
              <th>Description</th>
              <th>View Source</th>
           </tr>
        </thead>
        <tbody>{
          for $file in $files
             order by $file 
          return
             if (ends-with($file, '.html'))
                 then
                 <tr>
                     <td><a href="{$file}">{$file}</a></td>
                     <td>{$descriptions[./file/text() = $file]/desc/text()}</td>
                     <td><a href="html-to-xml.xq?file={$file}">View Source</a></td>
                 </tr>
                 else ()
       }</tbody></table>
  
</div>

return style:assemble-page($title, $content)
