xquery version "1.0";
import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";
declare namespace html = "http://www.w3.org/1999/xhtml";

declare function local:name-value-to-label($value as xs:string*) as xs:string {
   let $lookup-table-path := concat($style:db-path-to-app, '/code-tables/element-attribute-names.xml')
   let $items := doc($lookup-table-path)//item
   let $label := xs:string($items[value=$value]/label/text())
   return
     if ($label) then $label else $value
};


let $style :=
<style type="text/css"><![CDATA[
  table {border: solid black 1px;}
]]></style>

let $id := request:get-parameter('id', '')

let $title := 'View E-Mail Message'

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
      let $message := collection($data-collection)//message[$id=id]
return

let $content := 
<div class="content">
   <table>
      <thead>
         <tr>
            <th class="span-2">Element</th>
            <th>Value</th>
         </tr>
      </thead>
      <tbody>
         {for $header-element in $message/headers/*
         return
            <tr>
               <th>{local:name-value-to-label(name($header-element))}:</th>
               <td>{$header-element/text()}
               {string-join(
                    for $sub-element in $header-element/*
                       return
                         ($sub-element/text())
                     , ' ')
               }</td>
            </tr>
         }
        
      </tbody>
   </table>

  
   
   <h3>Message Body</h3>
   {$message/body/text/text()}
   <br/>
   {style:edit-controls($id, 'ex')}
</div>
   
return style:assemble-page($title, $content)