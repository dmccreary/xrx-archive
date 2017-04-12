xquery version "1.0";
import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";
declare namespace sch="http://purl.oclc.org/dsdl/schematron";

let $id := request:get-parameter('id', '')
let $app-collection := $style:db-path-to-app
let $data-collection := concat($app-collection, '/rule-sets')
let $item := collection($data-collection)/sch:schema[sch:filename/text() = $id]

let $title :='Rule Viewer'

let $content :=
<div class="content">
<h3>{$item/sch:title/text()}</h3>

{
for $pattern in $item/sch:pattern
return 
    <div class="pattern">
    {$pattern//@name/string()}
    {
    for $rule in $pattern//sch:rule
       return
       <div class="rule">
          <table class="span-10">
              <thead>
              <tr>
                  <th>Field</th><th>Value</th>
              </tr>
              </thead>
            <tr><td class="label">Rule</td><td>{$rule/@context/string()}</td></tr>
            <tr><td class="label">Subject</td><td>{$rule/sch:assert/@subject/string()}</td></tr>
            <tr><td class="label">Test</td><td>{$rule/sch:assert/@test/string()}</td></tr>
            <tr><td class="label">Assertion</td><td>{$rule//sch:assert/text()}</td></tr>
            
          </table>
       </div>
       }
    </div>
}

   
    <div class="edit-controls">
        <a href="../edit/edit2.xq?id={$id}">Edit</a>
    </div>

</div>

return style:assemble-page($title, $content)