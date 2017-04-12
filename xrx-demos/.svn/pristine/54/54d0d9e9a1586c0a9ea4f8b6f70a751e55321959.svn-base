xquery version "1.0";
import module namespace style="http://danmccreary.com/style" at '../../../modules/style.xqm';
import module namespace model = "http://danmccreary.com/model" at '../modules/models-module.xqm';

let $title := 'Models Summary Report'

let $bu := request:get-parameter('bu', 'all')
let $tier := request:get-parameter('tier', 'all')

let $app-collection := $style:db-path-to-app
let $data-collection := concat($app-collection, '/data')


let $business-units :=
   if ($bu = 'all')
      then distinct-values($models//BusinessUnit/text())
      else $bu

let $models :=
    if ($bu = 'all')
       then collection($data-collection)//Model[Tier/text() = '1']
       else collection($data-collection)//Model[Tier/text() = '1'][BusinessUnit/text() = $bu]

let $content :=
<div class="content">
   <style type="text/css"><![CDATA[
      h2 {margin:10 0 0 0;}
      .models-in-business-unit {margin-left: 20px;}
   ]]></style>
   <h1>{$title}</h1>
    Number of Business Units = {count($business-units)}<br/>
    Count = {count($models)}<br/>
    {for $business-unit in $business-units
    let $short-name := substring-after($business-unit, 'Chase ')
    order by $short-name
    return
    <div class="models-in-business-unit">
       <h2>{$short-name}</h2>
       {for $model in $models[BusinessUnit/text() = $business-unit][Tier/text() = '1']
       let $name := $model/Name/text()
       order by $name
        return
           <div>
             <a href="view-item.xq?id={$model/ModelId/text()}">{$name}</a>
           </div>
       }
    </div>
    }    
  
</div>

return style:assemble-page($title, $content)