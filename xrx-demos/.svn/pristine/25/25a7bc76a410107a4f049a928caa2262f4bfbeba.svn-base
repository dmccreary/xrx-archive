declare option exist:serialize "method=xml media-type=text/xml omit-xml-declaration=no indent=no";

let $post-data := request:get-data()

let $results := exec($post-data//code/text())

return
<result>
  {$results}
</result>
