xquery version "1.0";

(: should be util:base64deocde() on eXist 1.5 xs:base64Binary 
let $file :=  response:stream-binary($data, 'image/png', '/db/test1.png')
:)

let $post-data := request:get-data()

let $base64binary := xs:base64Binary(util:binary-to-string($post-data))

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
let $store2 := xmldb:store('/db/tmp', 'test-img.png', $base64binary, 'image/png')
let $store3 := xmldb:store('/db/tmp', 'base64dump.txt', $post-data, 'text/plain')

return
<result>
  <ok/>
</result>