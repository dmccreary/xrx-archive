xquery version "1.0";
import module namespace style = "http://danmccreary.com/style" at "../../modules/style.xqm";

let $title := 'Rule Manager'

let $data-collection := $style:db-path-to-app-data

let $content := 
    <div class="content">
       <ul>
          <a href="views/list-items.xq">List</a> List of Rules imported from the JIEM system<br/>
          <a href="views/starts-with.xq">A-Z Listing</a> List of Rules that start with a specific letter<br/>
          <a href="suggest/suggest-form2.xq">Suggest XForms</a> As you type suggest form that depends on a suggest condition service.
             In this example the suggestions are displayed in the right margin.<br/>
          <a href="suggest/n-rules.xq">Suggest N-Conditions</a> Allows the user to add any number of conditions to the system.<br/>
          <a href="suggest/suggest-items.xq?prefix=a">Suggest Service</a> Demonstration of underlying RESTful XML
             suggest service used by suggest form.<br/>
             In this example all items that begin with the letter "a" are returned.<br/>
       </ul>
</div>

return style:assemble-page($title, $content)