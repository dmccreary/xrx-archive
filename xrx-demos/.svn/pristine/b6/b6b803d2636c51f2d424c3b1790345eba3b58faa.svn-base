xquery version "1.0";
import module namespace style = "http://surescripts.com/style" at "../../../modules/style.xqm";

(: list all the data in a given taxonomy file :)

let $file := request:get-parameter('file', 'security-documents.xml')

let $title := "List Document Categories"

let $app-collection := $style:db-path-to-app
let $data-collection := concat($app-collection, '/data')
let $doc-path := concat($data-collection, '/', $file)
return

let $content :=
<div class="content">
    
      
       {
          for $top-level-category in doc($doc-path)/taxonomy/category
             let $name := $top-level-category/category-name/text()
             let $top-cat-id := $top-level-category/category-id/text()
          return
             <form method="get" action="../../docs/search/echo-url-parameters.xq" >
                <label>{$name}</label><br/>

                   {for $sub-category in $top-level-category/category
                   let $cat-id := $sub-category/category-id/text()
                   let $sub-cat-name := $sub-category/category-name/text()
                   return
                      (<input type="checkbox" name="{$top-cat-id}" value="{$cat-id}">{$sub-cat-name}</input>,<br/>)
                   }

                <br/>
                <input type="submit" value="Search"/>
                <br/><br/>
             </form>
             
       }
       
        <form method="get" action="../../docs/search/echo-url-parameters.xq">
          <input type="checkbox" name="iso-27001" value="risk-assessment">Risk Assessment</input>
          <input type="checkbox" name="security-policies" value="risk-mgmt">Risk Management Policy</input>

          <input type="submit" value="Search" />
       </form><br/><br/>

       <form method="get" action="../../docs/search/echo-url-parameters.xq">
        <p>
            <label>Keyword:</label>
            <input name="q" type="text" size="60" />
            <input type="submit" value="Search"/>
        </p>
    </form>

   
</div>

return style:assemble-page($title, $content)