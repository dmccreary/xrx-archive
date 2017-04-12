xquery version "1.0";
import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";

let $id := request:get-parameter('id', '')

let $page-title := 'View Email Record'

(: check for required parameters :)
return

if (not($id))
    then (
    <error>
        <message>Parameter "id" is missing.  This argument is required for this web service.</message>
    </error>)
    else
      let $app-collection := $style:db-path-to-app
      let $data-collection := concat($app-collection, '/data')
      let $doc := collection($data-collection)//message[id/text()=$id]
return
if ($doc)
  then $doc
  else <error><message>No Item Found with id = {$id}</message></error>

