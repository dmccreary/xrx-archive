xquery version "1.0";
import module namespace style = "http://xmlopenfoundation.org/style" at "../../../modules/style.xqm";
declare default element namespace "http://www.tei-c.org/ns/1.0";
declare option exist:serialize "method=xhtml media-type=text/html indent=yes";

let $id := request:get-parameter('id', '')

let $data-collection := '/db/org/northwestern/apps/tei/data/shakespeare/'
let $view-speakers := request:get-parameter('view-speakers', 'false')
(: let $play := collection($file-path)/TEI[@xml:id=$id] :)
let $id-suffix := substring-after($id, 'sha-')
let $file-path := concat($data-collection, $id-suffix, '.xml')
let $play := doc($file-path)
let $title := $play//teiHeader/fileDesc/titleStmt/title/text()

(: this says get all the speaker element, at any depth in the file :)
let $castList := $play//castList

return
let $content :=
<div class="content">
   <style type="text/css">
   .castGroupLabel {{
      font-weight: bold;
      color: blue;
      font-size: 1.5em;
   }}
   </style>
       <h2>Cast List Report</h2>
       <p>Cast List in play <b>{$title}</b></p>
       <div>
       {
       (: note that cast items and cast groups are both at this level :)
       for $item in $castList/castItem|$castList/castGroup
       return
           if (name($item)='castItem')
              then
                 <div>{$item/role/text()} - ({string($item/role/@xml:id)})</div>
              else
               <div class="castGroup">
               <div class="castGroupLabel">{$item/head/text()}</div>
               <ul>{
                 for $role in $item//role
                    return
                      <li>{$role/text()} - ({string($role/@xml:id)})</li>
              }</ul>
              </div>
      }
      </div>
    </div>

return 
    style:assemble-page($content)
