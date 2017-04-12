xquery version "1.0";

(: Home Page :)

import module namespace style = "http://danmccreary.com/style" at "../../modules/style.xqm";
import module namespace util2 = "http://danmccreary.com/util2" at "../../modules/util2.xqm";

let $title := 'Audit Reports Application'

let $content := 
<div class="content">
      <p>Welcome to the {$title}.
      
      This application creates a list of reports to be used in an audit type situation.</p>
      
      <a href="views/last-modified.xq">List of last modified files</a> A listing of the last modified files in the system.<br/>
      <a href="views/last-created.xq">List of last created files</a> A listing of the last created files in the system.<br/>
      <a href="views/data-collection-perms.xq">Data Permissions</a> List of data collections and the permissions<br/>
      

</div>

return 
    style:assemble-page($title, $content)
