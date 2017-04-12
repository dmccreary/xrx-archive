xquery version "1.0";

(: List Items :)
import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";


let $title := 'View Five Images on S3'

let $content := 
<div class="content">
           
      <a href="https://s3.amazonaws.com/anns-test-bucket/baby-ann.jpg">Baby Ann</a> A Picture of Ann at 2 years old <br/>
      
      <a href="https://s3.amazonaws.com/anns-test-bucket/babyd-and-gram.jpg">Baby D and Gram</a> A Picture of Maureen and Dana<br/>
      
      <a href="https://s3.amazonaws.com/anns-test-bucket/dan-is-fifty.jpg">Dan at Fifty</a> APicture of Dan at his 50th Birthday Dinner<br/>
            
      <a href="https://s3.amazonaws.com/anns-test-bucket/great-grandpa.jpg">Great Grandpa</a> A Picture of Great Grandpa Bill and Baby Dana<br/> 
      
      <a href="https://s3.amazonaws.com/anns-test-bucket/nano-image.jpg">Nano Finisher</a> My Nanowrimo Finisher Certificat for 2011<br/> 
       
</div>

return 
    style:assemble-page($title, $content)
