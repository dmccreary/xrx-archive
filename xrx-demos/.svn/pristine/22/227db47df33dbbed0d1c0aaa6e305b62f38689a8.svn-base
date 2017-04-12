xquery version "1.0";

(: List Items :)
import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";

let $title := 'View 1 image on Amazon S3'

let $content := 
<div class="content">
      <p>Welcome to the {$title}.
      
      This unit test displays one image that is stored on S3.</p>
           
      <a href="https://s3.amazonaws.com/anns-test-bucket/baby-ann.jpg">Baby Ann</a> A Picture of Ann at 2 years old <br/>

       
</div>

return 
    style:assemble-page($title, $content)
