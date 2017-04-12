xquery version "1.0";
import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";

declare namespace xf="http://www.w3.org/2002/xforms";
declare namespace ev="http://www.w3.org/2001/xml-events";
declare namespace xhtml="http://www.w3.org/1999/xhtml";

(: XQuery to construct an XForm for either a new item or update item :)


let $new := request:get-parameter('new', '')
let $id := request:get-parameter('id', '')
let $title := 'Subscription Editor'

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
        else  concat('get-instance.xq?id=', $id)

let $style :=
<xhtml:style language="text/css">
    <![CDATA[
        @namespace xf url("http://www.w3.org/2002/xforms");
        .block-form xf|label {
            width: 25ex;
        }
        
        /* make sure the select and select1 items don't float to the left */
        xf|select xf|item, xf|select1 xf|item {
            margin-left: 16ex;
        }

        .uri .xforms-value {width: 90ex;}
        .SubscriptionDescriptionText textarea {
            height: 10ex;
            width:700px;
        }
        .note textarea {
            height: 10ex;
            width:630px;
        }
    ]]>
 </xhtml:style>

let $model :=
        <xf:model>
            <xf:instance xmlns="" id="save-data" src="{$file}"/>
            <xf:instance xmlns="" id="views">
                <data>
                    <Notification-delete-trigger/>
                    <Notification-add-trigger/>
                </data>
            </xf:instance>

            <xf:bind nodeset="instance('save-data')/UserID" required="true()"/>
            <xf:bind nodeset="instance('save-data')/SubscriptionName" required="true()"/>
            <xf:bind nodeset="instance('save-data')/XPathExpression" required="true()"/>
            <xf:bind nodeset="instance('save-data')/Notifications/Notification/NotificationTypeCode" required="true()"/>
            <xf:bind nodeset="instance('save-data')/Notifications/Notification/CopyDestinationPath" required="true()"/>
            <xf:bind nodeset="instance('save-data')/SubscrtionEnabledIndicator" type="xs:boolean"/>

            <!-- binds for add/delete trigger visability -->
         
            <xf:bind id="Notification-delete-trigger" nodeset="instance('views')/Notification-delete-trigger" 
            relevent="instance('save-data')/Notifications/Notification[2]"/>
                
            <xf:submission id="save" method="post" 
    action="{if ($new='true') then ('save-new.xq') else ('update.xq')}" instance="save-data" replace="all"/>
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
     
       <xf:input ref="UserID" class="UserID">
            <xf:label>UserID : </xf:label>
        </xf:input>
       
        <xf:input ref="SubscrtionEnabledIndicator" class="SubscrtionEnabledIndicator">
            <xf:label>Subscription Enabled: </xf:label>
        </xf:input>
       
        <xf:input ref="SubscriptionName" class="SubscriptionName">
            <xf:label>Subscription Name: </xf:label>
        </xf:input>

        <xf:textarea ref="SubscriptionDescriptionText" class="SubscriptionDescriptionText">
            <xf:label>Subscription Description: </xf:label>
        </xf:textarea>

        <xf:input ref="XPathExpression" class="XPathExpression">
            <xf:label>XPathExpression: </xf:label>
        </xf:input>

        <xf:input ref="LogRetentionPeriodDays" class="LogRetentionPeriodDays">
            <xf:label>Log Retention Period: </xf:label>
        </xf:input>
        </div>
                     
        <div class="repeat">
           <xf:label class="group-label">Notifications:</xf:label>
            <xf:repeat nodeset="instance('save-data')/Notifications/Notification" id="Notification-repeat">
                <xf:output ref="id">
                    <xf:label>id: </xf:label>
                </xf:output>
                <br/>
                <xf:select1 ref="NotificationTypeCode">
                    <xf:label>Notification Type Code: </xf:label>
                    <xf:item>
                       <xf:label>Email</xf:label>
                        <xf:value>email</xf:value>
                    </xf:item>
                    <xf:item>
                       <xf:label>Copy to Work Queue</xf:label>
                        <xf:value>/user/dan/workqueue</xf:value>
                    </xf:item>
                </xf:select1>
                <br/>
                <xf:input ref="CopyDestinationPath" class="CopyDestinationPath">
                    <xf:label>Copy Destination Path: </xf:label>
                </xf:input>
                <xf:trigger bind="Notification-delete-trigger">
                    <xf:label>Delete</xf:label>
                    <xf:delete nodeset="instance('save-data')/Notifications/Notification[index('Notification-repeat')]" ev:event="DOMActivate"/>
                </xf:trigger>
            </xf:repeat>
            <xf:trigger>
                <xf:label>Add Notification</xf:label>
                <xf:action ev:event="DOMActivate">
                    <xf:insert nodeset="instance('save-data')/Notifications/Notification" at="last()" position="after"/>
 <!--                   <xf:setvalue ref="instance('save-data')/Notifications//Notification/id[last()]/id" 
                    value="count(instance('save-data')/Notifications//Notification) + 1"/>

                    <xf:setvalue ref="instance('save-data')/
                    Notifications/NotificationTypeCode[index('NotificationTypeCode-repeat')]/NotificationTypeCode" value=""/>
                    <xf:setvalue ref="instance('save-data')/
                    Notifications/CopyDestinationPath[index('CopyDestinationPath-repeat')]/CopyDestinationPath" value=""/>
                    -->
                </xf:action>
            </xf:trigger>

      </div>

       <xf:submit submission="save">
            <xf:label>Save</xf:label>
        </xf:submit>

</div>

return style:assemble-form($title, (), $style, $model, $content, true())
