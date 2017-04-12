xquery version "1.0";
import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";

(: XQuery to view data elements in HTML :)

let $id := request:get-parameter('id', '')

let $title := concat('View Data Element ', $id)

let $app-collection := $style:db-path-to-app
let $data-collection := concat($app-collection, '/data')

(: Note: we use the data element name as the id :)

let $my-doc := concat($data-collection, '/', $id, '.xml')
let $db-path := substring-after($my-doc, 'xmldb:exist//')


let $my-data-element := collection($data-collection)/DataElement[DataElementName/text() = $id]

    let $data-element-name :=$my-data-element/DataElementName/text()
    let $complex := $my-data-element/DataElementComplexIndicator/text()
    
    let $subclass-of :=  $my-data-element/DataElementSubClassOf/text()
    
    let $namespace := $my-data-element/DataElementNamespaceURI/text()
    let $definition :=$my-data-element/DataElementDefinitionText/text()
    let $object-class :=$my-data-element/DataElementObjectClassName/text()
    let $property :=$my-data-element/DataElementPropertyName/text()
    let $term :=$my-data-element/DataElementRepresentationTerm/text()
    let $source :=$my-data-element/DataElementSourceText/text()
    
    let $approval-status :=$my-data-element/DataElementApprovalStatusCode/text()
    let $assigned-to :=$my-data-element/DataElementOwnerPersonName/text()
    let $approved-by-code :=$my-data-element/ApprovedByCode/text()
    let $approval-date :=$my-data-element/ApprovalDate/text()
    
    let $data-element-indicator :=$my-data-element/DataElementIndicator/text()
    let $data-element-derived-indicator :=$my-data-element/DataElementDerivedIndicator/text()
    let $data-element-derivation-rule-text :=$my-data-element/DataElementDerivationRuleText/text()
    let $data-element-note-text :=$my-data-element/DataElementNoteText/text()
    let $data-element-enumerations-text :=$my-data-element/DataElementEnumerationsText/text()
    let $data-element-validation-rule-text :=$my-data-element/DataElementValidationRulesText/text()
    
    let $enumerated := if ($my-data-element/DataElementEnumeratedIndicator =  'true') 
       then (true())
       else (false())
    let $enums := $my-data-element/EnumeratedValues
    
    let $group-starred-item-indicator :=$my-data-element/GroupStarredItemIndicator/text()
    let $classifier-codes :=string-join($my-data-element/ClassifierCode/text(), ',')
    let $tags := string-join($my-data-element/Tag/text(), ',')

  (: TODO - if namespace prefix is nc then display the NIEM defintion :)
  
 let $content :=
 <div class="content">
 
 collection = {$data-collection}<br/>
 nodes = { $my-data-element//node() } <br/>
 
    <table>
      <tbody>
      
    {if ($complex = 'true')
       then
          (
          <tr>
             <th class="field-label">Subclass of:</th>
             <td><a href="view-data-element.xq?id={$subclass-of}">{$subclass-of}</a></td>
           </tr>
          )
    else
          (
          <tr>
            <th class="field-label">Object Class:</th>
            <td><a href="view-data-element.xq?id={$object-class}">{$object-class}</a></td>
         </tr>,
          <tr>
               <th class="field-label">Property Name:</th>
               <td>{$property}</td>
            </tr>,
            <tr>
               <th class="field-label">Representation Term:</th>
               <td>{$term}</td>
        </tr>
          )
    }
     
    <tr>
       <th class="field-label">Defintion:</th>
       <td>{$definition}</td>
    </tr>
    <tr>
       <th class="field-label">Primary Source:</th>
       <td>{$source}</td>
    </tr>
    
   <tr class="subsection">
        <td colspan="2" align="center">Approval</td>
    </tr>
    <tr>
       <th class="field-label">Approval Status Code:</th>
       <td>{$approval-status}</td>
    </tr>
    
    {if ($assigned-to) then
     <tr>
       <th class="field-label">Assigned To Code:</th>
       <td>{$assigned-to}</td>
    </tr> else ()}
    
    {if ($approved-by-code) then
    <tr>
       <th class="field-label">Approved By Code:</th>
       <td>{$approved-by-code}</td>
    </tr> else ()}
    
    {if ($approval-date) then <tr>
       <th class="field-label">Approval Date:</th>
       <td>{$approval-date}</td>
    </tr> else ()}
    
    <tr class="subsection">
        <td colspan="2" align="center">Classification</td>
    </tr>
    
    {if ($group-starred-item-indicator='true')
    then
    <tr>
       <th class="field-label">Group Starred Indicator:</th>
       <td>{$group-starred-item-indicator}</td>
    </tr> else ()}
    
    {if ($classifier-codes) then
    <tr>
      <th class="field-label">Classification Codes:</th>
      <td>{$classifier-codes}</td>
    </tr> else ()}
    
    {if ($tags) then
    <tr>
      <th class="field-label">Tags:</th>
      <td>{$tags}</td>
    </tr>else ()}
    
    <tr>
      <th class="field-label">Enumerated:</th>
      <td>{$enumerated}</td>
    </tr>
    
    {if ($enumerated)
         then (
              <tr class="subsection">
                <td colspan="2" align="center">Enumerations</td>
            </tr>,
             for $value in $enums/Value
             return
                 <tr>
                    <td>{$value/Code/text()}</td>
                    <td>{$value/ShortDefinitionText/text()}</td>
                </tr>
                )
          else ()
     }
     
         {if ($complex = 'true')
         (: TODO - only display if there is at least one subclass :)
         then (
              <tr class="subsection">
                <td colspan="2" align="center">Subclasses</td>
            </tr>,
             <tr class="subsection">
                <td class="label" align="left">Subclass</td> <td align="left">Definition</td>
            </tr>,
             for $my-subclass in collection($data-collection)/DataElement[DataElementSubClassOf=$data-element-name]
             let $name := $my-subclass/DataElementName/text()
             return
                 <tr>
                    <td><a href="view-data-element.xq?id={$name}">{$name}</a></td>
                    <td>{$my-subclass/DataElementDefinitionText/text()}</td>
                </tr>
                )
          else ()}
          
          
           {
           (: TODO - only display if there is at least one property :)
           if ($complex = 'true') then (
           <tr class="subsection">
                <td colspan="2" align="center">Properties</td>
            </tr>,
             <tr class="subsection">
                <td class="label" align="left">Property Name</td> <td align="left">Definition</td>
            </tr>,
             for $my-property in collection($data-collection)/DataElement[DataElementObjectClassName=$data-element-name]
             let $name := $my-property/DataElementName/text()
             return
                 <tr>
                    <td><a href="view-data-element.xq?id={$name}">{$name}</a></td>
                    <td>{$my-property/DataElementDefinitionText/text()}</td>
                </tr>
                )
          else ()
     }
        <tr class="label">
       <td>Full Path to XML File: </td>
       <td><a href="{$db-path}">{$my-doc}</a></td>
    </tr>
              </tbody>
         </table>
         
         
         <a href="../edit/edit.xq?id={$data-element-name}">Edit (Lock Record)</a>
         <a href="../edit/delete-confirm.xq?id={$data-element-name}">Delete (With Confirmation)</a>
</div>


return style:assemble-page($title, $content)
