xquery version "1.0";

import module namespace style='http://danmccreary.com/style' at '../../../modules/style.xqm';

let $title := 'Cookie Test'

let $content := 
    <div class="content">
      <script language="JavaScript" src="cookie-01.js"/>
      Test driver for cookie.js functions.
      
      This program will ask you your name the first time you use it.  It will then welcome you back with the same name.
      You can use the <a href="https://addons.mozilla.org/en-US/firefox/addon/firecookie">Firecooke</a> FireBug addon / to view, change and delete the cookies.
      
      <form>
         <input type="button" onclick="checkCookie()" value="Check Cookie" />  
      </form>
    </div>                                           

return
    style:assemble-page($title, $content)
