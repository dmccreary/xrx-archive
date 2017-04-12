declare namespace t = "test";

declare namespace functx = "http://www.functx.com"; 

declare function functx:substring-before-last($arg as xs:string?, $delim as xs:string) as xs:string {
   if (matches($arg, functx:escape-for-regex($delim)))
   then replace($arg,
            concat('^(.*)', functx:escape-for-regex($delim),'.*'),
            '$1')
   else ''
 } ;

declare function functx:substring-after-last($arg as xs:string?, $delim as xs:string) as xs:string {
   replace ($arg,concat('^.*',functx:escape-for-regex($delim)),'')
 } ;
 
declare function functx:escape-for-regex 
  ( $arg as xs:string? )  as xs:string {
   replace($arg,
           '(\.|\[|\]|\\|\||\-|\^|\$|\?|\*|\+|\{|\}|\(|\))','\\$1')
 } ;

declare function t:filter($path as xs:string, $type as xs:string, $param as item()*) as xs:boolean {
 (: pass all :)
 true()
};

declare function t:process($path as xs:string, $type as xs:string, $data as item()? , $param as item()*) {
 (: return the XML :)
 let $login := xmldb:login('/db/dma/apps/office-open-xml/unit-tests/data/output', 'admin', 'admin123')
 
 let $file-name := functx:substring-after-last($path, '/')
 let $clean-file-name := if ($file-name = '[Content_Types].xml') then 'Content_Types.xml' else $file-name
 
 let $mkdir := 
            if (xmldb:collection-available('/db/dma/apps/office-open-xml/unit-tests/data/output/04-store-test')) then () 
            else xmldb:create-collection('/db/dma/apps/office-open-xml/unit-tests/data/output', '04-store-test')

 let $store := xmldb:store('/db/dma/apps/office-open-xml/unit-tests/data/output/04-store-test', $clean-file-name, $data)
 return
 <item path="{$path}" type="{$type}">{name($data/*)}</item>
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

