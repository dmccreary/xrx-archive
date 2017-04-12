xquery version "1.0";

import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";

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
      let $app-collection := $style:db-path-to-app
      let $data-collection := concat($app-collection, '/data')

     (: put in the appropriate file name :)
     let $file := if ($new)
        then ('new-instance.xml')
        else (concat($data-collection, '/', $id, '.xml'))
return
<html xmlns="http://www.w3.org/1999/xhtml" 
   xmlns:ev="http://www.w3.org/2001/xml-events" 
   xmlns:xs="http://www.w3.org/2001/XMLSchema" 
   xmlns:xf="http://www.w3.org/2002/xforms">
    <head>
        <title>XForms application generated from constraint schema.</title>
        <link type="text/css" rel="stylesheet" href="edit.css"/>
        {style:import-css()}
        <xf:model>
            <xf:instance xmlns="" id="save-data" src="{$file}"/>
            <xf:instance xmlns="" id="views">
                <data>
                    <Subscription-delete-trigger/>
                    <Notification-delete-trigger/>
                    <LogEntry-delete-trigger/>
                    <Subscription-add-trigger/>
                    <Notification-add-trigger/>
                    <LogEntry-add-trigger/>
                </data>
            </xf:instance>

            <xf:bind nodeset="instance('save-data')/Subscription/UserID" required="true()"/>
            <xf:bind nodeset="instance('save-data')/Subscription/SubscrtionEnabledIndicator" required="true()"/>
            <xf:bind nodeset="instance('save-data')/Subscription/SubscriptionName" required="true()"/>
            <xf:bind nodeset="instance('save-data')/Subscription/SubscriptionDescriptionText" required="true()"/>
            <xf:bind nodeset="instance('save-data')/Subscription/XPathExpression" required="true()"/>

            <xf:bind nodeset="instance('save-data')/Subscription/Notifications/Notification/NotificationTypeCode" required="true()"/>
            <xf:bind nodeset="instance('save-data')/Subscription/Notifications/Notification/CopyDestinationPath" required="true()"/>
            <xf:bind nodeset="instance('save-data')/Subscription/Logs/Log/EventDateTime" required="true()"/>
            <xf:bind nodeset="instance('save-data')/Subscription/Logs/Log/LogDocumentPath" required="true()"/>
            <xf:bind nodeset="instance('save-data')/Subscription/Logs/Log/LogRetentionPeriodDays" required="true()"/>

            <xf:bind nodeset="//SubscrtionEnabledIndicator" type="xs:boolean"/>

            <!-- binds for add/delete trigger visability -->
            <xf:bind id="Subscription-delete-trigger" nodeset="instance('views')/Subscription-delete-trigger" relevent="instance('save-data')/Subscription[2]"/>
            
            <xf:bind id="Notification-delete-trigger" nodeset="instance('views')/Notification-delete-trigger" 
            relevent="instance('save-data')/Subscription[index('Subscription-repeat')]/Notifications/Notification[2]"/>
            
            <xf:bind id="LogEntry-delete-trigger" nodeset="instance('views')/LogEntry-delete-trigger" 
            relevent="instance('save-data')/Subscription[index('Subscription-repeat')]/Logs/LogEntry[2]"/>
            

            <xf:submission id="save" method="post" action="save-new.xq" instance="save-data"/>
        </xf:model>
    </head>

    <body>
    {style:header()}
    {style:breadcrumb()} &gt; <a href="../views/list-items.xq">List all Subscriptions</a>
        <xf:group ref="/Subscription">
            <xf:label class="group-label">Subscription</xf:label>
            <div class="block-form">
                    <xf:output ref="id" class="id">
                        <xf:label>id: </xf:label>
                    </xf:output>

                    <xf:input ref="UserID" class="UserID">
                        <xf:label>UserID : </xf:label>
                    </xf:input>

                    <xf:input ref="SubscrtionEnabledIndicator" class="SubscrtionEnabledIndicator">
                        <xf:label>SubscrtionEnabledIndicator : </xf:label>
                    </xf:input>

                    <xf:input ref="SubscriptionName" class="SubscriptionName">
                        <xf:label>SubscriptionName : </xf:label>
                    </xf:input>

                    <xf:textarea ref="SubscriptionDescriptionText" class="SubscriptionDescriptionText">
                        <xf:label>SubscriptionDescriptionText : </xf:label>
                    </xf:textarea>

                    <xf:input ref="XPathExpression" class="XPathExpression">
                        <xf:label>XPathExpression : </xf:label>
                    </xf:input>

                    <xf:input ref="LogRetentionPeriodDays" class="LogRetentionPeriodDays">
                        <xf:label>LogRetentionPeriodDays : </xf:label>
                    </xf:input>

                     
                        <div class="repeat">
                            <xf:repeat nodeset="instance('save-data')/Subscription[index('Subscription-repeat')]/Notifications/Notification" id="Notification-repeat">
                                <xf:output ref="id">
                                    <xf:label>id : </xf:label>
                                </xf:output>
                                <xf:select1>
                                    <xf:label>NotificationTypeCode</xf:label>
                                    <xf:item>
                                       <xf:label>Email</xf:label>
                                        <xf:value>email</xf:value>
                                    </xf:item>
                                    <xf:item>
                                       <xf:label>Copy to Work Queue</xf:label>
                                        <xf:value>/user/dan/workqueue</xf:value>
                                    </xf:item>
                                </xf:select1>
                                <xf:input ref="CopyDestinationPath" class="CopyDestinationPath">
                                    <xf:label>CopyDestinationPath : </xf:label>
                                </xf:input>
                                <xf:trigger bind="Notification-delete-trigger">
                                    <xf:label>Delete</xf:label>
                                    <xf:delete nodeset="instance('save-data')/Subscription[index('Subscription-repeat')]/Notifications/Notification[index('Notification-repeat')]" ev:event="DOMActivate"/>
                                </xf:trigger>
                            </xf:repeat>
                            <xf:trigger>
                                <xf:label>Add Notification</xf:label>
                                <xf:action ev:event="DOMActivate">
                                    <xf:insert nodeset="instance('save-data')/Subscription[index('Subscription-repeat')]/Notifications/Notification" at="last()" position="after"/>
                                    <xf:setvalue ref="instance('save-data')/Subscription[index('Subscription-repeat')]/Notifications//Notification/id[last()]/id" 
                                    value="count(instance('save-data')/Subscription[index('Subscription-repeat')]/Notifications//Notification) + 1"/>

                                    <xf:setvalue ref="instance('save-data')/Subscription[index('Subscription-repeat')]/
                                    Notifications/NotificationTypeCode[index('NotificationTypeCode-repeat')]/NotificationTypeCode" value=""/>
                                    <xf:setvalue ref="instance('save-data')/Subscription[index('Subscription-repeat')]/
                                    Notifications/CopyDestinationPath[index('CopyDestinationPath-repeat')]/CopyDestinationPath" value=""/>

                                </xf:action>
                            </xf:trigger>
                        </div>


                        <div class="repeat">
                        <xf:label class="group-label">Logs</xf:label>
                            <xf:repeat nodeset="instance('save-data')/Subscription[index('Subscription-repeat')]/Logs/LogEntry" id="LogEntry-repeat">
                                <xf:input ref="EventDateTime" class="EventDateTime">
                                    <xf:label>EventDateTime : </xf:label>
                                </xf:input>
                                <xf:input ref="LogDocumentPath" class="LogDocumentPath">
                                    <xf:label>LogDocumentPath : </xf:label>
                                </xf:input>
                                <xf:trigger bind="LogEntry-delete-trigger">
                                    <xf:label>Delete</xf:label>
                                    <xf:delete nodeset="instance('save-data')/Subscription[index('Subscription-repeat')]/Logs/LogEntry[index('LogEntry-repeat')]" ev:event="DOMActivate"/>
                                </xf:trigger>
                            </xf:repeat>
                            <xf:trigger>
                                <xf:label>Add LogEntry</xf:label>
                                <xf:action ev:event="DOMActivate">

                                    <xf:insert nodeset="instance('save-data')/Subscription[index('Subscription-repeat')]/Logs/LogEntry" at="last()" position="after"/>
                                    <xf:setvalue ref="instance('save-data')/Subscription[index('Subscription-repeat')]/Logs/EventDateTime[index('EventDateTime-repeat')]/EventDateTime" value=""/>
                                    <xf:setvalue ref="instance('save-data')/Subscription[index('Subscription-repeat')]/Logs/LogDocumentPath[index('LogDocumentPath-repeat')]/LogDocumentPath" value=""/><!-- this puts the cursor in the first field of the new row we just added -->
                                    <xf:setfocus control="EventDateTime-id"/>
                                </xf:action>
                            </xf:trigger>
                        </div>


                    <xf:trigger bind="Subscription-delete-trigger">
                        <xf:label>Delete Subscription</xf:label>
                        <xf:delete nodeset="instance('save-data')/Subscription[index('Subscription-repeat')]" ev:event="DOMActivate"/>
                    </xf:trigger>
                     </div>
                </xf:repeat>
                <xf:trigger>

                    <xf:label>Add Subscription</xf:label>
                    <xf:action ev:event="DOMActivate">
                        <xf:insert nodeset="instance('save-data')/Subscription" at="last()" position="after"/>
                        <!-- we should have a copy from origin and use a template instance here -->
                        <xf:setvalue ref="instance('save-data')/Subscription[last()]/id" value="count(instance('save-data')/Subscription)"/>
                        <xf:setvalue ref="instance('save-data')/Subscription[last()]/UserID" value=""/>
                        <xf:setvalue ref="instance('save-data')/Subscription[last()]/SubscrtionEnabledIndicator" value=""/>
                        <xf:setvalue ref="instance('save-data')/Subscription[last()]/SubscriptionName" value=""/>
                        <xf:setvalue ref="instance('save-data')/Subscription[last()]/SubscriptionDescriptionText" value=""/>
                    </xf:action>
                </xf:trigger>
            </div>
        </xf:group>

        <xf:submit submission="save">
            <xf:label>Save</xf:label>
        </xf:submit>


    </body>
</html>
