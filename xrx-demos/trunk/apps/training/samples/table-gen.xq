xquery version "1.0";
declare option exist:serialize "method=xhtml media-type=text/html omit-xml-declaration=yes indent=yes";

let $title := 'Checker board'

let $row-count := 10
let $column-count := 10

let $rows :=
   for $row in (1 to $row-count)
      return $row

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
      <table>
      {for $row in $rows
         return
            <tr>
            {for $column in $columns
                let $counter := ($row - 1) * $column-count + $column    
                return
                    <td>{if (($counter + $row) mod 2)
                          then attribute class {'red'}
                          else attribute class {'black'}
                         }
                    {$counter}</td>
            }
            </tr>
      }
      </table>
   </body>
</html>