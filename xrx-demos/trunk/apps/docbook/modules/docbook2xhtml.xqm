xquery version "1.0";

module namespace docbook2xhtml="http://exist-db.org/docbook2xhtml";

declare namespace db="http://docbook.org/ns/docbook";
declare namespace html="http://www.w3.org/1999/xhtml";
declare namespace xmldb="http://exist-db.org/xquery/xmldb";
declare namespace xf="http://www.w3.org/2002/xforms";

(: designed to store resources shared by two or more documents :)
declare variable $docbook2xhtml:site-resources := '/db/dma/resources';

declare variable $docbook2xhtml:site-images := concat($docbook2xhtml:site-resources, '/images/');
declare variable $docbook2xhtml:site-css := concat($docbook2xhtml:site-resources, '/css/');
declare variable $docbook2xhtml:site-scripts := concat($docbook2xhtml:site-resources, '/scripts/');

(: document-specific resources are stored relative to the rendering output location :)
declare variable $docbook2xhtml:loc-images := 'images/';
declare variable $docbook2xhtml:loc-scripts := 'scripts/';
declare variable $docbook2xhtml:loc-css := 'css/';

declare variable $docbook2xhtml:syntax-highlight := 'yes';
declare variable $docbook2xhtml:include-table-of-contents := 'yes';

declare function docbook2xhtml:dispatch($nodes as node()) as item()* {
    for $node in $nodes
    return 
        typeswitch($node)
            case text() return $node

            case element(article) return docbook2xhtml:html-page($node)
            case element(book) return docbook2xhtml:html-page($node)
            (: case element(topic) return docbook2xhtml:topic($node) :)
            case element(chapter) return docbook2xhtml:chapter($node)
            case element(section) return docbook2xhtml:section($node)
            
            (: front matter :)
            case element(info) return docbook2xhtml:info($node)
            case element(bookinfo) return docbook2xhtml:info($node)
            case element(author) return docbook2xhtml:author($node)
            case element(revhistory) return docbook2xhtml:revhistory($node)

            case element(para) return docbook2xhtml:para($node)
            case element(title) return docbook2xhtml:title($node)
            case element(productname) return docbook2xhtml:productname($node)
            case element(subject) return docbook2xhtml:subject($node)
            case element(listitem) return docbook2xhtml:listitem($node)
            case element(emphasis) return docbook2xhtml:emphasis($node)

            case element(programlisting) return docbook2xhtml:programlisting($node)
            case element(imagedata) return docbook2xhtml:imagedata($node)      
            
            default return (<dispatch/>, docbook2xhtml:passthru($node))
};

declare function docbook2xhtml:passthru($nodes as node()*) as item()* {
    for $node in $nodes/node() return docbook2xhtml:dispatch($node)
};


