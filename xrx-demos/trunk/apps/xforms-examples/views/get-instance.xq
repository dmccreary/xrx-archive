xquery version "1.0";
import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";
declare namespace xhtml ="http://www.w3.org/1999/xhtml";
(: Get Instance - returns the XML item for a given ID :)

let $id := request:get-parameter('id', '')

(: check for required parameters :)
return

if (not($id)) then 
    <error>
        <message>Parameter "id" is missing.  This argument is required for this web service.</message>
    </error>
else
    let $data-collection := $style:db-path-to-app-data
    let $db-path := substring-after($data-collection, 'xmldb:exist://')
    let $rest := concat('/rest', $db-path)
    let $file-path := concat($data-collection, '/', $id)
    let $item := doc($file-path)/xhtml:html
    return
    <xform>
       {$file-path}
       {$item}
    </xform>
