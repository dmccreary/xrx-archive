xquery version "1.0";

import module namespace style='http://danmccreary.com/style' at '../../../modules/style.xqm';

declare namespace functx = "http://www.functx.com"; 

declare function functx:substring-before-last($arg as xs:string?, $delim as xs:string) as xs:string {
   if (matches($arg, functx:escape-for-regex($delim)))
   then replace($arg,
            concat('^(.*)', functx:escape-for-regex($delim),'.*'),
            '$1')
   else ''
};

declare function functx:substring-after-last($arg as xs:string?, $delim as xs:string) as xs:string {
   replace ($arg,concat('^.*',functx:escape-for-regex($delim)),'')
};
 
declare function functx:escape-for-regex($arg as xs:string?) as xs:string {
   replace($arg,
           '(\.|\[|\]|\\|\||\-|\^|\$|\?|\*|\+|\{|\}|\(|\))','\\$1')
};

declare function local:unzip-entry-filter($path as xs:string, $data-type as xs:string, $param as item()*) as xs:boolean {
    (: pass all :) 
    true()
};

declare function local:unzip-docx($path as xs:string, $data-type as xs:string, $data as item()?, $param as item()*) {
    if ($param[@name eq 'list']/@value eq 'true') then
        <item path="{$path}" data-type="{$data-type}"/>
    else 
        let $base-collection := $param[@name="base-collection"]/@value/string()
        let $zip-collection := 
            concat(
                functx:substring-before-last($param[@name="zip-filename"]/@value, '.'),
                '_',
                functx:substring-after-last($param[@name="zip-filename"]/@value, '.')
                ,
                '_parts/'
            )
        let $inner-collection := functx:substring-before-last($path, '/')
        let $filename := if (contains($path, '/')) then functx:substring-after-last($path, '/') else $path
        (: we need to encode the filename to account for filenames with illegal characters like [Content_Types].xml :)
        let $filename := xmldb:encode($filename)
        let $target-collection := concat($base-collection, $zip-collection, $inner-collection)
        let $mkdir := 
            if (xmldb:collection-available($target-collection)) then () 
            else xmldb:create-collection($base-collection, concat($zip-collection, $inner-collection))
        let $store := 
            (: ensure mimetype is set properly for .docx rels files :)
            if (ends-with($filename, '.rels')) then 
                xmldb:store('/db/dma/apps/office-open-xml/unit-tests/data/output', $filename, $data, 'application/xml')
            else
                xmldb:store('/db/dma/apps/office-open-xml/unit-tests/data/output', $filename, $data)
        return 
            <result object="{$path}" destination="{concat($target-collection, '/', $filename)}"/>
};


declare function local:unzip($base-collection as xs:string, $zip-filename as xs:string, $action as xs:string) {
    if (not($action = ('list', 'unzip'))) then <error>Invalid action</error>
    else
    let $file := util:binary-doc(concat($base-collection, '/', $zip-filename))
    let $entry-filter := util:function(QName("local", "local:unzip-entry-filter"), 3)
    let $entry-filter-params := ()
    let $entry-data := util:function(QName("local", "local:unzip-docx"), 4)
    let $entry-data-params := 
        (
        if ($action eq 'list') then <param name="list" value="true"/> else (), 
        <param name="base-collection" value="{$base-collection}"/>,
        <param name="zip-filename" value="{$zip-filename}"/>
        )
    let $login := xmldb:login('/db', 'admin', '')
 
    (: recursion :)
    let $unzip := compression:unzip($file, $entry-filter, $entry-filter-params, $entry-data, $entry-data-params)
    return 
        <results action="{$action}">{$unzip}</results>
};

let $collection := concat($style:db-path-to-app, '/unit-tests/data/input')
let $zip-filename := 'hello-world.docx'
let $action := 'unzip' (: valid actions: 'list', 'unzip' :)
return 
    local:unzip($collection, $zip-filename, $action)

