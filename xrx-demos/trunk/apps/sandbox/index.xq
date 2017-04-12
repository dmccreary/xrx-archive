xquery version "1.0";
import module namespace style = "http://danmccreary.com/style" at "../../modules/style.xqm";

let $title := 'Developmnet Sandbox'

let $content := 
    <div>
       <p>The {$style:app-name} application designed to make it easy to execute small XQuery scripts.</p>
       
       <p>Note the following features.</p>
       <ol>
          <li>By default, only the first 20 result items are displayed.</li>
          <li>You can see the total execution time.</li>
          
       </ol>
       
       <a href="views/list-items.xq">List XQuery sets</a><br/>
       
       <a href="sandbox.xql">Run the Sandbox</a>
       <br/><br/>
       
       <h3>Unit Testing</h3>
       <a href="get-examples.xql">Get Examples</a>Run the get-examples.xql query that gets the examples from the data collection.<br/>
       <a href="unit-tests/get-select-test.xq?id=3">Selection List</a> Run the get-select-test.xq?id=3 query that gets the code tables.<br/>
     </div>
     
return
    style:assemble-page($title, $content)