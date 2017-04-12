xquery version "1.0";
import module namespace style = "http://danmccreary.com/style" at "../../modules/style.xqm";

let $null := xmldb:login("/db", "guest", "guest") 

let $user := xmldb:get-current-user()
let $title :='You have been logged out'

let $content :=
<div class="content">
      <p>User = {$user}</p>
      <a href="login-form.xq">Login</a>
</div>

return style:assemble-page($title, $content)