declare function docbook2xhtml:html-page($node as node()) as element() {
let $title := $node/(info|bookinfo)/title/text()
return
    <html xmlns="http://www.w3.org/1999/xhtml">
       <head>
          <title>{$title}</title>
                <link rel="shortcut icon" href="{$docbook2xhtml:site-images}exist_icon_16x16.ico"/>
                <link rel="icon" href="{$docbook2xhtml:site-images}exist_icon_16x16.png"
                    type="image/png"/>
                <meta http-equiv="Content-Type" content="charset=utf-8"/>
                <script language="Javascript" type="text/javascript" src="{$docbook2xhtml:site-scripts}curvycorners.js"/>
                <link rel="stylesheet" type="text/css" href="{$docbook2xhtml:site-css}docbook.css"/>

                <link rel="stylesheet" type="text/css" href="{$docbook2xhtml:site-css}/style.css"/>

                    
                {if ($docbook2xhtml:syntax-highlight = 'yes')
                then (
                    <script type="text/javascript" src="{$docbook2xhtml:site-scripts}syntax/shCore.js"/>,
                    <script type="text/javascript" src="{$docbook2xhtml:site-scripts}syntax/shBrushCss.js"/>,
                    <script type="text/javascript" src="{$docbook2xhtml:site-scripts}syntax/shBrushJScript.js"/>,
                    <script type="text/javascript" src="{$docbook2xhtml:site-scripts}syntax/shBrushPlain.js"/>,
                    <script type="text/javascript" src="{$docbook2xhtml:site-scripts}syntax/shBrushXml.js"/>,
                    <script type="text/javascript" src="{$docbook2xhtml:site-scripts}syntax/shBrushXQuery.js"/>,
                    
                    <link type="text/css" rel="stylesheet" href="{$docbook2xhtml:site-css}styles/syntax/shCore.css"/>,
                    <link type="text/css" rel="Stylesheet" href="{$docbook2xhtml:site-css}styles/syntax/shThemeDefault.css" id="theme"/>,
                    
                    <script type="text/javascript">
                        SyntaxHighlighter.config.stripBrs = true;
                        SyntaxHighlighter.defaults[ 'auto-links'] = false;
                        SyntaxHighlighter.defaults[ 'wrap-lines'] = false;
                        SyntaxHighlighter.all();
                     </script>
                ) else ()}
                
            </head>
            <body>
                <div class="content">
                    {docbook2xhtml:edit-document-metadata-controls($node)}
                    {docbook2xhtml:front-matter($node)}
                    {docbook2xhtml:passthru($node)}
                    {docbook2xhtml:analytics()}
                </div>
       </body>
    </html>
};

declare function docbook2xhtml:chapter($node as element(chapter)) as element() {
    <div class="chapter">
       {docbook2xhtml:passthru($node)}
    </div>
};

declare function docbook2xhtml:toc($node as node()) as element() {
    <div class="toc">
       <div class="toc-label">Table of Contents</div>
       {for $section at $sec-count in $node/section
        return
        <div class="toc-line">
           {$sec-count} {' '} <a href="#s-{$sec-count}">{$section/title/text()}</a>
           {for $sub-section at $subsec-count in $section/section
            return
            <div class="toc-line">
               {$sec-count}.{$subsec-count} {' '} <a href="#s-{$sec-count}-{$subsec-count}" >{$sub-section/title/text()} </a>
            </div>
           }
        </div>
       }
    </div>
};

declare function docbook2xhtml:sections($node as element(section)) as element() {
let $section-number := count($node/../preceding::section)
let $sub-section-number := count($node/preceding::section)
return
<div class="sections">
       {for $section at $sec-count in $node/section
        return
        <div class="section1">
           {$sec-count} {' '} <a name="s-{$sec-count}">{$section/title/text()}</a>
           {for $sub-section at $subsec-count in $section/section
            return
            <div class="section2">
               {$sec-count}.{$subsec-count} {' '} <a name="ss-{$sec-count}-{$subsec-count}" >{$sub-section/title/text()} </a>
            </div>
           }
        </div>
       }
</div>
};

declare function docbook2xhtml:section($node as element(section)) as element() {
if ( name($node/..) = 'article')
    then

       let $section-number := count($node/preceding-sibling::section) + 1
       return
        <div class="section1">
          <a name="s-{$section-number}"/>
          <h1 class="section1">{$node/title/text()}</h1>
           {docbook2xhtml:passthru($node)}
        </div>

    else 
    let $section-number := count($node/../preceding-sibling::section) + 1
    let $sub-section-number := count($node/preceding-sibling::section) + 1
    return
    <div class="section2">
       <a name="s-{$section-number}-{$sub-section-number}"/>
       <h2 class="section2">{$node/title/text()}</h2>
       {docbook2xhtml:passthru($node)}
    </div>

};

(: we are explicitly putting in titles for each section :)
declare function docbook2xhtml:productname($node as element(productname)) {
  <div class="title">Product name = {$node/text()}</div>
};

(: we are explicitly putting in titles for each section :)
declare function docbook2xhtml:title($node as element(title)) {
  <div class="title">Title = {$node/text()}</div>
};

