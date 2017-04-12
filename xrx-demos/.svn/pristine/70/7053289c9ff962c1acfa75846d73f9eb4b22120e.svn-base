xquery version "1.0";
import module namespace style = "http://xmlopenfoundation.org/style" at "../../../modules/style.xqm";
import module namespace sandbox = "http://syntactica.com/apps/sandbox" at "../modules/interface-module.xqm";

declare option exist:serialize "media-type=text/xml omit-xml-declaration=yes";
let $id := request:get-parameter("id", '1')

return sandbox:get-select($id)
