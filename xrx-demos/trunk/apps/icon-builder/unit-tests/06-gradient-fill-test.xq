import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";
import module namespace style-svg = "http://danmccreary.com/style-svg" at "../modules/icon-builder.xqm";
declare namespace svg   = "http://www.w3.org/2000/svg";

let $id := request:get-parameter('id', 'alarm-clock-np291')
let $title := 'Icon Wrap Test'

(: check for required parameters :)
return
if (not($id))
    then (
    <error>
        <message>Parameter "id" is missing.  This argument is required for this web service.</message>
    </error>)
    else

let $app-collection := $style:db-path-to-app
let $data-collection := concat($app-collection, '/data')
let $file-path := concat($data-collection, '/', $id, '.svg')
let $input := doc($file-path)/svg:svg
let $output := style-svg:icon-wrap($input)

return
<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" id="Layer_1" x="0px" y="0px" width="100px" height="100px" viewBox="0 0 100 100" enable-background="new 0 0 100 100" xml:space="preserve">
    <desc>Alarm Clock</desc>
    {style-svg:drop-shadow()}
    {style-svg:gradient-fill()}
    <g class="border">
        <rect x="5" y="5" rx="5" width="90" height="90" fill="silver" stroke="gray" stroke-width="1px"/>
    </g>
    <g fill="url(#upper-left-light-source)" transform="scale(.85, .83) translate(15,10)" style="filter:url(#dropshadow)">
        <path d="M6.755,25.72c7.382-9.081,18.004-15.425,30.093-17.245l-5.514-6.871c-2.868-2.967-9.069-1.697-16.868,2.807  C6.667,8.914,2.468,13.648,3.602,17.615L6.755,25.72z"/>
        <path d="M44.03,23.948c-1.658,0-3.002,1.344-3.002,3.002v26.018H15.01c-1.658,0-3.002,1.344-3.002,3.002s1.344,3.002,3.002,3.002  H44.03c1.658,0,3.002-1.344,3.002-3.002V26.95C47.032,25.292,45.688,23.948,44.03,23.948z"/>
        <path d="M81.306,25.72c-7.382-9.081-18.004-15.425-30.093-17.245l5.514-6.871c2.868-2.967,9.069-1.697,16.868,2.807  c7.799,4.503,11.998,9.237,10.864,13.204L81.306,25.72z"/>
        <path d="M44.03,11.939C19.752,11.939,0,31.691,0,55.969C0,80.249,19.752,100,44.03,100s44.03-19.752,44.03-44.031  C88.061,31.691,68.309,11.939,44.03,11.939z M44.03,93.996c-20.968,0-38.026-17.059-38.026-38.026S23.062,17.943,44.03,17.943  s38.026,17.059,38.026,38.026S64.998,93.996,44.03,93.996z"/>
    </g>
    

</svg>