xquery version "1.0";

let $data := request:get-data()
let $tokens := tokenize($data, '&amp;')
let $user := substring-after($tokens[1], 'user=')
let $pass := substring-after($tokens[2], 'pass=')
let $return := substring-after($tokens[3], 'return=')
let $unescape-uri := request:unescape-uri($return, 'UTF-8')
let $fix-first-param := replace($unescape-uri, 'xq&amp;', 'xq?')
let $login-success-indicator := xmldb:login("/db/crossflo", $user, $pass)

let $redirect := response:redirect-to(xs:anyURI($fix-first-param))
return <null/>
