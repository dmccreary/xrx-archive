xquery version "1.0";
import module namespace amk-train = "http://www.danmccreary.com/training" at "amk-train.xqm";

 
let $title := 'Sample Web Page'
let $content := <p>Content goes here.</p>
 
return amk-train:assemble-page($title, $content)
