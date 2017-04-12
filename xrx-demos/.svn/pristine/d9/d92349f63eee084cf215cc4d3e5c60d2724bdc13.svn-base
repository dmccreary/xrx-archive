xquery version "1.0";
import module namespace style = "http://danmccreary.com/style" at "../../modules/style.xqm";


let $data := request:get-data()
let $tokens := tokenize($data, '&amp;')
let $user := substring-after($tokens[1], 'user=')
let $pass := substring-after($tokens[2], 'pass=')
let $return := substring-after($tokens[3], 'return=')
let $unescape-uri := request:unescape-uri($return, 'UTF-8')
let $fix-first-param := replace($unescape-uri, 'xq&amp;', 'xq?')
let $login-success-indicator := xmldb:login("/db/crossflo", $user, $pass)

let $title:='Login Status'
return
let $content :=
<div class="content">
     {if ($login-success-indicator)
         then <p>Your Login Was Successful <a href="{$fix-first-param}">Return</a></p>
         else <p>Login Failed <a href="login-form.xq">Try Again</a></p>
      }
      You are logged in as {xmldb:get-current-user()}<br/>
      Return {$fix-first-param}
      <br/>
      <a href="logout.xq">Logout</a>

</div>

return style:assemble-page($title, $content)
