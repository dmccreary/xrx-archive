xquery version "1.0";

module namespace oox = 'http://exist-db.org/xquery/office-open-xml';

import module namespace compression = "http://exist-db.org/xquery/compression";
import module namespace xmldb = "http://exist-db.org/xquery/xmldb";

(: Office Open XML eXist Module 
   See http://en.wikipedia.org/wiki/Office_Open_XML
   
   :)

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
 
 (: these are hard-coded for testing :)
declare variable $oox:input-collection := '/db/dma/apps/office-open-xml/data/input';
declare variable $oox:output-collection := '/db/dma/apps/office-open-xml/data/output';

declare function oox:unzip-entry-filter($path as xs:string, $data-type as xs:string, $param as item()*) as xs:boolean {
    (: pass all :) 
    true()
};

(: this function is passed as an argument to the unzip function to tell it what to get out of the zip file. :)
declare function oox:unzip-entry-data($path as xs:string, $data-type as xs:string, $data as item()?, $param as item()*) {

(: check for a list params :)
if ($param[@name eq 'list']/@value eq 'true') then
        <item path="{$path}" data-type="{$data-type}"/>
    else 
 
 (: else we are going to unzip a file and store the data :)
 
 (: hard code this for testing ....$param[@name="base-collection"]/@value/string() :)
        let $base-collection := '/db/dma/apps/office-open-xml/data'
        let $zip-collection := 
            concat(
                functx:substring-before-last($param[@name="zip-filename"]/@value, '.'),
                '_',
                functx:substring-after-last($param[@name="zip-filename"]/@value, '.')
                ,
                '_parts/'
            )
        let $inner-collection := 'hello' (: functx:substring-before-last($path, '/') :)
        
        (: this gets the file name after the last / :)
        let $filename := if (contains($path, '/')) then functx:substring-after-last($path, '/') else $path
        
        (: we need to encode the filename to account for filenames with illegal characters like [Content_Types].xml :)
        let $filename := xmldb:encode($filename)
        (: concat($base-collection, $zip-collection, $inner-collection) :)
        let $target-collection := '/db/dma/apps/ms-office/data/hello-world' 
        let $mkdir := 
            if (xmldb:collection-available($target-collection)) then () 
            else xmldb:create-collection($base-collection, concat($zip-collection, $inner-collection))
        let $store := 
            (: ensure mimetype is set properly for .docx rels files :)
            if (ends-with($filename, '.rels')) then 
                xmldb:store($target-collection, $filename, $data, 'application/xml')
            else
                xmldb:store($target-collection, $filename, $data)
        return 
            <result object="{$path}" destination="{concat($target-collection, '/', $filename)}"/>
};

declare function oox:unzip($base-collection as xs:string, $zip-filename as xs:string, $action as xs:string) {

if (not($action = ('list', 'unzip'))) then <error>Invalid action</error>
    else
    
let $file := util:binary-doc(concat($base-collection, '/', $zip-filename))

let $entry-filter := util:function(QName("local", "oox:unzip-entry-filter"), 3)

let $entry-filter-params := ()

let $entry-data := util:function(QName("local", "oox:unzip-entry-data"), 4)

let $entry-data-params := 
    (
        if ($action eq 'list')
           then
              <param name="list" value="true"/>
           else ()
    , 
        <param name="base-collection" value="{$base-collection}"/>,
        <param name="zip-filename" value="{$zip-filename}"/>
        )
        
let $login := xmldb:login('/db', 'admin', '')
let $unzip := compression:unzip($file, $entry-filter, $entry-filter-params, $entry-data, $entry-data-params)

    return 
        <results-of-unzip>
           <unzip>{$unzip}</unzip>
           {$entry-data-params}
        </results-of-unzip>
};

(: echo the local parameters :)
declare function oox:ch-params($base-collection as xs:string, $zip-filename as xs:string, $action as xs:string) {
<params>
  <base-collection>{$base-collection}</base-collection>
  <file-name>{$zip-filename}</file-name>
  <action>{$action}</action>
</params>
};
