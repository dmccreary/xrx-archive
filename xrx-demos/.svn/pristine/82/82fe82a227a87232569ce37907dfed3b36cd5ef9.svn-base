xquery version "1.0";
import module namespace style='http://danmccreary.com/style' at '../../../modules/style.xqm';
import module namespace train = "http://www.danmccreary.com/training" at "../modules/training.xqm";

let $id := request:get-parameter('id', '')



let $config :=
  <config>
   <view>view-class.xq?id=</view>
   <edit>../edit/edit-class.xq?id=</edit>
   <delete>../edit/delete-confirm-class.xq?id=</delete>
   <publish>../edit/publish-class.xq?id=</publish>
   <xml>../edit/get-instance-class.xq?id=</xml>
</config>

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
let $class := collection($data-collection)/class[id/text() = $id]
let $class-name := $class/name/text()

let $title := concat('View Class ', $class-name)

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
     <tr><th class="field-label">ID:</th><td>{$class/id/text()}</td></tr>
     <tr><th class="field-label">Name:</th><td>{$class/name/text()}</td></tr>
     <tr><th class="field-label">Description:</th><td>{$class/description/text()}</td></tr>
     <tr><th class="field-label">Category:</th><td>{$class/category/text()}</td></tr>
     <tr><th class="field-label">Status:</th><td>{$class/status/text()}</td></tr>
     <tr><th class="field-label">Course Length:</th><td>{$class/length/text()}</td></tr>
     </tbody>
  </table>
  
  <h2>Schedule</h2>
  
  {for $day at $count in $class/schedule/day
  let $review-quiz-id := $day/review-quiz/text()
  let $review-quiz := train:review-quiz($review-quiz-id)
  return
  <div>
    <h3>Day {$count}</h3>
    
    <table class="span-24">
      <thead>
         <tr>
            <th class="span-4">Topic Name</th>
            <th class="span-1">Length</th>
            <th class="span-1">Adj.<br/>Len.</th>
            <th class="span-10">Description</th>
            <th class="span-8 last">Notes</th>
         </tr>
      </thead>
      <tbody>
      
         {
         (: we only put in a quiz if the quiz id is present for that day :)
         if ($review-quiz-id)
         then
         <tr>
              <td><a href="view-review-quiz.xq?id={$review-quiz-id}">Review Quiz</a></td>
              <td>15</td>
              <td></td>
              <td>{$review-quiz/desc/text()}</td>
              <td></td>
           </tr>
           else()
         }
         
         {for $topic in $day/(topic|lab)
          let $topic-id := $topic/topic-id/text()
          let $topic-ref := train:topic($topic-id)
          return
              <tr>
                 <td>
                    <a href="view-topic.xq?id={$topic-id}">{$topic-ref/name/text()} ({$topic-id})</a>
                 </td>
                 <td>{$topic-ref/length/text()}</td>
                 <td>{$topic/adjusted-length/text()}</td>
                 <td>{$topic-ref/description/text()}</td>
                 <td>{$topic/notes/text()}</td>
              </tr>
         }
           <tr>
              <td>Labs</td>
              <td>30</td>
              <td></td>
              <td></td>
              <td></td>
           </tr>
       </tbody>
    </table>
    
    {let $times :=
       for $topic in $day/topic
       return
          let $topic-id := $topic/topic-id/text()
          let $topic-ref := train:topic($topic-id)
          let $adj := $topic/adjusted-length/text()
          return
             if  ($adj) then $adj else $topic-ref/length/text()
      let $total-time := sum($times)
       return
         concat('Total Class Time = ', $total-time, ' minutes = ', $total-time div 60, ' hours')
      }
      <br/><br/>
   </div>
   
  }
  
   {style:view-resources($class/resources)}
  
   {style:edit-controls($id, 'edx', $config)}
</div>

return style:assemble-page($title, $content)