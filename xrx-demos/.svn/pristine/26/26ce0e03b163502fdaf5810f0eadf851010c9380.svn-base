xquery version "1.0";
import module namespace style='http://danmccreary.com/style' at '../../../modules/style.xqm';
import module namespace train = "http://www.danmccreary.com/training" at "../modules/training.xqm";


let $category := request:get-parameter('category', '')

let $app-collection := $style:db-path-to-app
let $data-collection := concat($app-collection, '/data/topics')
let $topics :=
   if ($category)
      then collection($data-collection)/training-topics/topic[../id/text() = $category]
      else collection($data-collection)/training-topics/topic

let $title := 'List Topics'

let $content :=
<div class="content">
{if ($category) then <div>Trainng Topic Category = {$category}</div> else () }
<p>The following is a list of all possible training topics that might be
included on a course.  Topics each have many possible resources that
can be used by the instructor.</p>
       <table class="span-24">
           <thead>
           <tr>
              <th class="span-5">Name (ID)</th>
              <th class="span-13">Description</th>
              <th class="span-1 last">Prerequisites</th>
           </tr>
        </thead>
        <tbody>{
          for $topic in $topics
             let $id := $topic/id/text()
             let $labs := train:count-labs-for-class($id)
             order by $id
          return
             <tr>
                 <td><a href="view-topic.xq?id={$id}">{$topic/name/text()}</a> ({$id})</td>
                 <td>{$topic/description/text()}</td>
                 <td>{string-join($topic//prerequsites/topic-id/text(), ', ')}</td>
             </tr> 
       }</tbody></table>
  
</div>

return style:assemble-page($title, $content)