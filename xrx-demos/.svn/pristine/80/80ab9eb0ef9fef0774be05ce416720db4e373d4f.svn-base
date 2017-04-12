xquery version "1.0";
module namespace charts = 'http://danmccreary.com/charts';

declare variable $charts:app-db-path := '/db/chase/apps/charts/data';

declare function charts:priority-name-to-number($name as xs:string) as xs:integer {
let $lookup := 
<codes>
    <code>
       <label>high</label>
       <sort-order>5</sort-order>
    </code>
    <code>
       <label>medium</label>
       <sort-order>3</sort-order>
    </code>
    <code>
       <label>low</label>
       <sort-order>1</sort-order>
    </code>
</codes>
 return number($lookup/code[label/text()=$name]/sort-order/text())
};

declare function charts:chart-classifier-value-to-label($name as xs:string) as xs:string {
let $codes := doc(concat($charts:app-db-path, 'code-tables/chart-classifier-codes.xml'))/code-table
 return $codes//item[value/text()=$name]/label/text()
};

declare function charts:chart-id-to-image-path($id as xs:string?) as xs:string? {
   if (not($id))
     then
        'Error: charts:chart-id-to-image-path id must not be null'
     else
        let $image-path := collection($charts:app-db-path)/chart[id/text() = $id]/chart-url/text()
        return
           if (string-length($image-path) > 0)
              then $image-path
              else concat('Error: No chart exists for chart id =', $id)
};

declare function charts:chart-name($id as xs:string?) as xs:string? {
   if (not($id))
     then
        'Error: Chart ID is null'
     else
        let $name := collection($charts:app-db-path)/chart[id/text() = $id]/chart-name/text()
        return
           if (string-length($name) > 0)
              then $name
              else concat('Error: No chart exists for chart id =', $id)
};

(: I originally wrote this to return a boolean but had to change to return true/false strings for debugging :)
declare function charts:chart-has-table($id as xs:string?) as xs:string {
   if (not($id))
     then
        'Error: Chart ID is null'
     else
        let $has-table-indicator := collection($charts:app-db-path)/chart[id/text() = $id]/chart-table-indicator/text()
        return
           if (string-length($has-table-indicator) > 0)
              then if ($has-table-indicator = 'true') then 'true' else 'false'
              else concat('Error: No chart exists for chart id =', $id)
};

(: I originally wrote this to return a boolean but had to change to return true/false strings for debugging :)
declare function charts:chart-has-time-slider($id as xs:string?) as xs:string {
   if (not($id))
     then
        'Error: Chart ID is null'
     else
        let $has-time-slider-indicator := collection($charts:app-db-path)/chart[id/text() = $id]/time-slider-indicator/text()
        return
           if (string-length($has-time-slider-indicator) > 0)
              then if ($has-time-slider-indicator = 'true') then 'true' else 'false'
              else concat('Error: No chart exists for chart id =', $id)
};
         