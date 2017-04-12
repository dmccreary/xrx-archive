xquery version "1.0";

import module namespace style='http://danmccreary.com/style' at '../../../modules/style.xqm';

let $title := 'Login Form With Remember Me'

let $user := xmldb:get-current-user()

let $content := 
    <div class="content">
      <script language="JavaScript" src="cookie-01.js"/>
     
      <form method="POST" action="echo-post-html-form.xq">
        <table class="span-10">
      		<tr>
      			<td class="span-2">
      			   <label for='wpName1'>Username:</label>
      			</td>
      			<td>
      				<input size="20" type="text" value="{$user}" name="user" />
      			</td>
      		</tr>
      		<tr>
      			<td class="span-2">
      			   <label for='password'>Password:</label>
      			</td>
      			<td>
      				<input size="20" type="password" name="password" />
      			</td>
      	   </tr>
      	   <tr>
      			<td class="span-2"></td>
      			<td>
      				<input name="remember" type="checkbox" value="1" />
      				<label for="remember">Remember me (up to 180 days)</label>
      		  </td>
      		</tr>
      		<tr>
      			<td class="span-2"></td>
      			<td>
      				<input type="submit" value="Log in" name="login" />
      				<a href="../../../../pub/forms/password-reset-form.xq" title="Reset your password"> Forgotten your login details?</a>
      			</td>
      		</tr>
          </table>
        
      </form>
      
      <input type="button" onclick="checkCookie()" value="Check Cookie" />  
    </div>                                           

return
    style:assemble-page($title, $content)