(: we are explicitly putting in titles for each section :)
declare function docbook2xhtml:subject($node as element(subject)) {
  <div class="subject">Subject = {$node/text()}</div>
};

declare function docbook2xhtml:info($node as node()) {
    ''
};

declare function docbook2xhtml:para($node as element(para)) as element() {
    <p class="para">
       {docbook2xhtml:passthru($node)}
    </p>
};


declare function docbook2xhtml:emphasis($node as element(emphasis)) as element() {
if ($node/@role = 'bold')
   then <b>{docbook2xhtml:passthru($node)}</b>
   else <i>{docbook2xhtml:passthru($node)}</i>
};

declare function docbook2xhtml:programlisting($node as element(programlisting)) as element() {
    <pre class="programlisting">
       {$node/text()}
       {docbook2xhtml:passthru($node)}
    </pre>
};

declare function docbook2xhtml:imagedata($node as element(imagedata)) as element() {
    <img src="{$docbook2xhtml:loc-images}{$node/@fileref}" width="{$node/contentwidth}" alt-text="{$node/@alt-text}" title="{$node/@annotations}"/>
};

declare function docbook2xhtml:analytics() as element() {
    <div class="google-analytics">
    </div>
};

declare function docbook2xhtml:front-matter($node) as element() {
    <div class="front-matter">
       {docbook2xhtml:title($node/bookinfo/title)}
       {docbook2xhtml:productname($node/bookinfo/productname)}
       {docbook2xhtml:subject($node/bookinfo/subject)}
       <div class="article-subtitle">{$node/info/subtitle/text()}</div>
       <div class="version">
       Version: {$node/info/revhistory/revision[last()]/revnumber/text()}
       Date: {$node/info/revhistory/revision[last()]/date/text()}
       </div>
       {docbook2xhtml:authors($node)}
       {docbook2xhtml:revhistory($node/info/revhistory)}
       {docbook2xhtml:toc($node)}
    </div>
};

declare function docbook2xhtml:authors($node) as element() {
    <div class="authors">
       <div class="authors-label">Authors</div>
       {for $author in $node/info/author
          return docbook2xhtml:author($author)
       }
    </div>
};

declare function docbook2xhtml:author($person) as element() {
    <div class="author">
       <span class="personanme">
       {$person/personname/honorific/text()} {' '}
       {$person/personname/firstname/text()} {' '}
       {$person/personname/surname/text()}</span> {', '}
       { if ($person/affiliation/orgname)    
         then <span class="orgname"> {$person/affiliation/orgname/text()}, </span>
         else ()
       }
       <span class="email">{$person/email/text()} {' '}</span>
    </div>
};

declare function docbook2xhtml:revhistory($revhistory) as element() {
    <div class="revhistory">
    <div class="rev-history-label">Revision History</div>
    <table class="rev-history-table">
       <thead>
        <tr>
           <th>#</th>
           <th>Date</th>
           <th>Who</th>
           <th>Description</th>
        </tr>
       </thead>
       <tbody>
       {for $rev in $revhistory/revision
       return
         <tr>
            <td>{$rev/revnumber/text()}</td>
            <td>{$rev/date/text()}</td>
            <td>
            {$rev/authorinitials/text()}
            {$rev//firstname/text()}
            { if ($rev//surname) then ' ' else '' }
            {$rev//surname/text()}
            </td>
            <td>{$rev/revdescription/para/text()}</td>
         </tr>
       }
       </tbody>
    </table>
    </div>
};

declare function docbook2xhtml:back-matter($node) as element() {
    <div class="back-matter">
       {docbook2xhtml:passthru($node)}
    </div>
};

declare function docbook2xhtml:listitem($node) as element() {
    <div class="list">
        {docbook2xhtml:passthru($node)}
    </div>
};

declare function docbook2xhtml:edit-document-metadata-controls($node) {
    <div class="edit-controls">
        <a href="../edit/edit.xq?id={util:document-name($node)}">Edit Document Metadata</a>
    </div>
};
