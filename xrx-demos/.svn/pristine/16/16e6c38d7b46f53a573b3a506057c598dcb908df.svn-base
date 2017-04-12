xquery version "1.0";

(: View Item :)

import module namespace style = "http://style.syntactica.com/us-state-hist" at "../../../modules/style.xqm";

let $id := request:get-parameter('id', '')

(: check for required parameters :)
return

if (not($id)) then 
    <error>
        <message>Parameter "id" is missing.  This argument is required for this web service.</message>
    </error>
else
    let $data-collection := '/db/cms/apps/glossary/data'
    return collection($data-collection)/term[id = $id]