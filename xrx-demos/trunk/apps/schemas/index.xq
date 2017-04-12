xquery version "1.0";

(: Dan McCreary Sept 2010 :)

import module namespace style = "http://danmccreary.com/style" at "../../modules/style.xqm";

let $title := 'XML Schema Unit Testing'

let $content := 
<div class="content">
   <p>Welcome to the {$title}.</p>
   <p>This Application is used to test the XML Schema testing process:    </p>
      
     <ol>
          <li>
              <a href="views/list-schemas.xq">List XML Schemas</a> A list of all XML Schema files is registry
          </li>
          <li>
              <a href="views/view-transaction-types.xq">Transaction Types</a> A list of transaction types for each XML Schema
          </li>
          
          <li>
              <a href="views/grid-compare.xq">Grid Comparison</a> Display a list of schemas in a grid
          </li>
     </ol>

        
    <h3>Search</h3>
      <ol>
          <li>
              <a href="search/search-forms.xq">Search Forms</a> Search tools
          </li>
          <li>
              <a href="search/reindex.xq">Reindex</a> Reindex
          </li>
      </ol>
        
    
    
    <h3>Unit Tests for XML Differencing Algorithm</h3>
    <ol>
      <li>
          <a href="unit-tests/diff-test-1.xq">Diff Test 1</a> Basic depth-first search diff testing for XML
      </li>
      <li>
          <a href="unit-tests/diff-test-2.xq">Diff Test 2 HTML</a> Basic diff test for XML Schema complexTypes
      </li>
      <li>
          <a href="unit-tests/diff-test-2.xq?output=xml">Diff Test 2 XML</a> Basic diff test for XML Schema complexTypes
      </li>
     
    </ol>

 </div>
     
return
    style:assemble-page($title, $content)