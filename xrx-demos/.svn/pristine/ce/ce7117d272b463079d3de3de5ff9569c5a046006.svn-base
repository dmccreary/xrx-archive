xquery version "1.0";
import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";
declare default element namespace "http://www.w3.org/1999/xhtml";
declare namespace xf="http://www.w3.org/2002/xforms";
declare namespace ev="http://www.w3.org/2001/xml-events";

declare default element namespace "http://www.w3.org/1999/xhtml";

let $title := 'Test Catch Service'

let $style := <style><![CDATA[
  .xforms-value {
      width: 60ex;
   }
]]></style>

let $model :=
    <xf:model>
       <xf:instance xmlns="" id="save-data" src="test-message.xq"/>
      
       <xf:submission id="save-submission" method="post"
          action="catch-post.xq" instance="save-data" replace="all"/>
    </xf:model>

let $content :=
<div class="content">
        
        <fieldset>
           <legend><span class="legend">Headers</span></legend>
           
                <xf:output ref="headers/date" class="date">
                   <xf:label>DateTie: </xf:label>
                </xf:output>
                <br/>
                
                <div class="block-form">
                <xf:input ref="headers/from/address" class="address">
                   <xf:label>From: </xf:label>
                </xf:input>
                <br/>
                
               <xf:input ref="headers/to/address" class="address">
                   <xf:label>To: </xf:label>
                </xf:input>
                <br/>
                
                <xf:input ref="headers/subject" class="subject">
                   <xf:label>Subject: </xf:label>
                </xf:input>
                <br/>
                

                
                </div>
        </fieldset>
        
        <xf:textarea ref="body/text" class="body">
           <xf:label>Message: </xf:label>
           <xf:hint>Test Message</xf:hint>
        </xf:textarea>
        <br/>
        
        <xf:submit submission="save-submission">
           <xf:label>Test Post Messsage</xf:label>
        </xf:submit>

        <div class="debug">
        <xf:output value="count(instance('save-data')/*/*)">
           <xf:label>Total Elements: </xf:label>
        </xf:output>
        </div>
    
</div>

return style:assemble-form($title, (), $style, $model, $content, true())
