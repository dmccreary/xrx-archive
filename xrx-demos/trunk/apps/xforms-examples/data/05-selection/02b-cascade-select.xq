xquery version "1.0";

import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";

(: Document namespaces declarations :)

declare namespace xf="http://www.w3.org/2002/xforms";
declare namespace ev="http://www.w3.org/2001/xml-events";
declare namespace xhtml="http://www.w3.org/1999/xhtml";


let $title := 'Select Model'
let $app-collection := $style:db-path-to-app
let $code-table-collection := concat($app-collection, '/code-tables')

let $style :=
<xhtml:style language="text/css">
    <![CDATA[
        @namespace xf url("http://www.w3.org/2002/xforms");
        .block-form xf|label {
            width: 20ex;
        }
        
        /* make sure the select and select1 items don't float to the left */
        xf|select xf|item, xf|select1 xf|item {
            margin-left: 5ex;
        }

        .uri .xforms-value {width: 90ex;}
        .description textarea {
            height: 10ex;
            width:630px;
        }
        .note textarea {
            height: 10ex;
            width:630px;
        }
    ]]>
 </xhtml:style>
 
 let $model :=
 <xf:model>
 
         <xf:instance id="selected-values" xmlns="">
            <data>
               <selected-performance-window>6</selected-performance-window>
               <selected-month></selected-month>
            </data>
         </xf:instance>
 
         <xf:instance id="performance-windows" xmlns="">
            <root>
               <item name="0"/>
               <item name="3"/>
               <item name="6"/>
               <item name="9"/>
               <item name="12"/>
               <item name="18"/>
               <item name="21"/>
            </root>
         </xf:instance>
 
         <xf:instance id="months" xmlns="">
            <root>
               <item name="2010-Jan"/>
               <item name="2010-Feb"/>
               <item name="2010-Mar"/>
               <item name="2010-Apr"/>
               <item name="2010-May"/>
               <item name="2010-Jun"/>
               <item name="2010-Jul"/>
               <item name="2010-Aug"/>
               <item name="2010-Sep"/>
               <item name="2010-Oct"/>
               <item name="2010-Nov"/>
               <item name="2010-Dec"/>
               <item name="2011-Jan"/>
               <item name="2011-Feb"/>
               <item name="2011-Mar"/>
               <item name="2011-Apr"/>
               <item name="2011-May"/>
               <item name="2011-Jun"/>
               <item name="2011-Jul"/>
               <item name="2011-Aug"/>
               <item name="2011-Sep"/>
               <item name="2011-Oct"/>
               <item name="2011-Nov"/>
               <item name="2011-Dec"/>
            </root>
         </xf:instance>
         <xf:bind id="selected-performance-window" nodeset="instance('selected-values')/selected-performance-window"/>
      </xf:model>

let $content :=
<div class="content">
      <p>Test of dependant selection lists.  The starting date and number of dates in the right list depend
      on the value of the left list.</p>
        <table border="1">
          <tr>
             <td style="vertical-align: top!important;">
                <xf:select1 ref="instance('selected-values')/selected-performance-window">
                  <xf:label>Performance Window:</xf:label>
                  <xf:itemset nodeset="instance('performance-windows')/item">
                    <xf:label ref="@name"/>
                    <xf:value ref="@name"/>
                  </xf:itemset>
                </xf:select1>
                </td>
                <td>
                <!-- use appearance="full" to use a radio-button selection list -->
                <xf:select ref="instance('selected-values')/selected-month">
                  <xf:label>Months Before Performance Window:</xf:label>
                  <xf:itemset nodeset="instance('months')/item[position() le (24 - number(instance('selected-values')/selected-performance-window))]">
                    <xf:label ref="@name"/>
                    <xf:value ref="@name"/>
                  </xf:itemset>
                  <xf:hint>Use Control to select many dates.  Use SHIFT to select from selected to end.</xf:hint>
                </xf:select>
                </td>
         </tr>
        </table>
         <xf:output ref="instance('selected-values')/selected-performance-window">
            <xf:label>selected-performance-window: </xf:label>
         </xf:output>
		  <br/>
 
         <xf:output ref="instance('selected-values')/selected-month">
            <xf:label>selected-month: </xf:label>
         </xf:output>
         <!-- [index('rid') gt number(instance('selected-values')/selected-performance-window)] -->
         <h4>Months to include in List</h4>
    	   <xf:repeat id="rid" nodeset="instance('months')/item[position() le (24 - number(instance('selected-values')/selected-performance-window))]">
    	       Month:<xf:output value="./@name"/>
    	   </xf:repeat>
 
</div>

return style:assemble-form($title, (), $style, $model, $content, true())