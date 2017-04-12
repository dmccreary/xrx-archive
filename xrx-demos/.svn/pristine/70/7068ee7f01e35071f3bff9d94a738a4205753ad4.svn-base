xquery version "1.0";
import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";
declare namespace xf="http://www.w3.org/2002/xforms";
declare namespace ev="http://www.w3.org/2001/xml-events";

let $input := request:get-parameter('in', '')
let $input2 := request:get-parameter('in2', '')

let $title := 'Validate Form With 2 Fields'

let $model :=
 <xf:model>
       
        <xf:instance id="save-data">
            <data xmlns="">
                <id>{$input}</id>
                <id2>{$input2}</id2>
                <both/>
            </data>
        </xf:instance>
       
       
         <xf:instance id="error-message">
            <data xmlns="">
                <message>not ready</message>
            </data>
        </xf:instance>
        
        <xf:instance id="control-instance">
            <control xmlns="">
                <dirty>false</dirty>
                <form-rules>false</form-rules>
            </control>
        </xf:instance>

        /* these are the simple binds for each field */
        <xf:bind nodeset="id" constraint="string-length(.) = 3"/>
        <xf:bind nodeset="id2" constraint="string-length(../id2) = 3"/>
        
        <xf:action ev:event="xforms-ready">
          <xf:setvalue ref="instance('error-message')/message" value="'xforms-ready'"/>
        </xf:action>
        
        <xf:action ev:event="xforms-valid">
          <xf:setvalue ref="instance('error-message')/message" value="'xforms-valid'"/>
        </xf:action>

        <xf:submission id="save-submission" method="post" action="echo-post.xq" instance="save-data">
           <!-- <xf:message ev:event="xforms-submit" level="modal">Submitting...</xf:message> -->
           <xf:setvalue ev:event="xforms-submit-done" ref="instance('error-message')/message" value="'xforms-submit-done'"/>
           <xf:message ev:event="xforms-submit-error" level="modal">Cannot submit!</xf:message>

        </xf:submission>
       
</xf:model>

let $content :=
<div class='content'>
 
 <xf:group>
  <xf:action ev:event="xforms-valid">
     <xf:setvalue ref="instance('error-message')/message" value="'xforms-valid'"/>
  </xf:action>
  
  <xf:action ev:event="xforms-value-changed">
     <xf:setvalue ref="instance('control-instance')/dirty" value="'true'"/>
     <xf:toggle case="save" if="(string-length(instance('save-data')/id) = 3) and (string-length(instance('save-data')/id2) = 3) and instance('control-instance')/dirty = 'true'"/>
     <xf:toggle case="no-save" if="not((string-length(instance('save-data')/id) = 3) and (string-length(instance('save-data')/id2) = 3) and instance('control-instance')/dirty = 'true')"/>
     <xf:setvalue ref="instance('control-instance')/field-rules" value="(string-length(instance('save-data')/id) = 3) and (string-length(instance('save-data')/id2) = 3)"/>
  </xf:action>
  
  <xf:group ref="instance('control-instance')/field-rules = 'true'">
    <xf:submit submission="save-submission">
             <xf:label>Save</xf:label>
    </xf:submit>
    <br/>
  </xf:group>
       
  <xf:input ref="id" incremental="true">
     <xf:label>ID: </xf:label>
     <xf:action ev:event="xforms-invalid">
         <xf:setvalue ref="instance('error-message')/message" value="'error'"/>
     </xf:action>
     <xf:action ev:event="xforms-valid">
          <xf:setvalue ref="instance('error-message')/message" value="'field 1 valid'"/>
     </xf:action>
     <xf:hint>Must be exactly three characters</xf:hint>
  </xf:input>
  <br/>
 
  <xf:input ref="id2" incremental="true">
     <xf:label>ID 2: </xf:label>
     <xf:action ev:event="xforms-invalid">
         <xf:setvalue ref="instance('error-message')/message" value="'error'"/>
     </xf:action>
     <xf:action ev:event="xforms-valid">
          <xf:setvalue ref="instance('error-message')/message" value="'field 2 valid'"/>
     </xf:action>
     <xf:hint>Must be exactly three characters</xf:hint>
  </xf:input>
 
 </xf:group>
 
 
 
 
 <xf:switch>
    <xf:case id="no-save">
       <xf:submit>
           <xf:label>Save Disabled</xf:label>
       </xf:submit>
    </xf:case>
    <xf:case  id="save">
        <xf:submit submission="save-submission">
           <xf:label>Save</xf:label>
       </xf:submit>
    </xf:case>
 </xf:switch>
 
    Debugging Information:<br/>
    <xf:output ref="instance('control-instance')/dirty">
         <xf:label>Dirty: </xf:label>         
    </xf:output>
   
   <xf:output ref="instance('control-instance')/field-rules">
       <xf:label>Field Rules: </xf:label>         
   </xf:output>
   
    <xf:group ref="instance('error-message')/message">
        <div class="field-warn">
          <xf:output ref="instance('error-message')/message">
             <xf:label>form validation status: </xf:label>         
          </xf:output>
        </div>
  </xf:group>
  
  </div>
  
  return style:assemble-form($title, (), (), $model, $content, true())