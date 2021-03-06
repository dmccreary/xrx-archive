xquery version "1.0";
declare namespace exist="http://exist.sourceforge.net/NS/exist";
declare option exist:serialize "method=html media-type=text/html indent=yes";

let $collection :=  concat(substring-before(substring-after(request:get-uri(), '/exist/rest'), '/views/'), '/data')

 (: remove the [1] if you want to display more than one defintion :)
(: you can replace it with string-join($term/definition/text()) :)

return
<html>
   <head>
      <title>HTML Table</title>
   </head>
   <body>
   <h1>Terms and Defintions</h1>
      <table border="1">
         <thead>
            <th>Term</th>
            <th>Definition</th>
        </thead>
            <tbody>{
                for $term in subsequence(collection($collection)/term, 1, 30)
                return
                <tr>
                    <td>{$term/name/text()}</td>
                    <td>{$term/definition[1]/text()}</td>
                </tr>
              }</tbody>
      </table>
    </body>
</html>

