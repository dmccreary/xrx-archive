xquery version "1.0";
import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";

let $title := 'Send Email Via Amazon Simple Mail Service'

let $content := 
<div class="content">
    <style type="text/css"><![CDATA[
      tbody tr th {text-align: right}
      textarea {width: 500px;}
    ]]></style>
    <div id="searchform">
        <form method="get" action="echo-get.xq">
            <table>
               <tbody>
                    <tr>
                        <th><label>From:</label></th>
                        <td><input name="Source" type="text" value="john@example.com" size="60"/></td>
                    </tr>
                    
                    <tr>
                        <th><label>To:</label></th>
                        <td><input name="Destination.ToAddresses.member.1" type="text" value="sue@example.com" size="60"/></td>
                    </tr>
                    
                    <tr>
                        <th><label>Subject:</label></th>
                        <td><input name="Message.Subject.Data" type="text" value="test message" size="60"/></td>
                    </tr>
                    
                    <tr>
                        <th><label>Message:</label></th>
                        <td><textarea name="Message.Body.Text.Data" type="text" value="message body"/></td>
                    </tr>
                </tbody>
            </table>
            
            <input name="Action" type="hidden" value="SendEmail"/>
            <input type="submit" value="Send Via HTTP GET"/>
        </form>
     </div>
</div>

return style:assemble-page($title, $content)
