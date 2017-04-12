xquery version "1.0";
import module namespace style = "http://danmccreary.com/style" at "../../modules/style.xqm";
import module namespace util2 = "http://danmccreary.com/util2" at "../../modules/util2.xqm";

let $title := 'User Manager'

let $content :=
<div class="content">
<p>Welcome to the User Manager application.  This Application manages all users and their roles.</p>
       
     <a href="views/list-items.xq">List</a> List of All Users
     <br/>
   
     <a href="edit/edit.xq?new=true">New</a> Create a New User
     <br/>
     
     <a href="search/search-contains-form.xq">Search</a> Search Users 
     <br/>
     
     <a href="views/metrics.xq">Metrics</a> Count of Users and Roles
     <br/>
     
     <a href="unit-tests/index.xq">Unit Tests</a> List of Unit Tests
     <br/>
     <br/>
     
     {if (util2:is-dba())
        then
          <div class="admin-only">
             <a href="admin/index.xq">Admin</a> Application Administrator Functions
          </div>
        else ()
      }
</div>

return 
    style:assemble-page($title, $content)