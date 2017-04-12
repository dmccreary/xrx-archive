declare namespace t = "test";

declare function t:filter($path as xs:string, $type as xs:string, $param as item()*) as xs:boolean {
 (: pass all :)
 true()
};

declare function t:process($path as xs:string,$type as xs:string, $data as item()? , $param as item()*) {
 (: return the XML :)
 $data
};

let $uri := request:get-parameter("uri", "http://www.iso.org/iso/iso_3166-1_list_en.zip")
let $zip := httpclient:get(xs:anyURI($uri), true(), () )/httpclient:body/text()

(: this sets up the function types :)
let $filter := util:function(QName("test","t:filter"),3)
let $process := util:function(QName("test","t:process"),4)

  let $xml := compression:unzip($zip, $filter, (), $process, ())
return
<results>
   <uri>{$uri}</uri>
   <output>{$xml}</output>
</results>

