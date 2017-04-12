xquery version "1.0";

import module namespace style = "http://www.danmccreary.com/xrx" at "../../../modules/style.xqm";
declare namespace xf="http://www.w3.org/2002/xforms";
declare namespace my="http://www.example.com/my";
declare namespace xforms="http://www.w3.org/2002/xforms";
declare namespace ev="http://www.w3.org/2001/xml-events";

declare default element namespace "http://www.w3.org/1999/xhtml";

let $title := 'Itemset Copy Test'

let $model :=
<xf:model>
  <xf:instance id="cone">
    <my:data>
      <my:order/>
    </my:data>
  </xf:instance>

  <xf:instance id="flavors">
    <my:data>
      <my:flavor type="v">
        <my:description>Vanilla</my:description>
      </my:flavor>
      <my:flavor type="s">
        <my:description>Strawberry</my:description>
      </my:flavor>
      <my:flavor type="c">
        <my:description>Chocolate</my:description>
      </my:flavor>
    </my:data>
  </xf:instance>
</xf:model>

let $content :=
<div class="content">
<xf:select ref="instance('cone')/my:order" appearance="full">
  <xf:label>Flavors</xf:label>
  <xf:itemset nodeset="instance('flavors')//my:flavor">
    <xf:label ref="my:description"/>
    <xf:value ref="my:description"/>
  </xf:itemset>
</xf:select>
</div>

return style:assemble-form($title, (), (), $model, $content, true())