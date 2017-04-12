xquery version "1.0";
import module namespace cms = "http://cms.metadata.thrivent.com" at "../../cms/cms-module.xq";
declare namespace exist="http://exist.sourceforge.net/NS/exist";
declare namespace request="http://exist-db.org/xquery/request";
declare option exist:serialize "method=html media-type=text/html indent=yes";

let $values-path := '/db/mdr/domains/Values.xml' 
let $system-id := request:get-parameter('system-id', "")
let $attribute-name := request:get-parameter('attribute-name', '')
let $entity-name := request:get-parameter('entity-name', '')
let $my-file := concat('/db/mdr/data-stores/data/',$system-id ,'-Attributes.xml')
let $my-doc := doc($my-file)
let $registered-datastores := doc('/db/mdr/data-stores/data/registered-datastores.xml')

return
<html>
   <head>
      <title>{$system-id} Schema</title>
      {cms:import-css-tables()}
    </head>
    <body>
         {cms:header()}
        <a class="breadcrumb" href="../../index.xhtml">Metadata Registry Home</a>&gt;
        <a class="breadcrumb" href="../index.xhtml">Data Stores Manager</a>
       <h3>Thrivent ERStudio Data Dictionary</h3>

       <h1>Attribute: &quot;{$system-id}.{$entity-name}.{$attribute-name}&quot;</h1>
		{
         let $attribute := $my-doc/root/row [Column_Name=$attribute-name 
            and Entity_Name=$entity-name]
         return        
        <table>
            <thead>
               <th>Field</th>
               <th>Value</th>
            </thead>
            <tbody>
                <tr><td class="label">Entity Name</td><td>{$attribute/Entity_Name/text()}</td></tr>
                <tr class="even"><td class="label">Column Name</td><td>{$attribute/Column_Name/text()}</td></tr>
                <tr><td class="label">Definition</td><td>{$attribute/Definition/text()}</td></tr>
                <tr class="even"><td class="label">SystemID</td><td>{$attribute/SystemID/text()}</td></tr>
            </tbody>
          </table>
		}
       <h1>Domain:</h1>
       {
         let $domain :=doc('/db/mdr/domains/Domains.xml')/root/row[Column_Name=$attribute-name]
            let $name := $domain/Domain_Name
            let $folder := $domain/Domain_Folder
            (: Depending on how the data was extracted and/or local domain usage, may need to search on folder and name :)
            (: let $reference-finder := concat($folder,": ",$name) :)
            let $reference-finder := $name
         return
        <table>
            <thead>
               <th>Field</th>
               <th>Value</th>
            </thead>
            <tbody>
                <tr><td class="label">Domain Name</td><td>{$domain/Domain_Name/text()}</td></tr>
                <tr class="even"><td class="label">Domain Definition</td><td>{$domain/Domain_Definition/text()}</td></tr>
				{
				 if (ends-with($name, 'Code')) then (
				  <tr><td class="label">Domain Values:</td>
						<td><table>
						<thead>
						   <tr>
							  <td>Type</td>
							  <td>Value</td>
							  <td>End Value</td>
							  <td>Value Description</td>
						   </tr>
						</thead>
						{
						 for $row in doc($values-path)/root/row[Reference_Value_Name/text() = $reference-finder ]
						 return
						  <tr>
							 <td>{$row/Type/text()}</td>
							 <td>{$row/Value/text()}</td>
							 <td>{$row/End_Value/text()}</td>
							 <td>{$row/Value_Description/text()}</td>
						  </tr>
					  }</table></td>
				  </tr>)
				  else ()
				  }
                <tr><td class="label">Column Name</td><td>{$domain/Column_Name/text()}</td></tr>
                <tr class="even"><td class="label">Domain Folder</td><td>{$domain/Domain_Folder/text()}</td></tr>
                <tr><td class="label">Domain Note</td><td>{$domain/Domain_Note/text()}</td></tr>
                <tr class="even"><td class="label">Data Type</td><td>{$domain/DataT_ype/text()}</td></tr>
                <tr><td class="label">Data Type Width</td><td>{$domain/Data_Type_Width/text()}</td></tr>
                <tr class="even"><td class="label">Data Type Scale</td><td>{$domain/Data_Type_Scale/text()}</td></tr>
                <tr><td class="label">Allow Nulls</td><td>{$domain/Allow_Nulls/text()}</td></tr>
                <tr class="even"><td class="label">Identity Column</td><td>{$domain/Identity_Column/text()}</td></tr>
                <tr><td class="label">Identity Seed</td><td>{$domain/Identity_Seed/text()}</td></tr>
                <tr class="even"><td class="label">Identity Increment</td><td>{$domain/Identity_Increment/text()}</td></tr>
            </tbody>
          </table>
      }
		<h1>Other References: </h1>
        <table>
            <thead>
               <th>Table Name</th>
            </thead>
            <tbody>
			{
			(: Loop through all registered models :)
			 for $my-system in $registered-datastores/root/row//SystemID
				let $mysystem-file := concat('/db/mdr/data-stores/data/',$my-system,'-Attributes.xml')
				let $mysystem-doc := doc($mysystem-file)
				(: nested loop to find tables that match the selected column :)
				 for $attribute in $mysystem-doc/root/row 
				 let $newentity-name := $attribute/Entity_Name/text()
				 let $newattribute-name := $attribute/Column_Name/text()
				 where $newattribute-name =$attribute-name 
				    and (($my-system = $system-id and $newentity-name != $entity-name) or
						   ($my-system != $system-id ))
				 return
					 <tr><td>
						 <a href="datastore-view-entity.xq?system-id={$my-system}&amp;entity-name={$newentity-name}">{$my-system}.{$newentity-name}</a>
					 </td></tr>
			}
            </tbody>
          </table>
      
   </body>
</html>