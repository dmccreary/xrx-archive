xquery version "1.0";

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
                 then 'pass'
                 else 'fail'
             }
          </pass-fail>
       </test-result>
   }
</test-results>

return
<results>
   <total-count>{count($tests)}</total-count>
   <pass-count>{count($test-results/test-result[./pass-fail/text() = 'pass'])}</pass-count>
   <fail-count>{count($test-results/test-result[./pass-fail/text() = 'fail'])}</fail-count>
   {$test-results}
</results>