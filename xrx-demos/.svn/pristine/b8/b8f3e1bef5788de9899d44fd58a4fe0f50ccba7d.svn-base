xquery version "1.0";
import module namespace style='http://danmccreary.com/style' at '../../../modules/style.xqm';

let $lab-id := request:get-parameter('lab-id', '')
let $title := concat('Average Progress ', $lab-id)


(: check for required parameters :)
return
if (not($lab-id))
    then (
    <error>
        <message>Parameter "lab-id" is missing.  This argument is required for this web service.</message>
    </error>)
    else
      let $app-collection := $style:db-path-to-app
let $data-collection := concat($app-collection, '/data')
let $students := collection($data-collection)/student
let $labs := $students/labs/lab[./lab-id/text() = $lab-id]
let $avg := avg($labs/progress-percent/text())

let $content :=
<div class="content">
 The average student progress on lab {$lab-id} is {$avg}
</div>

return style:assemble-page($title, $content)