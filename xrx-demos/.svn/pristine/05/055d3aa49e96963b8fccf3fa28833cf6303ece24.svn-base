xquery version "1.0";

module namespace auth = "http://danmccreary.com/authorization";

(:
import module namespace auth = "http://danmccreary.com/authorization";
:)

(: 

user files must have the following structure:
<user>
    <id>9</id>
    ...
    <roles>
        <role>admin</role>
        <role>developer</role>
    </roles>
</user>

application files must have the following structure:

<app-info xmlns="http://code.google.com/p/xrx">
.....
   <permissions>
        <!-- by default, admin will have all permissions -->
        <permission>
            <role>developer</role>
            <action>edit</action>
        </permission>
        <permission>
            <role>user-admin</role>
            <action>edit</action>
        </permission>
        <permission>
            <role>editor</role>
            <action>view</action>
        </permission>
    </permissions>
</app-info>

This module will then test to see if a user has any read write access for ANY of their roles...

:)

declare namespace xrx="http://code.google.com/p/xrx";

(: this is hardcoded to allow this to be used without any URL rewriting enabled :)
declare variable $auth:site := '/db/dma';

(: this is where site-wide security-policy is stored :)
declare variable $auth:site-info := concat($auth:site, '/site-info.xml');

(: this is our security element within the site-info file.  Note that this is in the XRX namespace. :)
declare variable $auth:security := doc($auth:site-info)//xrx:security;

(: note this module can ONLY be used within an app context :)
declare variable $auth:db-path-to-app  := concat($auth:site, '/apps/', substring-before(substring-after(request:get-uri(), '/apps/'), '/'));
declare variable $auth:app-info  := doc(concat($auth:db-path-to-app, '/app-info.xml'))/xrx:app-info;
declare variable $auth:app-permissions  := $auth:app-info//xrx:permission;

(: returns a sequence of user nodes :)
declare variable $auth:users as node()* {
    let $user-collection := concat($auth:site, '/apps/user-manager/data')
    return
        collection($user-collection)/user
};

(: returns true() if the user guest (an unauthenticated user) should have ANY read access to the site. If false
then all URLs should redirect to the login page.  :)
declare function auth:guest-access-indicator() as xs:boolean {
    let $d := $auth:security/xrx:permit-guest-access/text()
    let $log := util:log-app("DEBUG", "authorization", concat("permit-guest-access ", $d))
    return
        if ($d = 'true')
        then true()
        else false()
};

declare function auth:force-ssl-indicator() as xs:boolean {
    let $d := $auth:security/xrx:force-ssl/text()
    let $log := util:log-app("DEBUG", "authorization", concat("force-ssl ", $d))
    return
        if ($d = 'true')
        then true()
        else false()
};

(: This function returns sequence of strings that contains all the roles 
for a specific user using the user-id (not the username) :)
declare function auth:get-roles-for-user($user-id as xs:string) as xs:string* {
    $auth:users[user-id = $user-id]//role/text()
};

(: This function gets the correct user id, whether the user is openid or native :)
declare function auth:get-current-user() as xs:string {
    if (xmldb:get-current-user-attribute('id') ne '') then 
        xmldb:get-current-user-attribute('id')
    (: native users' user-ids are captured with xmldb:get-current-user() :)
    else if (xmldb:get-current-user() ne '') then 
        xmldb:get-current-user()
    (: default to guest :)
    else 
        'guest'
};

(: This function returns true if the user has any of the roles 
   listed in the app-info.xml file for this application 
   For example:
        auth:get-roles-for-user(xmldb:get-current-user-attribute('id')) 
        auth:get-roles-for-user('dan') 
:)
declare function auth:user-has-role($app-roles as xs:string*) as xs:boolean {
    let $current-user-id := auth:get-current-user()
    
    let $user-roles := auth:get-roles-for-user($current-user-id)
    
    (: The cms-admin is automatically added to the list of application roles :)
    
    return
       if ( $user-roles = ($app-roles, 'cms-admin')  )
          then true()
          else false()
};

(: this function must return true() if the user has release rights to this document 
Sample Usage:

{ if (auth:has-release-rights(xmldb:get-current-user()))
    then
    <a href="link-to-release-function.xq" class="release">release to Public Web Site</a>
    else ()
}

:)
declare function auth:has-release-rights($user as xs:string) as xs:boolean {
   if ( $auth:users[user-id/text() eq $user][roles/role/text() eq 'releaser'] )
      then true()
      else false()
};

(: TODO: THIS IS THE OLD API - MUST REMOVE AFTER NEW API IS WORKING :)
declare function auth:has-publish-rights($user as xs:string) as xs:boolean {
   if ( $auth:users[user-id/text() eq $user][roles/role/text() eq 'publish'] )
      then true()
      else false()
};

(: this function must return true() if this user has edit rights to this app-id :)
declare function auth:has-edit-rights($user as xs:string) as xs:boolean {
   if ( $auth:users[user-id/text() eq $user][roles/role/text() eq 'editor'] )
      then true()
      else false()
};

(: this function must return true() if this user has developer rights to this app-id :)
declare function auth:has-admin-rights($user as xs:string) as xs:boolean {
   if ( $auth:users[user-id/text() eq $user][roles/role/text() eq 'developer'] )
      then true()
      else false()
};

(: this function must return true() if this user has developer rights to this app-id :)
declare function auth:has-developer-rights($user as xs:string) as xs:boolean {
   if ( $auth:users[user-id/text() eq $user][roles/role/text() eq 'developer'] )
      then true()
      else false()
};

(: this function must return true() if this user has developer rights to this app-id :)
declare function auth:has-admin-or-developer-rights($user as xs:string) as xs:boolean {
   if ( $auth:users[user-id/text() eq $user][roles/role/text() eq 'cms-admin' or roles/role/text() eq 'developer'] )
      then true()
      else false()
};

(: role-has-action
   For each application, a role may have zero to many actions such as 'create', 'edit' or 'release'.
   This function returns true if this role has a given action.
   For example to test if the role=developer has action=edit you would write
       role-has-action('developer', 'edit')
       
       which would return true
       
       This functions uses the app-info.xml file in the application to get this information.
       
       Here is the sample structure:
       
       <permissions>
        <!-- by default, admin will have all permissions -->
        <permission>
            <role>developer</role>
            <action>edit</action>
            <action>release</action>
        </permission>
    </permissions>
:)
declare function auth:role-has-action($role as xs:string, $action as xs:string) as xs:boolean {
if ( $auth:app-permissions[./xrx:role/text() = $role]/xrx:action/text() = $action )
  then true()
  else false()
};



(: returns true if the GIVEN user has this action for ANY of the users action :)
declare function auth:user-has-action($user as xs:string, $action as xs:string) as xs:boolean {
if ($user = 'cms-admin')
  then
     true()
   else
     let $roles-for-current-user := auth:get-roles-for-user($user)
     return
     some $role in $roles-for-current-user
       satisfies auth:role-has-action($role, $action)
};


(: returns true if the CURRENT has this action for ANY of the users roles :)
declare function auth:current-user-has-action($action as xs:string) as xs:boolean {
  auth:user-has-action(auth:get-current-user(), $action)
};



