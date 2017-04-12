xquery version "1.0";
import module namespace cms = "http://cms.metadata.thrivent.com" at "/db/mdr/cms/cms-module.xq";
declare namespace exist="http://exist.sourceforge.net/NS/exist";
declare option exist:serialize "method=html media-type=text/html indent=yes";
let $space := '   '
let $system-id := request:get-parameter('system-id', "")
let $search-string := request:get-parameter('entity-name', "")
let $my-file := concat('/db/mdr/data-stores/data/',$system-id ,'-Attributes.xml')
let $my-doc := doc($my-file)
let $domain-doc := doc('/db/mdr/domains/Domains.xml')
return
<html>
    <head>
        <title>{$system-id} Schema</title>
        <link rel="stylesheet" type="text/css" href="../../resources/css/thrivent.css"/>
        <link rel="stylesheet" type="text/css" href="../../resources/css/tables.css"/>
    </head>
    <body>
           {cms:header()}
        <a class="breadcrumb" href="../../index.xhtml">Metadata Registry Home</a> &gt;
        <a class="breadcrumb" href="../index.xhtml">Data Stores Manager</a>
        <h1>{$system-id} - {$search-string}</h1>
        <table border="1">
            <thead>
              <tr>
                  <th>Column Name</th> 
                  <th>Definition</th>
                  <th>Domain Attribute</th>
                  <th>Domain Definition</th>
              </tr>
         </thead>
         <tbody>{
         for $my-attribute at $count in $my-doc/root/row
            let $attribute-name := $my-attribute/Column_Name/text()
            let $entity-name := $my-attribute/Entity_Name/text()
            where $my-attribute/Entity_Name = $search-string 
         return

       <tr> {if ($count mod 2) then (attribute {'bgcolor'} {'Lavender'}) else ()}
          <td><a href="datastore-view-attribute.xq?system-id={$system-id}&amp;entity-name={$entity-name}&amp;attribute-name={$attribute-name}">{$attribute-name}</a></td>
          <td>{if (empty($my-attribute/Definition/text())) then " <<None>>" else $my-attribute/Definition/text()}</td>
			{
				(: Look up Thrivent shared domain :)
				 let $my-domain := $domain-doc/root/row[Column_Name/text() = $attribute-name]
				 return  
					(: If none found, say so, otherwise no content will be displayed :)
					if (empty($my-domain))
					then
							 (
								 <td>&lt;&lt;None&gt;&gt;</td>,
								 <td>&lt;&lt;None&gt;&gt;</td>
							  )
					else
					 (
						 <td>{$my-domain/Attribute_Name/text()}</td>,
						 <td>{$my-domain/Domain_Definition/text()}</td>
					  )
			}
        </tr>
           }</tbody>
         </table>
      </body>
</html>
