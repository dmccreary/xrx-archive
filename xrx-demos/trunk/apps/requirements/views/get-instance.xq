xquery version "1.0";
import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";
import module namespace req='http://www.mnhs.org/requirements' at '../modules/requirements.xqm';

let $id := request:get-parameter('id', '')

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
          let $file := concat($data-collection, '/', $id, '.xml')
          let $dp-path := concat('/exist/rest', substring-after($file, 'xmldb:exist://'))
          let $item := doc($file)/Requirement[id = $id]

return $item
