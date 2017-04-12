xquery version "1.0";
import module namespace style='http://danmccreary.com/style' at '../../../modules/style.xqm';
import module namespace train = "http://www.danmccreary.com/training" at "../modules/training.xqm";

let $title := 'List Topic Categories'

let $app-collection := $style:db-path-to-app
let $data-collection := concat($app-collection, '/data/topics')
let $training-topics := collection($data-collection)//training-topics

let $content :=
<div class="content">
<p>The following is a list of all possible training topics that might be
included on a course.  Topics each have many possible resources that
can be used by the instructor.</p>
       <table class="span-24">
           <thead>
           <tr>
              <th class="span-3">Topic Name (ID)</th>
              <th class="span-10">Topic Description</th>
              <th class="span-1 last">Number Topics</th>
           </tr>
        </thead>
        <tbody>{
          for $training-topic in $training-topics
             let $id := $training-topic/id/text()
             let $labs := train:count-labs-for-class($id)
             order by $id
          return
             <tr>
                 <td><a href="list-topics.xq?category={$id}">{$training-topic/name/text()}</a> ({$id})</td>
                 <td>{$training-topic/description/text()}</td>
                 <td>{count($training-topic/topic)}</td>
             </tr> 
       }</tbody></table>
  
</div>

return style:assemble-page($title, $content)