xquery version "1.0";

let $post-data := request:get-data()

let $xml-wrapper :=
<root>
  {for $name in request:get-header-names()
     return
        <header>
            <name>{$name}</name>
            <value>{request:get-header($name)}</value>
        </header>
  }
</root>

let $login := xmldb:login('/db/tmp', 'admin', 'admin123')
let $store := xmldb:store('/db/tmp', 'headers.xml', $xml-wrapper)
let $store2 := xmldb:store('/db/tmp', 'test-img.svg', $post-data, 'image/svg+xml')
let $store3 := xmldb:store('/db/tmp', 'base64dump.txt', $post-data, 'text/plain')

return
<result>
  <ok/>
</result>