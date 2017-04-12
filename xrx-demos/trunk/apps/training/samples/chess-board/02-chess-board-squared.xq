xquery version "1.0";
declare option exist:serialize "method=xhtml media-type=text/html omit-xml-declaration=yes indent=yes";

declare function local:square($in as xs:double) as xs:double {
  $in * $in
};

let $title := 'Checker Power Function'

let $row-count := 8
let $column-count := 8

(: create a sequence of the numbers from 1 to $row-count 
 (1, 2, 3, 4, ...)
:)
let $rows :=
   for $row in (1 to $row-count)
      return $row

(: create a sequence of the numbers from 1 to $column-count :)
let $columns := 
   for $column in (1 to $column-count)
      return $column

return
<html>
   <head>
      <title>{$title}</title>
      <style type="text/css"><![CDATA[
         body {font-family: Arial,Helvetica,sans-serif;}
         .red {background-color:red; color:white;}
         .black {background-color:black; color:white;}
         td {text-align:center; padding: 3px;}
         table {border-collapse:collapse;}
      ]]></style>
   </head>
   <body>
      <h1>{$title}</h1>
      <p>Each square contains the cell number squared.</p>
      <table>
      {for $row in $rows
         return
            <tr>
            {for $column in $columns
                let $counter := ($row - 1) * $column-count + $column    
                return
                    <td>
                    {if (($column + $row) mod 2)
                        then attribute class {'red'}
                        else attribute class {'black'}
                     }
                    {$counter}<sup>2</sup> =
                    {local:square($counter)}
                    </td>
            }
            </tr>
      }
      </table>
   </body>
</html>
