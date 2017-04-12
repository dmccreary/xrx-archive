import module namespace auth = "http://danmccreary.com/authorization" at "../modules/authorization.xqm";

let $users := $auth:users

return
<testcase>
   {$auth:users}
</testcase>
