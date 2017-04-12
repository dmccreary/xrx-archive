xquery version "1.0";

import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";
declare namespace xf="http://www.w3.org/2002/xforms";
declare namespace xforms="http://www.w3.org/2002/xforms";
declare namespace ev="http://www.w3.org/2001/xml-events";

declare default element namespace "http://www.w3.org/1999/xhtml";

let $title := 'Test of E-Mail REST Serialization'

(:
https://email.us-east-1.amazonaws.com
?Action=SendEmail
&Source=user%40example.com
&Destination.ToAddresses.member.1=allan%40example.com
&Message.Subject.Data=This%20is%20the%20subject%20line.
&Message.Body.Text.Data=Hello.%20I%20hope%20you%20are%20having%20a%20good%20day.

IN the HTTP Header:
X-Amzn-Authorization: AWS3 AWSAccessKeyId=AKIADQKE4EXAMPLE,
Signature=lBP67vCvGlDMBQ=dofZxg8E8SUEXAMPLE,
Algorithm=HmacSHA256,SignedHeaders=Date;Host

:)

let $style :=
<style type="text/css"><![CDATA[
   @namespace xf url("http://www.w3.org/2002/xforms");
   
.block-form xf|label {
    width: 35ex;
}

.to .xforms-value, .from .xforms-value, .subject .xforms-value {
    width: 50ex;
}

textarea {width: 500px;}
]]></style>

let $model :=
    <xf:model>
       <xf:instance id="save-data">
          <e-mail-message>
             <Action>SendEmail</Action>
             <Source>john.sender%40example.com</Source>
             <Destination_ToAddresses_member_1>person@example.com</Destination_ToAddresses_member_1>
             <Message_Subject_Data>Test Subject</Message_Subject_Data>
             <Message_Body_Text_Data>Hello%20World</Message_Body_Text_Data>
          </e-mail-message>
       </xf:instance>
       
       <!-- http://www.w3.org/TR/xforms11/#submit-header -->
       <xf:submission id="post-submission" method="post"
          action= "echo-post.xq" instance="save-data" replace="all" seperator="&amp;">
             <xf:header>
                <xf:name>X-Amzn-Authorization</xf:name>
                <xf:value>AWS3 AWSAccessKeyId=AKIADQKE4EXAMPLE,Signature=lBP67vCvGlDMBQ=dofZxg8E8SUEXAMPLE,Algorithm=HmacSHA256,SignedHeaders=Date;Host</xf:value> 
             </xf:header>
       </xf:submission>
    </xf:model>

let $content :=
<div class="content">
   <div class="block-form">
        
        <xf:output ref="Action">
           <xf:label>Action: </xf:label>
        </xf:output>
        
        <xf:input ref="Destination_ToAddresses_member_1" class="to">
           <xf:label>To (Destination.ToAddresses.member.1): </xf:label>
        </xf:input>
        
        <xf:input ref="Source" class="from">
           <xf:label>From (Source): </xf:label>
        </xf:input>
        
        <xf:input ref="Message_Subject_Data" class="subject">
           <xf:label>Subject (Message.Subject.Data): </xf:label>
        </xf:input>
        
        <xf:textarea ref="Message_Body_Text_Data">
           <xf:label>Message (Message.Body.Text.Data): </xf:label>
        </xf:textarea>
        
        
   </div>
   
        <xf:submit submission="post-submission">
          <xf:label>Send data to echo-post.xq</xf:label>
        </xf:submit>

</div>

return style:assemble-form($title, (), $style, $model, $content, true())
