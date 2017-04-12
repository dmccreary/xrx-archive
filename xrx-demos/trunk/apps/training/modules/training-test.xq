import module namespace train = "http://www.danmccreary.com/training" at "training.xqm";

let $title := 'Training Module Unit Tests'

return
<test-results>
   <test>
      <function>$train:app-home</function>
      <expected>/db/dma/apps/training</expected>
      <result>{$train:app-home}</result>
   </test>
   <test>
      <function>train:document-type-label(</function>
      <expected>Google Docs Document</expected>
      <result>{train:document-type-label('google-doc')}</result>
   </test>
</test-results>
