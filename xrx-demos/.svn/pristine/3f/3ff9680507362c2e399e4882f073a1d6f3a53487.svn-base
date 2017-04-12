xquery version "1.0";
import module namespace cms = "http://cms.metadata.thrivent.com" at "/db/mdr/cms/cms-module.xq";
import module namespace date = "http://exist-db.org/xquery/admin-interface/date" at "/db/mdr/modules/date.xq";
declare namespace exist="http://exist.sourceforge.net/NS/exist";
declare namespace request="http://exist-db.org/xquery/request";
declare namespace xdb="http://exist-db.org/xquery/xmldb";
declare namespace util="http://exist-db.org/xquery/util";

declare namespace sch="http://purl.oclc.org/dsdl/schematron";
declare option exist:serialize "method=html media-type=text/html indent=yes";

let $collection := '/db/mdr/rules/schematron/test-rule-sets'

return
<html>
   <head>
      <title>Listing of Rule Sets</title>
      {cms:import-css-tables()}
    </head>
    <body>
         {cms:header()}
       <a class="breadcrumb" href="../../../index.xhtml">Metadata Registry Home</a> &gt;
        <a class="breadcrumb" href="../../index.xhtml">Rules</a>  &gt;
        <a class="breadcrumb" href="../index.xhtml">Schematron</a>
        <h3>Test Rule Sets</h3>
        <p>Sort by Collection Order</p>
        <table>
        <thead>
           <tr>
              <th>File Name</th>
              <th>Title</th>
              <th>Rules</th>
              <th>Created</th>
              <th>Modified</th>
              <th>Size</th>
              <th>Edit</th>
              <th>Compile</th>
              <th>XML</th>
           </tr>
        </thead>
        {
           for $child in xdb:get-child-resources($collection)
           order by $child
          return
        <tr>
            <td>{$child}</td>
            <td>{doc(concat('/db/mdr/rules/schematron/test-rule-sets/', $child) )//*:title/text()}</td>
            <td align="center">{count(doc(concat('/db/mdr/rules/schematron/test-rule-sets/', $child) )/sch:schema//sch:rule)}</td>
            <td>{date:format-dateTime(xdb:created($collection, $child))}</td>
            <td>{date:format-dateTime(xdb:last-modified($collection, $child))}</td>
            <td  align="center">{xdb:size($collection, $child) div 1024}</td>
            <td  align="center"><a href="../edit/edit.xq?id={$child}">Edit</a></td>
            <td  align="center"><a href="../xqueries/compile-ruleset-xml.xq?test=true&amp;ruleset={$child}">Compile</a></td>
            <td  align="center"><a href="../test-rule-sets/{$child}">XML</a></td>
        </tr>
        }</table>
   </body>
</html>
