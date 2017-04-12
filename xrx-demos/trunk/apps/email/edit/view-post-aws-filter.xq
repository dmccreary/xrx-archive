xquery version "1.0";

let $incomming := request:get-data()

let $outgoing :=
for $element in $incomming//node()
return
   <element> {$element} {replace(name($element), '_', '\.')}</element>

return 
<results>
   <incomming>{$incomming}</incomming>
   <filtered>{$outgoing}</filtered>
</results>