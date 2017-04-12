xquery version "1.0";
declare option exist:serialize "method=xhtml media-type=text/html omit-xml-declaration=yes indent=yes";

let $title := 'Unit Test Runner'

let $tests := doc('http://demo.danmccreary.com/rest/db/dma/apps/training/samples/unit-test/unit-tests.xml')//unit-test

let $test-results :=
<test-results>
   {for $test in $tests
       let $test-result := util:eval($test/test/text())
       return
       <test-result>
          {$test/name}
          {$test/expected}
          <actual>{$test-result}</actual>
          <pass-fail>
             {if ($test-result = $test/expected/text())
                 then <span class='pass'>pass</span>
                 else <span class='fail'>fail</span>
             }
          </pass-fail>
       </test-result>
   }
</test-results>

return
<html>
   <head>
      <title>{$title}</title>
      <style type="text/css"><![CDATA[
         body {font-family: Arial,Helvetica,sans-serif;}
         .pass {color:green; font-weight: bold;}
         .fail {color:red; font-weight: bold;}
         table {border-collapse:collapse;}
         th {background-color: lavender;}
         tbody tr td, thead tr th {padding: 5px; text-align: center;}
         tbody tr th {text-align: left;}
      ]]></style>
   </head>
   <body>
      <h1>{$title}</h1>
      
   total-count = {count($tests)} <br/>
   pass-count = {count($test-results/test-result[./pass-fail/span/text() = 'pass'])}<br/>
   fail-count ={count($test-results/test-result[./pass-fail/span/text() = 'fail'])}<br/>
   
     <table>
       <thead>
            <tr>
               <th>Test Name</th>
               <th>Expected</th>
               <th>Actual</th>
               <th>Pass Fail</th>
            </tr>
        </thead>
      <tbody>
          {for $test in $test-results//test-result
            return
               <tr>
                  <th>{$test/name/text()}</th>
                  <td>{$test/expected/text()}</td>
                  <td>{$test/actual/text()}</td>
                  <td>{$test/pass-fail}</td>
               </tr>
            }
         </tbody>
      </table>
   </body>
</html>