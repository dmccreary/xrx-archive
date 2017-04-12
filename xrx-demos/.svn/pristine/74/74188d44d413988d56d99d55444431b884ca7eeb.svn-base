xquery version "1.0";

(: List the Roles for each Application :)

import module namespace style = "http://style.exist-db.org/reference-manual" at "../../../modules/style.xqm";

declare namespace xrx="http://code.google.com/p/xrx";

let $app-data-collection := concat($style:db-path-to-site, 'apps')
let $role-data-collection := $style:db-path-to-app-data

let $apps := for $item in collection($app-data-collection)/xrx:app-info return $item
let $roles := for $role in collection($role-data-collection)/security-role order by $role/name/text() return $role
let $apps-count := count($apps)
let $role-count := count($roles)

let $content := 
    <div class="content">
        
    App Base Collection: {$app-data-collection} Count={ $apps-count }<br/>
    Role Base Collection: {$role-data-collection} Count={ $role-count }<br/>
    <table class="span-24">
        <thead>
            <tr>
               <th class="span-2">Application</th>
               <th class="span-2">Action</th>
               <th class="span-20" colspan="{$role-count}">Apps</th>
            </tr>
             <tr>
               <th class="span-2"/>
               <th class="span-2"/>
               {for $role in $roles
                   return
                       <th>{$role/label/text()}</th>
                }
            </tr>
        </thead>
        <tbody>{
            for $app in $apps
            let $id := $app/xrx:app-id/text()
            return
            (<tr>
                <td>{$app/xrx:app-name/text()}</td>
                
                
            </tr>,
            for $action in $app/xrx:actions/xrx:action
                   return
                   <tr>
                      <td/>
                      <td colspan="3">{$action/text()}</td>
                      {for $role in $roles
                   return
                       <td><input type="checkbox"/></td>
                }
                   </tr>
            
            )
        }</tbody>
    </table>
    
        
    </div>

return 
    style:assemble-page($content)
