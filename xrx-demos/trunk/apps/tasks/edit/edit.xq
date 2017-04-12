xquery version "1.0";
import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";
declare namespace xf="http://www.w3.org/2002/xforms";
declare namespace ev="http://www.w3.org/2001/xml-events";
declare namespace xhtml="http://www.w3.org/1999/xhtml";

let $new := request:get-parameter('new', '')
let $id := request:get-parameter('id', '')

return
(: check for required parameters :)
if (not($new or $id))
    then (
    <error>
        <message>Parameter "new" and "id" are both missing.  One of these two arguments is required for form.</message>
    </error>)
    else
      let $title :='Task Editor'
      let $app-collection := $style:db-path-to-app
      let $data-collection := concat($app-collection, '/data')

     (: put in the appropriate file name :)
 let $file := 
    if ($new) then 
        'new-instance.xml'
    else 
        concat('get-instance.xq?id=', $id)
        
     let $model :=
        <xf:model>
            <xf:instance xmlns="" id="my-task" src="{$file}"/>
            <xf:bind nodeset="instance('my-task')/task-name" required="true()"/>
            <xf:bind nodeset="instance('my-task')/task-description" required="true()"/>           
            <xf:bind nodeset="instance('my-task')/starred-task-indicator" type="xs:boolean"/>
          
            <!-- these are used to bind to conditional views or triggers-->
            <xf:instance xmlns="" id="views">
                <data>
                    <task-assigned-view/>
                    <delete-tag-trigger/>
                    <delete-depends-on-trigger/>
                    <delete-resource-trigger/>
                </data>
            </xf:instance>

            <xf:bind id="delete-tag-trigger" nodeset="instance('views')/delete-tag-trigger" relevant="count(instance('my-task')/tag) > 1"/>
            <xf:bind id="delete-depends-on-trigger" nodeset="instance('views')/delete-depends-on-trigger" relevant="count(instance('my-task')/depends-on) > 1"/>
            <xf:bind id="delete-resource-trigger" nodeset="instance('views')/delete-resource-trigger" relevant="count(instance('my-task')/tag) > 1"/>
            
            <xf:instance xmlns="" id="code-tables" src="all-codes.xq"/>
           
            <xf:submission id="save" method="post" action="{if ($new='true') then ('save-new.xq') else ('update.xq')}" instance="my-task" replace="all"/>
            <xf:submission id="echo-test" method="post"  instance="my-task" replace="all"/>
        </xf:model>
        
let $content :=
<div class="content">{   
   <body>     
        <div class="block-form">
        <xf:input ref="task-name" class="task-name">
            <xf:label>Task Name:</xf:label>
            <xf:hint>The name of a task up to 50 characters.</xf:hint>
        </xf:input>
        
        <xf:textarea class="task-description" ref="task-description">
            <xf:label>Description:</xf:label>
            <xf:hint>A description of this task including dependancies, reproducability, resources required and relevence to the project.</xf:hint>
        </xf:textarea>

        <xf:select1 ref="instance('my-task')/task-type-code">
            <xf:label>Type:</xf:label>
            <xf:itemset nodeset="instance('code-tables')/code-table[name='task-type-code']/item">
                    <xf:label ref="label"/>
                    <xf:value ref="value"/>
                </xf:itemset>
        </xf:select1>

        <xf:select1 ref="instance('my-task')/task-priority-code">
            <xf:label>Priority:</xf:label>
            <xf:itemset nodeset="instance('code-tables')/code-table[name='task-priority-code']/item">
                    <xf:label ref="label"/>
                    <xf:value ref="value"/>
                </xf:itemset>
        </xf:select1>

        <xf:select1 ref="instance('my-task')/task-completion-status-code">
            <xf:label>Completion Status:</xf:label>
            <xf:itemset nodeset="instance('code-tables')/code-table[name='task-completion-status-code']/item">
                    <xf:label ref="label"/>
                    <xf:value ref="value"/>
                </xf:itemset>
        </xf:select1>

        <xf:select1 ref="instance('my-task')/task-assigned-person">
            <xf:label>Assigned to:</xf:label>
            <xf:itemset nodeset="instance('code-tables')/code-table[name='task-assigned-to-code']/item">
                    <xf:label ref="label"/>
                    <xf:value ref="value"/>
                </xf:itemset>
        </xf:select1>
        
        <xf:input ref="instance('my-task')/starred-task-indicator">
            <xf:label>Starred Task:</xf:label>
            <xf:hint>An indication that this task should have priority.</xf:hint>
        </xf:input>
        </div>
        
       <xf:repeat id="depends-on-repeat" nodeset="instance('my-task')/depends-on">
            <xf:input ref="." class="depends-on inline-delete" id="depends-on-input">
                <xf:label>Depends On:</xf:label>
            </xf:input>
            <xf:trigger bind="delete-depends-on-trigger" class="inline-delete">
                <xf:label>Delete Depends On</xf:label>
                <xf:delete nodeset="instance('my-task')/depends-on[index('depends-on-repeat')]" ev:event="DOMActivate"/>
            </xf:trigger>
        </xf:repeat>
        <xf:trigger>
            <xf:label>Insert New "Depends On" Link</xf:label>
            <xf:action ev:event="DOMActivate">
                <xf:insert nodeset="instance('my-task')/depends-on" at="last()" position="after"/>
                <xf:setvalue ref="instance('my-task')/depends-on[index('depends-on-repeat')]" value=""/>
                <xf:setfocus control="depends-on-input"/>
            </xf:action>
        </xf:trigger>
                      
        <xf:repeat id="tag-repeat" nodeset="instance('my-task')/tag">
            <xf:input ref="." class="Tag inline-delete" id="tag-input">
                <xf:label>Tag (Keyword):</xf:label>
            </xf:input>
            <xf:trigger bind="delete-tag-trigger" class="inline-delete">
                <xf:label>Delete Tag (Keyword)</xf:label>
                <xf:delete nodeset="instance('my-task')/tag[index('tag-repeat')]" ev:event="DOMActivate"/>
            </xf:trigger>
        </xf:repeat>
        <xf:trigger>
            <xf:label>Append New Tag (Keyword)</xf:label>
            <xf:action ev:event="DOMActivate">
                <xf:insert nodeset="instance('my-task')/tag" at="last()" position="after"/>
                <xf:setvalue ref="instance('my-task')/tag[index('tag-repeat')]" value=""/>
                <xf:setfocus control="tag-input"/>
            </xf:action>
        </xf:trigger>
              
        <xf:repeat id="resource-repeat" nodeset="instance('my-task')/resource">
            <xf:input ref="." class="resource inline-delete" id="resource-input">
                <xf:label>Resource (URL):</xf:label>
            </xf:input>
            <xf:trigger bind="delete-resource-trigger" class="inline-delete">
                <xf:label>Delete Resource</xf:label>
                <xf:delete nodeset="instance('my-task')/resource[index('resource-repeat')]" ev:event="DOMActivate"/>
            </xf:trigger>
        </xf:repeat>
        <xf:trigger>
            <xf:label>Append New Resource (URL)</xf:label>
            <xf:action ev:event="DOMActivate">
                <xf:insert nodeset="instance('my-task')/resource" at="last()" position="after"/>
                <xf:setvalue ref="instance('my-task')/resource[index('resource-repeat')]" value=""/>
                <xf:setfocus control="resource-input"/>
            </xf:action>
        </xf:trigger>
              
        <br/>
        <xf:submit submission="save">
            <xf:label>Save</xf:label>
        </xf:submit>
       
    </body>
}</div>

return style:assemble-form($title, (), (), $model, $content, true())