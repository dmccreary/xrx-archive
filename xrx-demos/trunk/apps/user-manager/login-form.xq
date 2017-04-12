xquery version "1.0";
import module namespace style = "http://danmccreary.com/style" at "../../modules/style.xqm";

let $title :='Login'
let $user := xmldb:get-current-user()

(: this gets the entire input URL :)
let $get-query-string := request:get-query-string()

(: were are only intereted in the portion after the return= :)
let $return-uri := 
   if (substring-after($get-query-string, 'return='))
      then (substring-after($get-query-string, 'return='))
      else concat($style:db-path-to-app, '/index.xq')

let $content :=
<div class="content">
  <p>Current User = {$user}</p>
  <center>
   <form action="login.xq" method="post">
     <table class="login span-7" border="1">
       <tr >
         <td class="span-2" align="right">Username:</td>
         <td class="span-5" ><input name="user" type="text" size="20"/></td>
       </tr>
       <tr>
         <td align="right">Password:</td>
         <td><input name="pass" type="password" size="20"/></td>
       </tr>

     </table>
   <input name="return" type="hidden" value="{$return-uri}" size="20"/>
   <input type="submit" value="Login"/>
  </form>
  </center>
  You will be redirected to the following URI on success: {$return-uri}<br/>
  </div>
  
  return style:assemble-page($title, $content)
