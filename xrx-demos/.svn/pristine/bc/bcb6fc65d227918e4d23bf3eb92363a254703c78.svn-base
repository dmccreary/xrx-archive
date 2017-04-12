xquery version "1.0";
import module namespace style = "http://style.syntactica.com" at "/db/syntactica/modules/style.xqm";
declare option exist:serialize "method=xhtml media-type=text/html indent=yes";
 
declare function local:get-category-label($id as xs:integer) as xs:string {
    string(
    doc(concat(style:app-uri(), '/code-tables/faq-category-codes.xml'))/code-table/items/item[value=$id]/label/text()
    )
};
 
let $data-collection := style:app-data-uri()
let $title := 'FAQ Publish Status Report'

return
<html>
   <head>
      <title>{$title}</title>
      {style:import-css()}
   </head>
   <body>
    <div id="main">
        {style:header()}
            <div id="content">

      {style:breadcrumb()}

      <h1>{$title}</h1>
       <table>
           <thead>
           <tr>
              <th>Question</th>
              <th>Status</th>
              <th>Author</th>
              <th>Approver</th>
              <th>Date</th>
           </tr>
        </thead>
        <tbody>{
          for $item in collection($data-collection)/faq
             let $id := $item/id/text()
          return
             <tr>
                <td >{$item/question/text()}</td>            
                 <td align="center">{$item/status/text()}</td>
                 <td  align="center">{$item/author/text()}</td>
                 <td  align="center">{$item/approver/text()}</td>
                 <td  align="center">{$item/approval-date/text()}</td>
             </tr> 
       }</tbody></table>
       
</div>
         {style:footer()}
         </div>
   </body>
</html>