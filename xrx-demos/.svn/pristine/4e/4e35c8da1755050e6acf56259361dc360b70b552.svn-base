xquery version "1.0";
import module namespace cms = "http://cms.metadata.thrivent.com" at "/db/mdr/cms/cms-module.xq";
declare namespace exist="http://exist.sourceforge.net/NS/exist";
declare option exist:serialize "method=html media-type=text/html indent=yes";
let $space := ' '
let $system-id := request:get-parameter('system-id', '')
let $my-file := concat('/db/mdr/data-stores/data/',$system-id ,'-Entities.xml')
let $my-doc := doc($my-file)
return
<html>
    <head>
        <title>{$system-id} Schema</title>
        {cms:import-css-tables()}
        <link rel="stylesheet" type="text/css" href="../../resources/css/thrivent.css"/>
        <link rel="stylesheet" type="text/css" href="../../resources/css/tables.css"/>
    </head>
    <body>
           {cms:header()}
        <a class="breadcrumb" href="../../index.xhtml">Metadata Registry Home</a>&gt;
        <a class="breadcrumb" href="../index.xhtml">Data Stores Manager</a>
        <h1>{$system-id} Tables </h1>
        <p><b>Number of Tables:</b> {$space}{count($my-doc//row)}</p>
        <table border="1">
            <thead>
              <tr>
                  <th>Table Name</th>
                  <th>Table Description</th> 
              </tr>
         </thead>
         <tbody>{
         for $my-row at $count in $my-doc/root/row
			 let $my-table := $my-row/Entity_Name/text()
		 order by $my-table
         return
		   <tr> 
          <td><a href="datastore-view-entity.xq?system-id={$system-id}&amp;entity-name={$my-table}">{$my-table }</a></td>
          <td>{if (empty($my-row/Definition/text())) then "<<None>>" else $my-row/Definition/text()}</td>
        </tr>
           }</tbody>
         </table>
      </body>
</html>
