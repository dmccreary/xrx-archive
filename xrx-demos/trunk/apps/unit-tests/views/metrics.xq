xquery version "1.0";

import module namespace style = "http://surescripts.com/style" at "../../../modules/style.xqm";

import module namespace run-test = "http://surescripts.com/run-tests" at "../modules/run-tests.xqm";

let $title := 'Unit Test Metrics'

let $data-collection := $style:db-path-to-app-data

let $file := request:get-parameter('file', '')
let $file-path := concat($data-collection, '/', $file)

let $test-set := 
   if ($file)
      then doc($file-path)/xslt-unit-tests
      else collection($data-collection)/xslt-unit-tests
      
let $tests := $test-set//unit-test

let $transactions := $tests//transaction-type-code/text()
let $distinct-transactions := distinct-values($transactions)

let $content :=
<div class="content">

<p>Metrics for .</p>
{if ($file)
   then <span><b>File=</b>{$file}<br/></span>
   else <span><b>Collection=</b>{$data-collection}</span>
}

<p>Metrics for collection: {$data-collection}.</p>

Count = <br/>
<table class="span-10">
   <thead>
      <tr>
         <th class="span-5">Metric</th>
         <th class="span-5 last">Value</th>
      </tr>
   </thead>
   <tbody>

       <tr>
          <td>Number of unit tests</td>
          <td>{count($tests)}</td>
       </tr>
       <tr>
          <td>Number of Max tests</td>
          <td>{count($tests//unit-test[input-file/text() = 'max.xml'] )}</td>
       </tr>
       <tr>
          <td>Number of Min tests</td>
          <td>{count($tests//unit-test[input-file/text() = 'min.xml'] )}</td>
       </tr>
   </tbody>
</table>



Distinct Transactions = {string-join($distinct-transactions, ', ')}

<h3>Counts by Transaction</h3>
<table class="span-6">
   <thead>
      <tr>
         <th class="span-5">Transaction</th>
         <th class="span-1 last">Count</th>
      </tr>
   </thead>
   <tbody>
       {for $transaction in $distinct-transactions
        return
        <tr>
           <td>{$transaction}</td>
           <td>{ count($tests//unit-test[transaction-type-code/text() = $transaction] )}</td>
        </tr>
       }
   </tbody>
</table>

</div>

return
    style:assemble-page($title, $content)