xquery version "1.0";
import module namespace style='http://danmccreary.com/style' at '../../../modules/style.xqm';
declare option exist:serialize "method=xhtml media-type=text/html indent=yes";

let $title := 'Zetero Demo Using HTML4 Metadata Tags'

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
      let $item := collection($data-collection)/item[id = $id]
return
<html>
   <head>
      <title>{$item/title/text()}</title>
      <link rel="stylesheet" href="/rest/db/dma/resources/css/blueprint/screen.css" type="text/css" media="screen, projection" />
        <link rel="stylesheet" href="/rest/db/dma/resources/css/blueprint/print.css" type="text/css" media="print" /><!--[if IE ]><link rel="stylesheet" href="{$style:site-css}/blueprint/ie.css" type="text/css" media="screen, projection" /><![endif]-->
        <link rel="stylesheet" href="/rest/db/dma/resources/css/style.css" type="text/css" media="screen, projection" />

      <meta name="DC.Title" content="{$item/title/text()}"/>
      <meta name="DC.Creator" content="{$item/creator/text()}"/>
      <meta name="DC.Subject" content="{$item/subject/text()}"/>
      <meta name="DC.Description" content="{$item/description/text()}"/>
      <meta name="DC.Publisher" content="{$item/publisher/text()}"/>
      
      <meta name="DC.Contributor" content="{$item/contributor/text()}"/>
      <meta name="DC.date" content="{$item/date/text()}"/>
      <meta name="DC.Type" content="{$item/type/text()}"/>
      <meta name="DC.Format" content="{$item/format/text()}"/>
      <meta name="DC.Identifier" content="{$item/identifier/text()}"/>
      
      <meta name="DC.Source" content="{$item/source/text()}"/>
      <meta name="DC.Language" content="{$item/language/text()}"/>
      <meta name="DC.Contributr" content="{$item/contributr/text()}"/>
      <meta name="DC.Coverage" content="{$item/coverage/text()}"/>
      <meta name="DC.Rights" content="{$item/rights/text()}"/>

      {style:css('xhtml')}
   </head>
   
   <body>
      <div id="container">
        {style:header()}

        {style:breadcrumbs(())}
       <div class="content">
       <h2>{$title}</h2>
       
         <p>This page adds Dublin Core metadata that the FireFox "Zotero" Plugin can use
         to automatically extract book metadata.</p>
         <table>
            <tbody>
             <tr><th class="field-label">ID:</th><td>{$item/id/text()}</td></tr>         
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
      </div>
   </body>
</html>