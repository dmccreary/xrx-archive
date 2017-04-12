xquery version "1.0";
import module namespace sequences="http://exist-db.org/xquery/sequences";

declare function local:upper-case($input as xs:string*) as xs:string* {
    upper-case($input)
};

let $f1 := util:function(QName("local","local:upper-case"),1)


let $results := sequences:map(local:upper-case, ("john", "jane"))
return $results
