xquery version "1.0";
declare namespace svg="http://www.w3.org/2000/svg";
declare namespace xlink="http://www.w3.org/1999/xlink";

import module namespace style='http://danmccreary.com/style' at '../../../modules/style.xqm';
import module namespace draw-chart = 'http://danmccreary.com/draw-chart' at '../modules/draw-chart-module.xqm';

let $title := 'Draw Bar Chart Test #1'
let $description := 'Draw 24 15-pixel wide bars with 1 pixel spacing in 400 px wide area.'

let $config :=
<config>
   <chart-height>300</chart-height>
   <chart-width>400</chart-width>
   <bar-width>13</bar-width>
   <bar-spacing>3</bar-spacing>
   <bar-color>blue</bar-color>
   <bar-count>24</bar-count>
   <margin-left>8</margin-left>
</config>

let $chart-height := $config/chart-height/text()
let $chart-width := $config/chart-width/text()
let $bar-width := $config/bar-width/text()
let $bar-spacing := $config/bar-spacing/text()
let $bar-count := $config/bar-count/text()
let $margin-left := $config/margin-left/text()

let $content :=
<svg xmlns="http://www.w3.org/2000/svg" height="{$chart-height + 20}" width="{$chart-width}" style="border: solid blue 1px;">
   <text x="4" y="10">{$description}</text>
   {for $bar in (1 to $bar-count)
      let $x := ($bar -1) * ($bar-width + $bar-spacing) + $margin-left
      let $href := concat('view-details.xq?id=', $bar)
      return
         draw-chart:draw-bar($config, util:random($chart-height - 10), $x, string($bar), $href)
   }
</svg>

return style:assemble-chart($title, $content)