module namespace de = "http://mdr.crossflow.com/data-elements";

declare namespace request="http://exist-db.org/xquery/request";
declare namespace census="http://niem.gov/niem/census/2.0";
declare namespace fips_5-2="http://niem.gov/niem/fips_5-2/2.0";
declare namespace can="http://niem.gov/niem/post-canada/2.0";
declare namespace ansi_d20="http://niem.gov/niem/ansi_d20/2.0";
declare namespace niem-xsd="http://niem.gov/niem/proxy/xsd/2.0";
declare namespace fips_10-4="http://niem.gov/niem/fips_10-4/2.0";
declare namespace iso_639-3="http://niem.gov/niem/iso_639-3/2.0";
declare namespace twpdes="http://niem.gov/niem/twpdes/2.0";
declare namespace i="http://niem.gov/niem/appinfo/2.0";
declare namespace iso_4217="http://niem.gov/niem/iso_4217/2.0";
declare namespace ansi-nist="http://niem.gov/niem/ansi-nist/2.0";
declare namespace fbi="http://niem.gov/niem/fbi/2.0";
declare namespace fips_6-4="http://niem.gov/niem/fips_6-4/2.0";
declare namespace dod_jcs-pub2.0="http://niem.gov/niem/dod_jcs-pub2.0-misc/2.0";
declare namespace usps="http://niem.gov/niem/usps_states/2.0";
declare namespace s="http://niem.gov/niem/structures/2.0";
declare namespace nonauth="http://niem.gov/niem/nonauthoritative-code/2.0";
declare namespace nc="http://niem.gov/niem/niem-core/2.0";
declare namespace ut_offender="http://niem.gov/niem/ut_offender-tracking-misc/2.0";
declare namespace xsd="http://www.w3.org/2001/XMLSchema";
declare namespace atf="http://niem.gov/niem/atf/2.0";
declare namespace iso_3166="http://niem.gov/niem/iso_3166/2.0";
declare namespace nga="http://niem.gov/niem/nga/2.0";
declare namespace unece="http://niem.gov/niem/unece_rec20-misc/2.0";


(: convience functions for data elements 
Dan McCreary
January 2009

This module assumes that all data elements are stored at:

   /db/ORG/apps/data-elements/data
   
This module assumes that NIEM data elements are stored at:

   /db/ORG/apps/niem/data/niem-core.xsd
:)

declare function de:get-xml-schema-datatype-for-element($element-id as xs:string) as xs:string {
    string($element-id)
};

declare function de:get-definition-for-element($element-id as xs:string) as xs:string {
    let $niem-xsd-path := '/db/crossflo/apps/niem/data/niem-core.xsd'
    let $definition := string(doc($niem-xsd-path)/xsd:schema/xsd:element[string(@name)=$element-id]/xsd:annotation/xsd:documentation/text())
    return
       if (exists($definition))
          then ($definition)
          else concat('No Defintion Found for ', $element-id, ' in the NIEM Data Dictionsary')
};

declare function de:niem-element-names() as xs:string* {
    let $niem-xsd-path := '/db/crossflo/apps/niem/data/niem-core.xsd'
    let $element-names := doc($niem-xsd-path)/xsd:schema/xsd:element/string(@name)
    return
       $element-names
};

declare function de:niem-element($name as xs:string) as node() {
    let $niem-xsd-path := '/db/crossflo/apps/niem/data/niem-core.xsd'
    let $element := doc($niem-xsd-path)/xsd:schema/xsd:element[string(@name)=$name]
    return
       $element
};

declare function de:get-restrictions-for-element($element-id as xs:string) as xs:string {
    $element-id
};

(: return a list of all the tag in a data element with commas between the tags :)
declare function de:tags($tags as node()?) as xs:string {
   let $tags := if ($tags) 
   then(concat($tags[1]/text(), ',',$tags[2]/text(), ',',$tags[3]/text())) 
   else()
  return $tags
};

(: return a list of all the tag in a data element with commas between the tags :)
declare function de:tags2($tags as node()?) as xs:string {
   let $tags := if ($tags) 
   then(concat($tags[1]/text(), ',',$tags[2]/text(), ',',$tags[3]/text()))  
   else()   
   return $tags
};

 

