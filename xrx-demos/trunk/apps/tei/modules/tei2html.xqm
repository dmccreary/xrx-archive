module namespace tei2html="http://xmlopenfoundation.org/tei2html";

declare default function namespace "http://www.w3.org/2005/xpath-functions";
declare default element namespace "http://www.w3.org/1999/xhtml";

declare namespace tei="http://www.tei-c.org/ns/1.0";
declare namespace xmldb="http://exist-db.org/xquery/xmldb";

declare function tei2html:main($content as node()*) as item()* {
    for $node in $content/node()
    return 
        typeswitch($node)
            
            case element(tei:TEI) return tei2html:TEI($node)
            case text() return $node
            case element(tei:speaker) return tei2html:speaker($node)
            case element(tei:sp) return tei2html:sp($node)
            case element(tei:stage) return tei2html:stage($node)
            case element(tei:div) return tei2html:div($node)
            case element(tei:head) return tei2html:head($node)
            
            case element(tei:castList) return tei2html:castList($node)
            case element(tei:castGroup) return tei2html:castGroup($node)
            case element(tei:role) return tei2html:role($node)
            
            default return tei2html:recurse($node)
};

declare function tei2html:recurse($node as node()) as item()* {
  tei2html:main($node)
};

declare function tei2html:TEI($node as element(tei:TEI)) as element() {
    <html>
       <head>
          <title>TEI to HTML</title>
       </head>
       <body>
       {tei2html:recurse($node)}
       </body>
    </html>
};

declare function tei2html:sp($node as element(tei:sp)) as element() {
    <div class="sp">
       {tei2html:recurse($node)}
    </div>
};

declare function tei2html:speaker($node as element(tei:speaker)) as element() {
    <span class="speaker-label">{tei2html:recurse($node)}: </span>
};

declare function tei2html:stage($node as element(tei:stage)) as element() {
    <div class="stage">
       <span class="stage-label">Stage: </span>{tei2html:recurse($node)}
    </div>
};

declare function tei2html:div($node as element(tei:div)) as element() {
    <div class="div">
       {tei2html:recurse($node)}
    </div>
};

declare function tei2html:castList($node as element(tei:castList)) as element() {
    <div class="castlist">
       Castlist: {tei2html:recurse($node)}
    </div>
    
};

declare function tei2html:castGroup($node as element(tei:castGroup)) as element() {
    <div class="castGroup">
       {tei2html:recurse($node)}
    </div>
};

declare function tei2html:role($node as element(tei:role)) as element() {
    <span class="role">
       {tei2html:recurse($node)}
    </span>
};

declare function tei2html:head($node as element(tei:head)) as element() {
    <div class="head">
       {tei2html:recurse($node)}
    </div>
};

