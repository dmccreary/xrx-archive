xquery version "1.0";

declare option exist:serialize "method=xhtml media-type=text/html omit-xml-declaration=yes indent=yes";

(: return an integer that is the depth of the site where:

   Home = 1
   Apps = 2
   App = 3
   
:)
declare function local:site-depth() as xs:integer {
(: if the context adds '/exist' then the offset is six levels.
If the context is '/' then we only need to subtract 5 :)
let $offset :=
  if (request:get-context-path() = '')
    then 5
    else 6
return (count(tokenize(request:get-uri(), '/')) - $offset)
};

declare function local:breadcrumbs() as node() {
   <div class="breadcrumbs">
   
      {if (local:site-depth() gt 1)
         then
            <a href="{request:get-context-path()}/rest/db/dma/index.xq">Home</a>
         else ()
      }
      
      {if (local:site-depth() gt 2)
         then
           ('&gt;', <a href="{request:get-context-path()}/rest/db/dma/apps/index.xq">Apps</a>)
         else ()
      }
      
      {if (local:site-depth() gt 3)
         then
             (' &gt; ',
             <a href="{request:get-context-path()}/rest/db/dma/apps/training/index.xq">App</a>
             )
          else ()
      }
   </div>
};

let $title := 'Breadcrumb Test'

return
<html>
   <head>
      <title>{$title}</title>
   </head>
   <body>
      Web Context Path = {request:get-context-path()}<br/>
      Collection Context = {substring-after(request:get-uri(), '/rest')}<br/>
      Depth = {local:site-depth()}<br/>
      {local:breadcrumbs()}
   </body>
</html>
