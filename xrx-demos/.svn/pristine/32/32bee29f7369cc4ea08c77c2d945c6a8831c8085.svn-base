xquery version "1.0";
import module namespace cms = "http://cms.metadata.thrivent.com" at "/db/mdr/cms/cms-module.xq";
import module namespace date = "http://exist-db.org/xquery/admin-interface/date" at "/db/mdr/modules/date.xq";
declare namespace exist="http://exist.sourceforge.net/NS/exist";
declare namespace xdb="http://exist-db.org/xquery/xmldb";
declare namespace sch="http://purl.oclc.org/dsdl/schematron";
declare option exist:serialize "method=html media-type=text/html indent=yes";
let $collection := '/db/mdr/rules/schematron/rule-sets'
return
<html>
   <head>
      <title>Listing of Metadata Registry Tasks</title>
      {cms:import-css-tables()}
    </head>
    <body>
         {cms:header()}
       <a class="breadcrumb" href="../../../index.xhtml">Metadata Registry Home</a> &gt;
        <a class="breadcrumb" href="../..index.xhtml">Rules</a>  &gt;
        <a class="breadcrumb" href="../index.xhtml">Schematron</a>
       <h3>Schematron RuleSets by Last Modified Date</h3>
       <p>All metadata tasks sorted by task priority.</p>
        <table>
            <thead>
                <tr>
                   <th>File</th>
                   <th>Title</th>
                   <th>Created</th>
                   <th>Last Modified</th>
                   <th>Edit</th>
                  <th>Compile</th>
                  <th>XML</th>                  
                </tr>
            </thead>
            <tbody>{         
                for $rule-set in collection($collection)/sch:schema
                   let $id := $rule-set/filename/text()
                   
             
                return
                <tr>
                    <td>{$rule-set/sch:title/text()}</td>
                    <td><a href="view-single-task.xq?id={$id}">{$rule-set/sch:pattern[1]/@name}</a></td>
                    <td>Edit</td>
                    <td>Compile</td>
                    <td>XML</td>
           </tr>
          }</tbody>
         </table>
         <a href="http://dlficsb501:8080/exist/rest/db/mdr/tasks/edit.xq?new=true">Create New Ruleset</a>
    </body>
</html>
