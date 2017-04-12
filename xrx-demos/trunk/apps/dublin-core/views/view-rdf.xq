xquery version "1.0";
import module namespace style='http://www.mnhs.org/style' at '/db/cust/mhs/modules/style.xqm';
declare option exist:serialize "method=xhtml media-type=text/html indent=yes";

let $title := 'Zetero Demo Using RDF Metadata Tags'

let $id := request:get-parameter('id', '')

(: check for required parameters :)
return

if (not($id))
    then (
    <error>
        <message>Parameter "id" is missing.  This argument is required for this web service.</message>
    </error>)
    else
      let $app-collection := style:app-base-uri()
      let $data-collection := concat($app-collection, '/data')
      let $item := collection($data-collection)/item[id = $id]
return
<html>
   <head profile="http://purl.org/NET/erdf/profile">
      <title>{$item/title/text()}</title>
      <link rel="schema.dc" href="http://purl.org/dc/elements/1.1/" />
      <meta name="dc.title" content="{$item/title/text()}"/>
      <meta name="dc.creator" content="{$item/creator/text()}"/>
      <meta name="dc.subject" content="{$item/subject/text()}"/>
      <meta name="dc.description" content="{$item/description/text()}"/>
      <meta name="dc.publisher" content="{$item/publisher/text()}"/>
      
      <meta name="dc.contributor" content="{$item/contributor/text()}"/>
      <meta name="dc.date" content="{$item/date/text()}"/>
      <meta name="dc.type" content="{$item/type/text()}"/>
      <meta name="dc.format" content="{$item/format/text()}"/>
      <meta name="dc.identifier" content="{$item/identifier/text()}"/>
      
      <meta name="dc.source" content="{$item/source/text()}"/>
      <meta name="dc.language" content="{$item/language/text()}"/>
      <meta name="dc.contributr" content="{$item/contributr/text()}"/>
      <meta name="dc.coverage" content="{$item/coverage/text()}"/>
      <meta name="dc.rights" content="{$item/rights/text()}"/>

      {style:import-css()}
   </head>
   <body>
      <div id="container">
        {style:header()}
            {style:breadcrumb()}
      
       <h2>{$title}</h2>
         <table>
            <tbody>        
             <tr><th class="field-label">Title:</th><td>{$item/title/text()}</td></tr>
             <tr><th class="field-label">Creator:</th><td>{$item/creator/text()}</td></tr>
             <tr><th class="field-label">Subject:</th><td>{$item/subject/text()}</td></tr>
             <tr><th class="field-label">Description:</th><td>{$item/description/text()}</td></tr>
             <tr><th class="field-label">Publisher:</th><td>{$item/publisher/text()}</td></tr>
             
             <tr><th class="field-label">Contributor:</th><td>{$item/contributor/text()}</td></tr>
             <tr><th class="field-label">Date:</th><td>{$item/date/text()}</td></tr>
             <tr><th class="field-label">Type:</th><td>{$item/type/text()}</td></tr>
             <tr><th class="field-label">Format:</th><td>{$item/format/text()}</td></tr>
             <tr><th class="field-label">Identifier:</th><td>{$item/identifier/text()}</td></tr>
             
             <tr><th class="field-label">Source:</th><td>{$item/source/text()}</td></tr>
             <tr><th class="field-label">Language:</th><td>{$item/language/text()}</td></tr>
             <tr><th class="field-label">Relation:</th><td>{$item/relation/text()}</td></tr>
             <tr><th class="field-label">Coverage:</th><td>{$item/coverage/text()}</td></tr>
             <tr><th class="field-label">Rights:</th><td>{$item/rights/text()}</td></tr>
             </tbody>
          </table>
   
            <a href="../edit/edit.xq?id={$id}">Edit Item</a>
             
            <a href="../edit/delete-confirm.xq?id={$id}">Delete Item</a>

         {style:footer()}
         </div>
   </body>
</html>