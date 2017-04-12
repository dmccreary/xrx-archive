xquery version "1.0";
import module namespace style='http://danmccreary.com/style' at '../../modules/style.xqm';

let $title :='Metadata Shopper'
    
let $content :=
<div class="content">

 <p>Welcome to the Metatdata Shopper.  This application allows users to shop for the appropriate data elements
    from the registry to build XML Schemas.</p>
     <ol>
         <li>
             <a href="shopping-cart-form.xq">Shopper</a> Metadata Shopping Tool
         </li>
          
     </ol>
</div>

return 
    style:assemble-page($title, $content)