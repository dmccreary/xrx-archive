module namespace book = "http://example.com/book";

declare function book:dispatch($node as node()) as item()* {
    typeswitch($node)
        case text() return $node
        case element(bill) return local:bill($node)
        case element(btitle) return local:btitle($node)
        case element(section-id) return local:section-id($node)
        case element(bill-text) return local:bill-text($node)
        case element(strike) return local:strike($node)
        default return local:passthru($node)
};

