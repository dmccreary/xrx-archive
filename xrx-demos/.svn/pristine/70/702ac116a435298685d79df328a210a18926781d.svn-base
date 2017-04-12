xquery version "1.0";
import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";
import module namespace sch-util='http://code.google.com/p/xrx/schema-util' at '../modules/schema-utils.xqm';



declare namespace xs="http://www.w3.org/2001/XMLSchema";

(: this diff assumes that the inputs are in alphabetical order :)
declare function local:diff($a, $b  as item()*  )  as item()* {
if (empty($a) and empty ($b)) 
   then ()
   else
     if (empty ($b) or $a[1] lt $b[1])
        then
           (<tr class="left"><td>{$a[1]/text()}</td><td/><td/></tr>,
            local:diff(subsequence($a, 2), $b)
           )
        else
          if (empty ($a) or $a[1] gt $b[1])
              then
                (<tr class="right">
                   <td/><td/><td>{$b[1]/text()}</td>
                 </tr>,
                 local:diff($a, subsequence($b,2))
                )  
              else
                 (<tr class="both">
                    <td/><td>{$a[1]/text()}</td><td/>
                  </tr>,
                  local:diff(subsequence($a,2), subsequence($b,2))
                 )
};



let $output := request:get-parameter('output', 'html')
let $name := request:get-parameter('name', '')
let $file1 := request:get-parameter('file1', '')
let $file2 := request:get-parameter('file2', '')

let $title := concat('Diff Unit Test for ', $name)

return if (not($name)) then
<error>
   <message>Error: The complexType parameter 'name' is a required parameter.</message>
</error> else

if (not($file1)) then
<error>
   <message>Error: The File Name parameter 'file1' is a required parameter.</message>
</error> else

if (not($file2)) then
<error>
   <message>Error: The File Name parameter 'file2' is a required parameter.</message>
</error> else

let $data-collection := $style:db-path-to-app-data
let $file-path1 := concat($data-collection, '/', $file1)
let $file-path2 := concat($data-collection, '/', $file2)
  
let $complexType1 := doc($file-path1)/xs:schema//xs:complexType[@name=$name]
let $complexType2 := doc($file-path2)/xs:schema//xs:complexType[@name=$name]

let $list1b := sch-util:element-names-for-complex-type($complexType1)
let $list2b := sch-util:element-names-for-complex-type($complexType2)


return
if ($output = 'xml')
then
<result>
   <list1b>{$list1b}</list1b>
   <list2b>{$list2b}</list2b>
   <diff>
      {local:diff($list1b/element, $list2b/element) }
   </diff>
</result>
else

let $content :=
<div class="content">
   <table class="span-12 last">
      <thead>
         <tr>
            <th class="span-4">{$file1}</th>
            <th class="span-4">Both</th>
            <th class="span-4 last">{$file2}</th>
         </tr>
      </thead>
      <tbody>
        {sch-util:diff-sequences-to-table-rows($list1b/element, $list2b/element) }
      </tbody>
   </table>
</div>
return
    style:assemble-page($title, $content)