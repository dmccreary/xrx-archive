xquery version "1.0";
declare option exist:serialize "method=xhtml media-type=text/html omit-xml-declaration=yes indent=yes";

(: double the number N times :)
declare function local:double($in as xs:integer) as xs:double {
  if ($in = 1)
    then 1
    else 2 * local:double($in - 1)
};

(: Only display three digits of the significant digits :)
declare function local:format-exp($in as xs:double) as xs:string {
  let $in-as-string := string($in)
  return 
    if (contains($in-as-string, 'E'))
        then
            let $significant-digits := substring-before($in-as-string, 'E')
            let $exponent := substring-after($in-as-string, 'E')
            let $first-four := substring($significant-digits, 1, 4)
            return concat($first-four, 'E', $exponent)
        else
           $in-as-string
};


let $title := 'Chessboard Double Function'

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
      
      <p>If you put one grain of rice on a chessboard and keep doubling it, how many will you
      get on the last square?</p>
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
                    {$counter} =
                    { local:format-exp(local:double($counter)) }
                    </td>
            }
            </tr>
      }
      </table>
   </body>
</html>
