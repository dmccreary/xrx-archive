xquery version "1.0";

import module namespace style = "http://danmccreary.com/style" at "../../modules/style.xqm";


let $title := 'Requirements Manager'

let $data-collection := $style:db-path-to-app-data

let $content := 
    <div class="content">
           <ol>

              <li>
                 <a href="views/hierarchy.xq">Requirements Hierarchy </a> Hierarchical List of All Requirement
              </li>
              
              <li>
                 <a href="views/level.xq?level=1">Level 1</a> Level 1 Requirements
              </li>
              
              <li>
                 <a href="search/search-form.xq">Search Requirements</a> Search Requirements
              </li>
              
              <li>
                 <a href="edit/edit.xq?new=true">New</a> Create a New Requirement
              </li>
              </ol>
              
              <h2>Other Reports</h2>
              <ol>
              <li>
                 <a href="views/list-items.xq">List Requirements </a> Tabular List of Requirement sorted by the Requirement Name
              </li>
              <li>
                 <a href="views/arch-significant.xq">Architecturally Significant Requirements</a> A listing of all requirements that have been classified
                 as Architecturally Significant implying that this requirement will impact the overall architecture of the system.
              </li>
              
              <li>
                 <a href="views/list-by-id.xq">Requirements sorted by ID</a> A listing of all requirements sorted by ID number
                 by priority.
              </li>
              
             <li>
                 <a href="views/list-by-priority.xq">Requirements sorted by Priority</a> A listing of all non-removed requirements sorted
                 by priority.
              </li>
              <!--
              <li>
                 <a href="views/cost-report.xq">Cost Report</a> Cost report
              </li>
              -->    
             <li>
                 <a href="views/list-new-requirements.xq">New Requirements Report</a> All requirements with the status of "New"
                 by priority.
              </li>
             
             <li>
                 <a href="views/approval-report.xq">Requirement Approval Report</a> A listing of all non-removed requirements with an indication of who approved them and the approval date.
                 (sorted by priority).
              </li>
              
                <li>
                 <a href="views/full.xq">Full Listing</a> A full listing of all requirements.
              </li>
              
           </ol>
           
           <h2>Web Services</h2>
           <ol>
              <li>
                 <a href="views/dump-all-xml.xq">Full Dump in XML Format</a> A full dump of all requirements in the system in XML format.
                 This web service can be used to export all requirement data into an external system.
              </li>
           </ol>
           
           <h2>Admin</h2>
           <ol>
               <li>
                 <a href="http://test.syntactica.com:8080/rest/db/system/config/db/cms/apps/requirements/data/collection.xconf">Configuration File</a> Reindex the collection after the configuration file has changed
              </li>
              <li>
                 <a href="admin/reindex.xq">Reindex</a> Reindex the collection after the configuration file has changed
              </li>
           </ol>
</div>                                           

return
    style:assemble-page($title, $content)