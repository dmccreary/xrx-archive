xquery version "1.0";

(: app landing page :)

import module namespace style = "http://danmccreary.com/style" at "../../modules/style.xqm";

let $title := 'Authorization App'

let $content := 
    <div>
        Welcome to the {style:app-name()} application.
        
        This application stores the authorization module and the unit tests.
        
        <a href="unit-tests/index.xq">Authorization Unit Tests</a>
    </div>
     
return
    style:assemble-page($title, $content)