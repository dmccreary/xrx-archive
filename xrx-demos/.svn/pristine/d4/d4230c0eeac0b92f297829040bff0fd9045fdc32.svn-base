xquery version "1.0";
import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";

declare namespace xf="http://www.w3.org/2002/xforms";
declare namespace ev="http://www.w3.org/2001/xml-events";
declare namespace xhtml="http://www.w3.org/1999/xhtml";


let $new := request:get-parameter('new', '')
let $id := request:get-parameter('id', '')
let $title :='Edit User Information' 

return
(: check for required parameters :)
if (not($new or $id))
    then (
    <error>
        <message>Parameter "new" and "id" are both missing.  One of these two arguments is required for form.</message>
    </error>)
    else
      let $app-collection := $style:db-path-to-app
      let $data-collection := concat($app-collection, '/data')

     (: put in the appropriate file name :)
     let $file := if ($new)
        then ('new-instance.xml')
        else (concat('get-instance.xq?id=', $id))
  


let $model :=
      <xf:model>
         <!-- this line loads either the new instance or the current data file into the form model -->
         <xf:instance xmlns="" src="{$file}" id="save-data"/>
         
          <xf:instance xmlns="" src="../code-tables/user-role-codes.xml" id="code-tables"/>
         
        
         <!-- bindings for booleans -->
         <xf:bind nodeset="instance('save-data')/account-active-indicator" type="xs:boolean"/>
        
        <!-- Instance to hold conditional view bindings. -->
            <xf:instance xmlns="" id="views">
                <data>
                    <role-delete-trigger/>
                </data>
            </xf:instance>

         <!-- binds for add/delete trigger visability -->
         <xf:bind id="role-delete-trigger" nodeset="instance('views')/role-delete-trigger" 
                                          relevant="instance('save-data')/roles/role[2]"/>
        
        <xf:submission id="save" method="post" action="{if ($new='true') then ('save-new.xq') else ('update.xq')}" instance="my-task" replace="all"/>
       </xf:model>

 let $content :=
 <div class="content">
    <div class="block-form">
        {if ($id)
           then (
           <xf:output ref="id" class="id">
               <xf:label>ID:</xf:label>
           </xf:output>
        ) else ()}
    

        <xf:input ref="person-given-name" class="person-given-name">
            <xf:label>Given Name : </xf:label>
        </xf:input>
        
        <xf:input ref="person-family-name" class="person-family-name">
            <xf:label>Family name : </xf:label>
        </xf:input>
        
        <xf:input ref="account-active-indicator" class="account-active-indicator">
            <xf:label>Active: </xf:label>
        </xf:input>
        
        <xf:input ref="max-login-retrys" class="max-login-retrys">
            <xf:label>Max Retrys : </xf:label>
        </xf:input>
        
        <xf:input ref="session-timeout-minutes" class="session-timeout-minutes">
            <xf:label>Session Timeout (Minutes): </xf:label>
        </xf:input>
       
     </div>
        
  <br/>
      <fieldset class="span-8">
      <legend>Roles</legend>
            
            <xf:repeat nodeset="instance('save-data')/roles/role" id="role-repeat">
                             
               <xf:select1 ref=".">
                    <xf:label>Role:</xf:label>
                    <xf:hint>A way to classify each User.</xf:hint>
                    <xf:itemset nodeset="instance('code-tables')//items/item">
                      <xf:label ref="label"/>
                      <xf:value ref="value"/>
                   </xf:itemset>
                </xf:select1>
           
           
                <xf:trigger bind="role-delete-trigger">
                    <xf:label>Delete</xf:label>
                    <xf:delete nodeset="instance('save-data')/roles/role[index('role-repeat')]" ev:event="DOMActivate"/>
                </xf:trigger>
                
            </xf:repeat>
            <xf:trigger>
                <xf:label>Add Role</xf:label>
                <xf:action ev:event="DOMActivate">
                    <xf:insert nodeset="instance('save-data')/roles/role" at="last()" position="after"/>
                    <xf:setvalue ref="instance('save-data')/roles/role[last()]" value="''"/>
                </xf:action>
            </xf:trigger>
 </fieldset>
        <xf:submit submission="save">
            <xf:label>Save</xf:label>
        </xf:submit>

</div>

return 
    style:assemble-form($title, (), (), $model, $content, true())
