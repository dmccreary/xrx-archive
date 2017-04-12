import module namespace util2 = "http://danmccreary.com/util2" at "util2.xqm";

let $title := 'Utility 2 Module Tester'

return
<results>
   <test>
      <input>util2:mkdirs('/db/system/config/db/dma/apps/template/data')</input>
      <output>{util2:mkdirs('/db/system/config/db/dma/apps/template/data')}</output>
   </test>
</results>


