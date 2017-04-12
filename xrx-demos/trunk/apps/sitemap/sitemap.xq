xquery version "1.0";
import module namespace style='http://danmccreary.com/style' at "../../modules/style.xqm";
declare option exist:serialize "method=xhtml media-type=text/html indent=yes";

declare function local:sitemap($collection as xs:string) as node()* {
   for $child in xmldb:get-child-collections($collection)
      let $path := concat($collection, '/', $child)
      order by $child
   return
        <ul>
           <li><a href="{concat('/exist/rest', $collection, '/', $child)}">
              {
              if (
                 exists(doc('/db/dma/apps/sitemap/collection-titles.xml')/code-table/item[$path=path]/title/text())
                 )
                 then (doc('/db/dma/apps/sitemap/collection-titles.xml')/code-table/item[$path=path]/title/text())
                 else ($child)
              }
              </a>
           </li>
           {local:sitemap(concat($collection, '/', $child))}
        </ul>
};
 
<html>
   <head>
      <title>Sitemap</title>
   </head>
   <body>
      {style:header()}
      {local:sitemap('/db/dma')}
      {style:footer()}
   </body>
</html>