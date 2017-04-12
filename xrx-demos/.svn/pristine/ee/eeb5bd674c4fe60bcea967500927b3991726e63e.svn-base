xquery version "1.0";
declare option exist:serialize "method=xhtml media-type=text/html omit-xml-declaration=yes indent=yes";

let $title := 'Chessboard Sample Program'

let $row-count := 8
let $column-count := 8

(: create a sequence of the numbers from 1 to $row-count 
 (1, 2, 3, 4, ...)
:)
let $rows := 1 to $row-count
 
(: create a sequence of the numbers from 1 to $column-count :)
let $columns := 1 to $column-count

return
<html>
   <head>
      <title>{$title}</title>
      <style type="text/css"><![CDATA[
         body {font-family: Arial,Helvetica,sans-serif;}
         .red {background-color:red; color:white;}
         .black {background-color:black; color:white;}
         td {text-align:center; padding: 3px;}
         /* this takes the white lines out from between the table cells */
         table {border-collapse:collapse;}
      ]]></style>
   </head>
   <body>
      <h1>{$title}</h1>
      <p>A basic chess board using HTML tables where each cell has a cell number.</p>
      <table>
      {for $row in $rows
         return
            <tr>
            {for $column in $columns
                (: this is used to make alternating cells have even/odd numbers :)
                let $counter := ($row - 1) * $column-count + $column    
                return
                    <td>
                    { (: this will conditionally put in a class attribute of red or black :)
                    if (($column + $row) mod 2)
                        then attribute class {'red'}
                        else attribute class {'black'}
                     }
                    {$counter}
                    </td>
            }
            </tr>
      }
      </table>
   </body>
</html>
