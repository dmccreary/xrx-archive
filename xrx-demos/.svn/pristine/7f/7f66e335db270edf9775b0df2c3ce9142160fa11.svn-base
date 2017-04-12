xquery version "1.0";
import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";

(: Catch an XML POST file and store it in the data collection 

Incomming post file must be in the following formats:

A batch of message files:
<messages>
  <message>
  ....
  </message>
</messages>

or a single message
<message>
  ....
  </message>

:)

 
 (: TODO - validate the incomming file against an XML Schema :)
 let $app := $style:db-path-to-app
 let $data-collection := concat($app, '/data')
 let $log-file-path := concat($app, 'log-files/incomming-log.xml')
 
(: catch web content for publishing :)

(: get data from an HTTP post :)
let $incoming-document := request:get-data()

(: The user that will execute the login before the store :)
let $user := 'admin'
(: The password that will execute the login  :)
let $pass := 'admin123'
let $login := xmldb:login($data-collection, 'admin', 'admin123')

(: Create a new document ID :)
let $next-id-file-path := concat($app,'/catch/next-id.xml')
let $doc-id := doc($next-id-file-path)/data/next-id/text() 
let $file-name := concat($doc-id, '.xml')
let $file-path := concat($data-collection, '/', $file-name)

let $store-result := xmldb:store($data-collection, $file-name, $incoming-document)
(: this adds the correct ID to the new document we just saved :)
let $doc-update-id :=
if (doc($file-path)//id)
   then update replace doc($file-path)/*/id with <id>{$doc-id}</id>
   else update insert <id>{$doc-id}</id> preceding doc($file-path)/*[1]/*[1]

(: this updates the id in the next-id.xml file :)
let $next-id-file-path := concat($app, '/catch/next-id.xml')
let $old-doc-id := doc($next-id-file-path)/data/next-id/text()
let $new-next-id :=  update replace doc($next-id-file-path)/data/next-id/text() with ($old-doc-id + 1)

let $db-path := substring-after($file-path, 'xmldb:exist://')

(: automatic categorization :)
let $code-table-collection := concat($app, '/code-tables')
let $code-file := 'message-classification-codes.xml'
let $code-table-path := concat($code-table-collection, '/', $code-file)
let $categories := doc($code-table-path)//value/text()

let $categorize :=
    for $category in $categories
    return
      if ( contains(doc($file-path)/*/subject/text(), $category) )
         then
            (update insert
            <categories><category>{$category}</category></categories> 
            following doc($file-path)/*/subject,
            $category)
         else ()
let $updated-doc-id := string($old-doc-id - 1)
let $content :=
<div class="content">
     Incoming mail document {$updated-doc-id} has been stored at:
     
     <br/> <a href="../data/{$file-name}">{$db-path}</a>
     <br/> at {current-dateTime()}.
     <br/>
     The following automatic categorization has been assigned:
   
       {for $category in doc($file-path)//category
          return string-join($category, ', ')
       }
   </div>


return style:assemble-page('Catch Results', $content)

