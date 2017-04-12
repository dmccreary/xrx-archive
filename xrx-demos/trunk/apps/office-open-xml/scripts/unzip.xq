xquery version "1.0";

import module namespace style='http://danmccreary.com/style' at '../../../modules/style.xqm';
import module namespace oox='http://exist-db.org/xquery/office-open-xml' at '../modules/office-open-xml.xqm';
import module namespace compression = "http://exist-db.org/xquery/compression";
import module namespace xmldb = "http://exist-db.org/xquery/xmldb";

let $app-collection := $style:db-path-to-app
let $input-collection := concat($app-collection, '/input-zips')
let $id := request:get-parameter('id', '')
let $action := request:get-parameter('action', 'list') (: valid actions: 'list', 'unzip' :)

return
   <results-of-unzip>
      <inputs>
         <input-file-name>{$id}</input-file-name>
         <action>{$action}</action>
      </inputs>
      <output>
         
         {oox:unzip($oox:input-collection, $id, $action)}
      </output>
   </results-of-unzip>