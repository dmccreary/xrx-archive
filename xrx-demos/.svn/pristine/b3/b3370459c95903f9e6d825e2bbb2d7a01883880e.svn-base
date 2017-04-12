xquery version "1.0";

let $collection := '/db/apps/faqs/data'

return
<results>{
   for $faq in collection($collection)/faq[not(author)]
      let $id := $faq/id/text()
      let $result := update insert <author>joe</author> into $faq
      return
          <result>
             <id>{$id}</id>
             <insert-result>{$result}</insert-result>
          </result>
}</results>
