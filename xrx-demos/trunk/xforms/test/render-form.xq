declare function local:render-form($doc as node(), $debug as xs:boolean) as node()+ {
    let $options := util:declare-option('exist:serialize', 'method=xhtml media-type=text/xml indent=yes process-xsl-pi=no')
    
    let $debug-pi :=
       if ($debug) then 
            processing-instruction xsltforms-options {'debug="yes"'}
        else ()
    let $pi := processing-instruction xml-stylesheet {concat('type="text/xsl" href="', request:get-context-path(), '/rest', '/db/xforms/xsltforms/xsltforms.xsl"')}
    return ($pi, $debug-pi, $doc)
};

let $file := request:get-parameter('file', 'address.xml')
let $file-path := concat('/db/xforms/test/', $file)
let $doc := doc($file-path)/*
return local:render-form($doc, true())

