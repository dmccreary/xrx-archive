module namespace tei2html="http://xmlopenfoundation.org/poem2html";

declare default function namespace "http://www.w3.org/2005/xpath-functions";
declare default element namespace "http://www.w3.org/1999/xhtml";

declare namespace tei="http://www.tei-c.org/ns/1.0";
declare namespace xmldb="http://exist-db.org/xquery/xmldb";

declare function tei2html:main($content as node()*) as item()* {
    for $node in $content/node()
    return 
        typeswitch($node)
            
            case element(tei:TEI) return tei2html:TEI($node)
            case element(tei:lg) return tei2html:lg($node)
            case element(tei:l) return tei2html:l($node)
            case text() return $node
            case element(tei:div) return tei2html:div($node)
            case element(tei:head) return tei2html:head($node)
            default return tei2html:recurse($node)
};

declare function tei2html:recurse($node as node()) as item()* {
  tei2html:main($node)
};

declare function tei2html:TEI($node as element(tei:TEI)) as element() {
    <html>
       <head>
          <title>Poem to HTML Transform</title>
       </head>
       <body>
       {tei2html:recurse($node)}
       </body>
    </html>
};

declare function tei2html:lg($node as element(tei:lg)) as element() {
    <div class="lg">
       {tei2html:recurse($node)}
    </div>
};

declare function tei2html:l($node as element(tei:l)) as element() {
    <div class="l">{tei2html:recurse($node)}</div>
};

declare function tei2html:div($node as element(tei:div)) as element() {
    <div class="div">
       {tei2html:recurse($node)}
    </div>
};

declare function tei2html:head($node as element(tei:head)) as element() {
    <div class="head">
       {tei2html:recurse($node)}
    </div>
};

