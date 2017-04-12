xquery version "1.0";

let $collection := '/db/dma/apps/faqs'

let $input-file := concat($collection, '/', 'splitter/input.xml')
let $destination := concat($collection, '/', 'data')

(: the login used must have write access to the collection :)
let $output-collection := xmldb:login($collection, 'admin', 'admin123')
 
return
<SplitResults>{
     for $faq at $count in doc($input-file)/faqs/faq
        (: For brevity we will create a file name with the term name.  Change this to be an ID function if you want :)
        let $question := $faq/question/text()
        let $filename := concat($count, '.xml')
        (: uncomment the following to do the actual store :)
        (: let $store-return := xmldb:store($destination, $filename, $faq) :)
        let $update-status := update insert  <id>{$count}</id> preceding doc(concat($destination, '/', $filename))/faq/faq-category-id[1]
     return
        <faq>
           <question>{$faq/question/text()}</question>
        </faq>
}</SplitResults>
