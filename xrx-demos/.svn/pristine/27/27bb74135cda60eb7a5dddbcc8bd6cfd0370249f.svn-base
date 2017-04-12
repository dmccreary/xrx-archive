xquery version "1.0";

(: note the SVG media type :)
declare option exist:serialize "method=xml media-type=image/svg+xml omit-xml-declaration=yes indent=yes";

let $title := 'Chessboard in SVG'

let $row-count := xs:integer(request:get-parameter('rows', 8))
let $column-count := xs:integer(request:get-parameter('cols', 8))
let $cell-size := xs:integer(request:get-parameter('size', 30))

let $rows := 1 to $row-count

let $columns := 1 to $column-count

return
<svg width="900" height="900" xmlns="http://www.w3.org/2000/svg" style="font-family: Arial,Helvetica,sans-serif;">
   <text x="120" y="30">Rows = {$row-count}</text>
   <text x="220" y="30">Cols = {$column-count}</text>
   <text x="320" y="30">Size = {$cell-size}</text>
   
   <g class="checkboard" transform="translate(0, 20)">
      {for $row in $rows
         return
            for $column in $columns
                let $counter := ($row - 1) * $column-count + $column
                let $x := $cell-size * $column
                let $y := $cell-size * $row
                return
                    (<rect x="{$x}" y="{$y}" width="{$cell-size}" height="{$cell-size}">
                    {if ( ($column + $row) mod 2)
                          then attribute fill {'red'}
                          else attribute fill {'black'}
                     }
                    </rect>,
                    <text x="{$x + $cell-size * .2}" y="{$y + .75 * $cell-size}" fill="white">{$counter}</text>
                    )
      }
    </g>
</svg>