import module namespace auth = "http://danmccreary.com/authorization" at "../modules/authorization.xqm";

let $users := $auth:users

return
<testcase>
   <site>{$auth:site}</site>
   <site-info-path>{$auth:site-info}</site-info-path>
   <db-path-to-app>{$auth:db-path-to-app}</db-path-to-app>
   <app-info>{$auth:app-info}</app-info>
   <app-perms>{$auth:app-permissions}</app-perms>
</testcase>
