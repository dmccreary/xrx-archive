xquery version "1.0";

(: List Items :)

import module namespace style = "http://danmccreary.com/style" at "../../modules/style.xqm";
import module namespace util2 = "http://danmccreary.com/util2" at "../../modules/util2.xqm";

let $title := 'S3 Manager'

let $content := 
<div class="content">
      <p>Welcome to the {$title}.
      
      This application is a series of unit tests for Amazon S3.</p>
      
      
      <a href="unit-tests/01-view-one-image.xq">View One </a> View One Image Stored on S3 <br/>
      
      <a href="unit-tests/02-view-five-images.xq">View All</a> View Five Images Stored on S3<br/>
      
</div>

return 
    style:assemble-page($title, $content)
