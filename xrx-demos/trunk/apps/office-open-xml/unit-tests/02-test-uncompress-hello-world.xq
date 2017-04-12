declare namespace t = "test";

declare function t:filter($path as xs:string, $type as xs:string, $param as item()*) as xs:boolean {
 (: pass all :)
 true()
};

declare function t:process($path as xs:string,$type as xs:string, $data as item()? , $param as item()*) {
 (: return the XML :)
 $data
};


(: this sets up the function types :)
let $filter := util:function(QName("test","t:filter"),3)
let $process := util:function(QName("test","t:process"),4)

let $file-path := '/db/dma/apps/office-open-xml/unit-tests/data/input/hello-world.docx'
let $file := util:binary-doc($file-path)
let $xml := compression:unzip($file, $filter, (), $process, ())

return
<results>
   <file-path>{$file-path}</file-path>
   <output>{$xml}</output>
</results>

