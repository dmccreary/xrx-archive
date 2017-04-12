xquery version "1.0";

import module namespace style = "http://danmccreary.com/style" at "/db/mdr/modules/style.xqm";
declare namespace xs="http://www.w3.org/2001/XMLSchema";
declare option exist:serialize "method=xhtml media-type=text/html omit-xml-declaration=yes indent=yes";

let $app-collection := style:app-base-uri()
let $doc := concat($data-collection, '/', 'niem-core.xsd')

(: we will be getting the inputs from here :)
let $input-file := concat($app-collection, 'ss-import/base-objects.xml')

(: we will be putting the outputs here :)
let $output-collection := concat($app-collection, '/data')
 
(: the login used must have write access to the collection :)
let $output-collection := xmldb:login($collection, 'admin', 'admin123')
 
return
<SplitResults>{
     for $term-data in doc($input-file)/Objects/Object
        (: For brevity we will create a file name with the term name.  Change this to be an ID function if you want :)
        let $term-name := $term-data/Term/text()
        let $filename := concat($term-name, '.xml')
        let $store-return := store($collection, $filename, $term-data)
     return
        <store-result>
           <store>{$term-name}</store>
           <filename>{$filename}</filename>
        </store-result>
}</SplitResults>

