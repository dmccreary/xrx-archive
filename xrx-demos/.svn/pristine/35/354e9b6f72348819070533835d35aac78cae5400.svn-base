
module namespace util2 = "http://surescripts.com/util2";

(: An Xquery function to create a collection and all the parent collections if they do not exist :)
declare function util2:create-sub-collections($collection-path as xs:string) as xf:string {
    let $collections := tokenize($collection-path, '/')
    
    (: login to the root :)
    return
        if (not(xmldb:login('/db', 'admin', 'admin123')))
        then <error><message>Invalid Login</message></error>
        else
        
        let $token-count := count($collections)
        return
              if ($token-count > 0)
                 then
                    let $current-collection := 
                    if (if (xmldb:collection-available('/db/system/config/db')
                    
                      then ()
                      else xmldb:create-collection('/db/system/config', 'db')
                 else ()
        else false()
};
