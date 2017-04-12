xquery version "1.0";
import module namespace style='http://danmccreary.com/style' at '../../../modules/style.xqm';
declare namespace xf="http://www.w3.org/2002/xforms";
declare namespace ev="http://www.w3.org/2001/xml-events";
declare namespace xhtml="http://www.w3.org/1999/xhtml";


let $new := request:get-parameter('new', '')
let $id := request:get-parameter('id', '')

let $title :='Edit Project'
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
      let $code-tables-collection := concat($app-collection, '/code-tables')

     (: put in the appropriate file name :)
     let $file := 
       if ($new)
        then ('new-instance.xml')
        else (concat('get-instance.xq?id=', $id))

 
let $model := 
       <xf:model>
           <!-- this line loads either the new instance or the current data file into the form model -->
           <xf:instance xmlns="" src="{$file}" id="save-data"/>
           <xf:submission id="save" method="post" action="{if ($new='true') then ('save-new.xq') else ('update.xq')}" instance="my-task" replace="all"/>
 
           <xf:instance xmlns="" id="views">
                <data>
                    <delete-role-trigger/>
                </data>
            </xf:instance>    
           
           <xf:bind id="delete-role-trigger" nodeset="instance('views')/delete-role-trigger" 
               relevant="instance('save-data')/PersonRoles/Role[2]"/>
     
       </xf:model>

let $content :=
<div class="content">

     {if ($id)
        then (
           <xf:output ref="id" class="id">
               <xf:label>ID:</xf:label>
           </xf:output>
        ) else ()}
       
       <div class="block-form">
       <xf:input ref="ProjectName" class="ProjectName">
           <xf:label>Project Name:</xf:label>
       </xf:input>
       
       <xf:textarea ref="ProjectDescriptionText" class="ProjectDescriptionText">
           <xf:label>Project Description:</xf:label>
       </xf:textarea>
       
      <xf:textarea ref="ProjectScopeText" class="ProjectScopeText">
           <xf:label>Project Scope:</xf:label>
       </xf:textarea>
        
      <xf:textarea ref="ProjectBusinessObjectivesText" class="ProjectBusinessObjectivesText">
           <xf:label>Business Objectives:</xf:label>
       </xf:textarea>
       
    
       <xf:textarea ref="ProjectImplementationStratagyText" class="ProjectImplementationStratagyText">
           <xf:label>Project Implementation Stratagy:</xf:label>
       </xf:textarea>
       
 <!--
       <xf:select1 ref="DevelopmentStatusCode" class="status">
          <xf:label>Development Status:</xf:label>
           {for $code in doc(concat($code-tables-collection, "/development-status-code.xml"))/*:code-table/*:items/*:item
           return
              <xf:item>
                 <xf:label>{$code/*:label/text()}</xf:label>
                 <xf:value>{$code/*:value/text()}</xf:value>
              </xf:item>
           }
       </xf:select1>
       -->
       </div>
       

       
<!--      <div class="project-requirements">
           <xf:label class="repeat-label">Requirements:</xf:label>
           <table>
              <thead>
                 <tr>
                    <th class="RequirementID">Id</th>
                    <th class="RequirementName">Name</th>
                    <th class="RequirementLink">Link</th>
                 </tr>
              </thead>
           </table>
           
           <xf:repeat nodeset="instance('save-data')/Requirements/Requirement" id="requirement-repeat">
                <xf:input ref="RequirementID" class="RequirementID"/>
                <xf:input ref="RequirementName"  class="RequirementName"/>
                <xf:trigger appearance="minimal" class="link-to-requirement">
                    <xf:label>Go To Requirement</xf:label>
                    <xf:action ev:event="DOMActivate">
                       <xf:setvalue ref="instance('current-url')/url"
                          value="concat('../views/view-requirement.xq?id=', instance('save-data')/Requirements/Requirement[index('requirement-repeat')]/RequirementID)"/>
                        <xf:load ref="instance('current-url')/url"/>
                    </xf:action>
                </xf:trigger>      
                <xf:trigger>
                   <xf:label>Delete</xf:label>
                   <xf:delete ev:event="DOMActivate" nodeset="instance('save-data')/Requirements/Requirement[index('requirement-repeat')]"/>
                </xf:trigger>
            </xf:repeat>  
           <xf:switch>
              <xf:case id="hide">
                 <xf:trigger>
                   <xf:label>Add New Requirement</xf:label>
                   <xf:toggle case="show" ev:event="DOMActivate"/>
               </xf:trigger>
              </xf:case>
              <xf:case id="show">  
             
                 <div id="add-requirment-background">
                    <div id="add-requirment-box">
                 <h1>Add Requirment to This Project</h1>
                 <xf:repeat nodeset="instance('all-requirements')/Requirement" id="all-requirement-repeat">
                     <xf:trigger>
                           <xf:label>Add</xf:label>
                           <xf:action ev:event="DOMActivate">
                               <xf:insert
                             origin="instance('all-requirements')/Requirement[index('all-requirement-repeat')]"                        
                             nodeset="instance('save-data')/Requirements/Requirement"/>
                           </xf:action>
                       </xf:trigger>
                       <xf:output ref="RequirementName"  class="RequirementName"/>
                   </xf:repeat>

                   <xf:trigger class="center">
                      <xf:label>Close</xf:label>
                      <xf:toggle case="hide" ev:event="DOMActivate"/>
                  </xf:trigger>
                  </div>
                  </div>
              </xf:case>
           </xf:switch>     
       </div>
-->

 
       
       <div class="project-roles">
           <xf:label class="repeat-label">Project Roles:</xf:label>
           <xf:repeat nodeset="instance('save-data')/PersonRoles/Role" id="role-repeat">
                <xf:input ref="UserID" id="user-id-input">
                 <xf:label>User ID:</xf:label>
                </xf:input>

                <xf:select1 ref="PersonRoleCode"  class="status">
                    {for $item in doc(concat($code-tables-collection, "/project-role-code.xml"))/*:code-table/*:items/*:item
                    return
                      <xf:item>
                         <xf:label>{$item/*:label/text()}</xf:label>
                         <xf:value>{$item/*:value/text()}</xf:value>
                      </xf:item>
                    }
                </xf:select1>
               
                <xf:trigger bind="delete-role-trigger">
                   <xf:label>Delete</xf:label>
                   <xf:delete ev:event="DOMActivate" nodeset="instance('save-data')/PersonRoles/Role[index('role-repeat')]"/>
                </xf:trigger>
                   
           </xf:repeat>
               
               <xf:trigger>
                   <xf:label>Add New Person/Role</xf:label>
                   <xf:action ev:event="DOMActivate">
                       <xf:insert nodeset="instance('save-data')/PersonRoles/Role" at="last()" position="after"/>
                       <xf:setvalue ref="instance('save-data')/PersonRoles/Role[index('role-repeat')]/UserID[last()]" value=""/>
                       <xf:setvalue ref="instance('save-data')/PersonRoles/Role[index('role-repeat')]/PersonRoleCode[last()]" value=""/>
                       <xf:setfocus control="user-id-input"/>
                   </xf:action>
               </xf:trigger>
       </div>
       <xf:submit submission="save">
           <xf:label>Save</xf:label>
       </xf:submit>
</div>
return style:assemble-form($title, (), (), $model, $content, true())
