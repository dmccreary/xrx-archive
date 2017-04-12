xquery version "1.0";
import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";
declare namespace xf="http://www.w3.org/2002/xforms";
declare namespace ev="http://www.w3.org/2001/xml-events";
declare namespace xhtml="http://www.w3.org/1999/xhtml";

let $space := ' '
let $system-id := request:get-parameter('system-id', '')
let $my-file := concat('/db/dma/apps/data-stores/data/',$system-id ,'-Attributes.xml')
let $my-doc := doc($my-file)
let $start := xs:integer(request:get-parameter('start', '0'))
let $records := xs:integer(request:get-parameter('records', '50'))
let $max := count($my-doc/root/row)
let $query-base := 'datastore-browse.xq'
return
<html>
    <head>
        <title>{$system-id} Database Columns</title>
    </head>
    <body>
        <h1>{$system-id} Database Columns</h1>
       <p>Attributes {$start} to {$start + $records -1} of {$max}</p>
      <input type="button"
       onClick="parent.location='{$query-base}?system-id={$system-id}&amp;start={$start - $records}&amp;records={$records}'" value="&lt; Previous  {$records}"/>
       <input type="button"
       onClick="parent.location='{$query-base}?system-id={$system-id}&amp;start={$start + $records}&amp;records={$records}' " value="Next {$records} >"/>
        <table border="1">
            <thead>
              <tr>
                  <th>AttributeName</th> 
                  <th>Definition</th>
                  <th>Entity</th>
              </tr>
         </thead>
         <tbody>{
         for $my-attribute at $count in subsequence($my-doc/root/row, $start, $records)
            let $attribute-name := $my-attribute/Column_Name/text()
            let $entity-name := $my-attribute/Entity_Name/text()
         return
       <tr> {if ($count mod 2) then (attribute {'bgcolor'} {'Lavender'}) else ()}
          <td><a href="datastore-view-attribute.xq?system-id={$system-id}&amp;entity-name={$entity-name}&amp;attribute-name={$attribute-name}">{$attribute-name}</a></td>
          <td>{$my-attribute/Definition/text()}</td>
          <td><a href="datastore-view-entity.xq?system-id={$system-id}&amp;entity-name={$entity-name}">{$entity-name }</a></td>
        </tr>
           }</tbody>
         </table>
     <input type="button"
       onClick="parent.location='{$query-base}?system-id={$system-id}&amp;start={$start - $records}&amp;records={$records}'" value="&lt; Previous  {$records}"/>
       <input type="button"
       onClick="parent.location='{$query-base}?system-id={$system-id}&amp;start={$start + $records}&amp;records={$records}' " value="Next {$records} >"/>
      </body>
</html>
