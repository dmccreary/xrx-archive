xquery version "1.0";
import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";
import module namespace email = "http://www.danmccreary.com/xrx/email" at "../modules/email.xqm";

let $page-title := 'Listing E-mail Messages'



let $data-collection := $style:db-path-to-app-data
let $start:= xs:integer(request:get-parameter('start', '1'))
let $num := xs:integer(request:get-parameter('num', '5'))
let $category := request:get-parameter('category', '')


(: if we have a specific category then we limit our results to only messages with this category :)
let $messages := 
   if ($category)
   then collection($data-collection)//message[headers/categories/category/text()=$category]
   else collection($data-collection)//message
   
let $sorted-messages :=
   for $message in $messages
   let $date :=
     if ($message//date/text() castable as xs:dateTime)
       then $message//date/text()
       else current-dateTime()
   order by xs:dateTime($date) descending
   return $message
   
let $count := count($messages)

let $content := 
    <div class="content">
       
       <p>Collection: {$data-collection}</p>
       <p>{$count} messages found</p>
       
      {email:prev-next-controls($start, $num, $count, $category)}
       <table>
          <thead>
             <tr>
                <th class="span-1">ID</th>
                <th class="span-4">From</th>
                <th class="span-3">Categories</th>
                <th class="span-6">Subject</th>
                <th class="span-3">Date/Time</th>
             </tr>
          </thead>
       
       {
         for $message in subsequence($sorted-messages, $start, $num)
            let $id := $message/id/text()
            let $from := concat($message//from/label/text(), ' ', $message//from/address/text())
            let $categories := string-join($message//category/text(), ', ')
            let $subject := $message//subject/text()
            let $date := $message//date/text()
            return
               <tr>
                  <td><a href="view-item.xq?id={$id}">{$id}</a></td>
                  <td>{$from}</td>
                  <td>{$categories}</td>
                  <td>{$subject}</td>
                  <td>{$date}</td>
               </tr>
               
      }</table>
      {email:prev-next-controls($start, $num, $count, $category)}
</div>

return style:assemble-page($page-title, $content)

