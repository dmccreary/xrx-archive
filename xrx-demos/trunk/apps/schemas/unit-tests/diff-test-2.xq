xquery version "1.0";
import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";

declare namespace xs="http://www.w3.org/2001/XMLSchema";

declare function local:diff($a, $b  as item()*  )  as item()* {
    if (empty($a) and empty ($b)) 
       then ()
       else
         if (empty ($b) or $a[1] lt $b[1])
            then
               (<div class="left">{$a[1]/text()}</div>,
                local:diff(subsequence($a, 2), $b)
               )
            else
              if (empty ($a) or $a[1] gt $b[1])
                  then
                    (<div class="right">{$b[1]/text()}</div>,
                     local:diff($a, subsequence($b,2))
                    )  
                  else
                     (<div class="both">{$a[1]/text()}</div>,
                      local:diff(subsequence($a,2), subsequence($b,2))
                     )
};

let $title := 'Diff Unit Test'

let $output := request:get-parameter('output', 'html')
  
let $list1 := 
<xs:complexType name="PatientIDType">
    <xs:choice maxOccurs="2">
        <xs:element name="FileID" type="an..35" minOccurs="0"/>
        <xs:element name="MedicareNumber" type="an..35" minOccurs="0"/>
        <xs:element name="MedicaidNumber" type="an..35" minOccurs="0"/>
        <xs:element name="PPONumber" type="an..35" minOccurs="0"/>
        <xs:element name="SocialSecurity" type="an..35" minOccurs="0"/>
        <xs:element name="PayerID" type="an..35" minOccurs="0"/>
        <xs:element name="PriorAuthorization" type="an..35" minOccurs="0"/>
        <xs:element name="BIN" type="an..35" minOccurs="0"/>
        <xs:element name="MutuallyDefined" type="an..35" minOccurs="0"/>
    </xs:choice>
</xs:complexType>

let $list1b :=
<element-names>{
for $element in $list1/xs:choice/xs:element/@name
   order by $element
   return
   <element>{string($element)}</element>
}</element-names>
 
 
let $list2 := 
<xs:complexType name="PatientIDType">
    <xs:choice minOccurs="0" maxOccurs="2">
        <xs:element name="NCPDPID" type="an..35" minOccurs="0"/>
        <xs:element name="FileID" type="an..35" minOccurs="0"/>
        <xs:element name="StateLicenseNumber" type="an..35" minOccurs="0"/>
        <xs:element name="MedicareNumber" type="an..35" minOccurs="0"/>
        <xs:element name="MedicaidNumber" type="an..35" minOccurs="0"/>
        <xs:element name="DentistLicenseNumber" type="an..35" minOccurs="0"/>
        <xs:element name="UPIN" type="an..35" minOccurs="0"/>
        <xs:element name="PPONumber" type="an..35" minOccurs="0"/>
        <xs:element name="PayerID" type="an..35" minOccurs="0"/>
        <xs:element name="BINLocationNumber" type="an..35" minOccurs="0"/>
        <xs:element name="DEANumber" type="an..35" minOccurs="0"/>
        <xs:element name="HIN" type="an..35" minOccurs="0"/>
        <xs:element name="SecondaryCoverage" type="an..35" minOccurs="0"/>
        <xs:element name="NAICCode" type="an..35" minOccurs="0"/>
        <xs:element name="PromotionNumber" type="an..35" minOccurs="0"/>
        <xs:element name="SocialSecurity" type="an..35" minOccurs="0"/>
        <xs:element name="NPI" type="an..35" minOccurs="0"/>
        <xs:element name="PriorAuthorization" type="an..35" minOccurs="0"/>
        <xs:element name="MutuallyDefined" type="an..35" minOccurs="0"/>
    </xs:choice>
</xs:complexType>

let $list2b :=
<element-names>{
for $element in $list2/xs:choice/xs:element/@name
   order by $element
   return
   <element>{string($element)}</element>
}</element-names>

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
   <style><![CDATA[
       .left {margin-left: 1ex;}
       .both {margin-left: 20ex;}
       .right {margin-left: 40ex;}
   ]]></style>
   {local:diff($list1b/element, $list2b/element) }
</div>
return
    style:assemble-page($title, $content)