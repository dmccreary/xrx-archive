xquery version "1.0";
import module namespace style='http://danmccreary.com/style' at '../../../modules/style.xqm';

let $id := request:get-parameter('id', '')
let $debug := request:get-parameter('debug', '')
let $title := concat('Range Control ', $id)

(: check for required parameters :)
return
if (not($id))
    then (
    <error>
        <message>Parameter "id" is missing.  This argument is required for this web service.</message>
    </error>)
    else
      let $app-collection := $style:db-path-to-app
let $data-collection := concat($app-collection, '/data')
let $range := collection($data-collection)/kpi-range[id/text() = $id]
let $intervales := $range//interval

let $content :=
<div class="content">
 <table class="span-10">
    <thead>
       <tr>
          <th class="span-2">Field</th>
          <th class="span-8 last">Value</th>
       </tr>
    </thead>
    <tbody>
     <tr><th class="field-label">ID:</th><td>{$range/id/text()}</td></tr>
     <tr><th class="field-label">Name:</th><td>{$range/name/text()}</td></tr>
     <tr><th class="field-label">Description:</th><td>{$range/description/text()}</td></tr>
     </tbody>
  </table>
  
  <table class="span-10">
    <thead>
       <tr>
          <th class="span-3">Label</th>
          <th class="span-1">Relationship</th>
          <th class="span-2">Value</th>
          <th class="span-2 last">Color</th>
          <th class="span-2 last">Color</th>
       </tr>
    </thead>
    <tbody>{for $interval in $intervales
      return
        <tr>
           <th>{$interval/label/text()}</th>
           <th>{$interval/relationship/text()}</th>
           <td>{$interval/value/text()}</td>
           <td>{$interval/color/text()}</td>
           <td bgcolor="{$interval/color/text()}" style="color:{$interval/color/text()};">--</td>
        </tr>
     }</tbody>
  </table>
  
  {if ($debug = 'true')
  then
  <table class="span-6">
      <thead>
         <tr>
            <th class="span-2">Current</th>
            <th class="span-2">Next</th>
            <th class="span-2">Percent</th>
         </tr>
      </thead>
      { for $interval at $count in $intervales
         let $this-width := if ($interval/value/text()) then $interval/value/text() else 0
         let $next := $intervales[$count + 1]/value/text()
         let $next-width := if ($next) then ($next) else 100
         let $this-percentage :=  round($next-width - $this-width)
         return
         <tr>
            <td>{$this-width}</td>
            <td>{$next-width}</td>
            <td>{$this-percentage}</td>
         </tr>
      }
   </table>
   else ()}
   
   <h4>Sample Gauge</h4>
   <table class="span-10">
      <tr>{ for $interval at $count in $intervales
         let $this-width := if ($interval/value/text()) then $interval/value/text() else 0
         let $next := $intervales[$count + 1]/value/text()
         let $next-width := if ($next) then ($next) else 100
         let $this-percentage := round($next-width - $this-width)
         return
         <td width="{$this-percentage}%" bgcolor="{$interval/color/text()}" style="color:{$interval/color/text()};">x</td>
      }</tr>
   </table>

   <div class="edit-controls">
      <a href="../edit/edit.xq?id={$id}">Edit Item</a>
      <a href="../edit/delete-confirm.xq?id={$id}">Delete Item</a>
   </div>
</div>

return style:assemble-page($title, $content)