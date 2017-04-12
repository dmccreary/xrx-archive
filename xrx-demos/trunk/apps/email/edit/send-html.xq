xquery version "1.0";
import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";

let $title := 'Send Email Via Amazon Simple Mail Service'

let $content := 
<div class="content">
    <style type="text/css"><![CDATA[
      tbody tr th {text-align: right}
    ]]></style>
    <div id="searchform">
        <form method="post" action="echo-post.xq">
            <table>
               <tbody>
                    <tr>
                        <th><label>From:</label></th>
                        <td><input name="from" type="text" value="john@example.com" size="60"/></td>
                    </tr>
                    
                    <tr>
                        <th><label>To:</label></th>
                        <td><input name="to" type="text" value="sue@example.com" size="60"/></td>
                    </tr>
                    
                    <tr>
                        <th><label>Subject:</label></th>
                        <td><input name="subject" type="text" value="test message" size="60"/></td>
                    </tr>
                    
                    <tr>
                        <th><label>Message:</label></th>
                        <td><textarea name="message" type="text" value="message body"/></td>
                    </tr>
                </tbody>
                <input type="submit" value="Send"/>
            </table>
        </form>
     </div>
</div>

return style:assemble-page($title, $content)
