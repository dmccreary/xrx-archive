xquery version "1.0";
import module namespace style='http://danmccreary.com/style' at '../../../modules/style.xqm';

let $title :='Book Metrics'
let $data-collection := $style:db-path-to-app-data
let $books := collection($data-collection)//book
let $total-books := count($books)
let $book-formats := distinct-values($books//format/text())

let $labels :=
<labels>
   <item>
       <label>Wikibook</label>
       <value>wikibook</value>
  </item>
  <item>
       <label>Hardcover</label>
       <value>hardcover</value>
  </item>
  <item>
       <label>Softcover</label>
       <value>softcover</value>
  </item>
</labels>

let $content :=
<div class='content'>

     <h4>{$title}</h4>
      Counts of books in collection: '{$data-collection}'<br/>
      Count of formats := {count($book-formats)}<br/>
      <table class='span-10'>
         <thead>
            <tr>
               <th>Metric</th>
               <th>Value</th>
            </tr>
         </thead>
         <tbody>
              <tr>
                 <th>Total Books</th>
                 <td>{count($books)}</td>
              </tr>
              {for $format in $book-formats  
                 order by $format
                 return
                    <tr>
                       <th>{$labels//item[value = $format]/label/text()} Books</th>
                       <td>{count($books[./format = $format])}</td>
                    </tr>
              }
         </tbody>
      </table>
</div>
return style:assemble-page($title, $content)