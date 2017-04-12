xquery version "1.0";
import module namespace style = "http://danmccreary.com/style" at "../../modules/style.xqm";

let $title := 'DocBook XRX Application'

let $content := 
    <div>
       <p>The DocBook application is not ready for public access.  See Dan McCreary for updates.</p>
       
       <a href="views/list-items.xq">List DocBook Files</a><br/>
       
       <br/>
       
       <a href="reports/list-reports.xq">List Reports</a><br/>
     </div>
     
return
    style:assemble-page($title, $content)