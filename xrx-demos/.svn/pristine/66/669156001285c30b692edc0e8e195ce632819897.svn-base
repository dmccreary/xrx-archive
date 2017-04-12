module namespace docbook-to-html = "http://www.example.com/docbook-to-html";

declare namespace docbook ="http://docbook.org/ns/docbook";
declare default element namespace "http://docbook.org/ns/docbook";

declare function docbook-to-html:main($content as node()*) as item()* {
for $node in $content
  return
    typeswitch($node)
        case element(article)
           return <div class="article">{docbook-to-html:main($node/node())}</div>
        case element(section)
           return <div class="section">{docbook-to-html:main($node/node())}</div>
        case element(title)
           return <div class="title"><b>{$node/text()}</b></div>
        case element(para) return <p>{$node/text()}</p>
        default
           return docbook-to-html:main($node/node())
};
