xquery version "1.0";

import module namespace style = "http://style.syntactica.com/web" at "../../../modules/style.xqm";
declare namespace xf="http://www.w3.org/2002/xforms";
declare namespace xforms="http://www.w3.org/2002/xforms";
declare namespace ev="http://www.w3.org/2001/xml-events";
declare namespace mods="http://www.loc.gov/mods/v3";

declare default element namespace "http://www.w3.org/1999/xhtml";

let $style :=
<style type="text/css"><![CDATA[
@namespace xforms url(http://www.w3.org/2002/xforms);
html {
        margin: 0;
        padding: 0;
        }

body {
	color: #000000;
	font-family: Verdana, Arial, Helvetica, sans-serif; 
	font-size: 85%;
	margin: 0px;
	padding: 0px;
	text-align: center;
}  

/* ---  Main divs --- */
div#main{
        margin: 0 auto; 
        border: 1px solid #ccc; 
        width: 875px; 
        text-align:left; 
        background-color: #fff;
}

/* --- Banner styles ---*/        
div#header {
        margin: 0 auto;
        padding: 0;
        background-color: #fff;
}

#mainLinks {
        font-size: 78%;
        margin: 10px  5px 2px;
        margin:10px 3px 2px;;
        padding: 0;
}

#mainLinks a{
        text-decoration: none;}
        
#banner {
        display:block;
        position:relative;
        float:left;
        clear:both;
        height: 60px;
        overflow:hidden;
        border-top: 1px solid #ccc;
        background-color:white;
        margin: 0;
        padding:0;
}
#banner h1{
        display: block;
        width: 600px;
        height: 60px;
        font-weight:100;
        text-indent: 80px;
        font-size: 20px;
        margin: 0;
        padding: 20px;
        background: white url("/styles/images/logo.gif") no-repeat;
}

#banner h1 a {
    text-decoration:none;
    color: gray;
}
#banner h1 a span{
        padding-top: 20px;
}

/* --- Main Nav---*/
 
 #menu {
         clear:both;
         position:relative;
         height: 28px;
         margin:0;
         padding:0;
         background-color:#186647;
         border-bottom: 5px solid #99cc33;
         text-align:left;
 }
 
 #menu ul {
         display:block;
         padding: 5px; 
         margin: 0; 
 }
 
#menu li {
        display:inline;
        overflow:hidden;
        color: white;
        margin: 7px 0 7px 0;
        list-style-type:none;
        padding-right: 8px;
        padding-left: 8px;
        border-right: 2px dotted #ffffff;
}

#menu a:link {
	color: #ffffff;
	text-decoration: none;
}
#menu a:visited {
	color: #ffffff;
	text-decoration: none;	
}
#menu a:hover {
	color: #c25e0d;
	text-decoration: none;	
} 

#formInfo {
    margin-top: 25px; 
    margin-left: 25px; 
    margin-right: 25px;
    margin-bottom: 20px; 
    padding: 10px;
    display:table; 
    width:800px;
    border-bottom: 2px solid #ccc;
    border-top: 2px solid #ccc;
    }

#formInfo .thumbnail {display:table-cell; margin:4px; padding-left:10px; padding-right: 8px; width: 110px;}

#formInfo .left {display:table-cell; margin: 5px 10px; padding-top: 10px; padding-left:10px; vertical-align:top;}

h2 {
        color: #981B1E;
        font-size: 105%;
        margin: 0;
        padding: 18px 8px 8px 8px;
}
/*-----Xforms controls-------*/

xforms|textarea textarea {
        width: 500px; 
        height: 100px; 
        margin: 8px 25px;
        }

p {margin:0; padding: 2px;}
/*p.item {display:table-row;}*/

xforms|input.attribute input
{
  /* display:table-cell;*/
    vertical-align: top;
    width: 75px;
    padding: .2em;
    margin: 0px 0px 4px 4px;
    border: 1px solid #333333;
}

xforms|input input
{
   /*display:table-cell;*/
    vertical-align: top;
    width: 175px;
    padding: .2em;
    margin: 0px 0px 4px 4px;
    border: 1px solid #333333;
}

p.date xforms|input input {
    width: 125px;
    padding: .2em;
    margin: 0px 0px 4px 4px;
    border: 1px solid #333333;
}

p.longItem xforms|input input {
    width: 425px;
    padding: .2em;
    margin: 0px 0px 4px 4px;
    border: 1px solid #333333;
}

xforms|input label
{
    /*display:table-cell;*/
    vertical-align: top;
    width: 200px;
    padding: .3em;
    margin: 0px 0px 4px 4px;
    overflow:hidden;
}

xforms|output label
{font-size:90%; font-weight:bold; color: #444;}
xforms|output.item
{
    display: block;
    margin: 4px;
}

div.section xforms|trigger label {color:blue;}
h4 {color: #666666; margin: 4px; margin-bottom:0px; padding:0;}

fieldset {background-color:#fff; margin: 2px 8px;}
legend{font-weight:bold;}
.section{
     display: table; 
     width:775px;
     border: 1px solid #ccc;
}
.date{
     border: 1px solid #ccc;
}

.status {margin: 5px 5px 5px 475px;}
.right {margin: 5px 5px 5px 550px;}
p.thumbnail {display:table-cell; margin:1px; padding: 4px; width: 210px;}
.section div.left {display:table-cell; margin:1px; padding: 8px; width: 600px; vertical-align:top;}
.deleteSection {display:table-cell; background-color:#eee; width: 20px; clear:both; margin:1px; padding:1px;}

/*---Optional Elements styles---*/
dl.optionalElements {
     display:table-cell;
     vertical-align:top;
     width: 175px;
     margin: 0px;
     background-color: #fff;
     border-left: 1px solid #ccc
 }
dl.optionalElements dt{
    font-weight:bold;
    border-bottom: 1px solid #ccc;
    padding: 5px;
}
dl.optionalElements dd {
    color: blue;
    font-size: 85%;
    padding: 2px 8px;
    margin:0;
}

br.clear {clear:both;}
#tabs {
    margin-top: -15px; 
    margin-left: 25px; 
    margin-right: 25px;
    margin-bottom: 0px; 
    padding: 10px;
    display:table; 
    width:800px;
    border-bottom: 2px solid #ccc;
    }
   
strong {font-size:90%; font-weight:bold; color: #444}    
h3 {font-size: 90%; font-weight: bold; margin: 0 10px;}

#case1 {border: 2px solid #99cc33; margin:0;}
#case1 h3 {font-size: 105%; font-weight:bold; margin: 0; color:#336600; padding: 8px 10px;}
#case1 legend {font-size: 95%; font-weight:bold; margin: 0; color:#336600; padding: 8px 10px;}
#case1 .optionalElements dt {font-size: 95%; font-weight:bold; margin: 0; color: #336600; padding: 8px 10px; background-color: #DDEFAB;} 
#case1 .lookup h3 {font-size: 95%; color:#336600; padding: 8px 10px; background-color: #DDEFAB;} 
.lookup {float:none; clear:both: display:block; border: 1px solid #ccc;}

#case2 {border: 2px solid #F2A151; margin:0;}
#case2 h3 {font-size: 105%; font-weight:bold; margin: 0; color:#CC6600; padding: 8px; 10px;}
#case2 legend {font-size: 95%; font-weight:bold; margin: 0; color:#CC6600; padding: 8px; 10px;}
#case2 .optionalElements dt {font-size: 95%; font-weight:bold; margin: 0; color:#CC6600; padding: 8px; 10px; 
background-color: #FFF1D7;}
#case2 .lookup h3 {font-size: 95%; font-weight:bold; margin: 0; color:#CC6600; padding: 8px; 10px; 
background-color: #FFF1D7;}

#case3 {border: 2px solid #B5A9A5; margin:0; } 
#case3 h3 {font-size: 105%; font-weight:bold; margin: 0; color:#5E476D; padding: 8px; 10px;}
#case3 legend {font-size: 95%; font-weight:bold; margin: 0; color:#5E476D; padding: 8px; 10px;}
#case3 .optionalElements dt {font-size: 95%; font-weight:bold; margin: 0; color:#5E476D; padding: 8px; 10px; 
background-color: #E3DDDB;}
#case3 .lookup h3 {font-size: 95%; font-weight:bold; margin: 0; color:#5E476D; padding: 8px; 10px; 
background-color: #E3DDDB;}

#case4 {border: 2px solid #ADC9BC; margin:0;}
#case4 h3 {font-size: 105%; font-weight:bold; margin: 0; color:#336666; padding: 8px; 10px;}
#case4 legend {font-size: 95%; font-weight:bold; margin: 0; color:#336666; padding: 8px; 10px;}
#case4 .optionalElements dt {font-size: 95%; font-weight:bold; margin: 0; color:#336666; padding: 8px; 10px; 
background-color: #FFFEDE;}
#case4 .lookup h3 {font-size: 95%; font-weight:bold; margin: 0; color:#336666; padding: 8px; 10px; 
background-color: #FFFEDE;}

.lookup p {margin: 10px; padding 10px;}


#tab1{ font-size: 95%; font-weight:bold; margin: 0; color:#336600; padding: 0;}
#tab2{ font-size: 95%; font-weight:bold; margin: 0; color:#CC6600; padding: 0;}     
#tab3{ font-size: 95%; font-weight:bold; margin: 0; color:#5E476D; padding: 0;}
#tab4{ font-size: 95%; font-weight:bold; margin: 0; color:#336666; padding: 0;}
#tab5{ font-size: 95%; font-weight:bold; margin: 0; color:#666666; padding: 0;}
       
a img {border: none;}        
.selectSubject {display:block; clear:both; width: 800px; margin: 5px; border: 1px solid #ccc; background-color:#eee;}        
xforms|switch {
    margin: 0px 15px; 
    padding: 10px;
    display:block; 
    width:825px;
}
xforms|select {display:block; clear:both; width: 800px;}
xforms|select xforms|item {float:left; clear:none; width: 250px; padding-right: 5px;}
]]></style>

let $model :=
        <xforms:model>
        
            <!-- 
                The Working metadata instance. This instance can be dynamically 
                generated or pulled in using the src attribute ex: <xforms:instance id="metadata" src="filename.xml" />. 
                The src attribute appears to be a little buggy with the firefox extension, as of 2008-02-27
            -->
            <xforms:instance id="metadata">
                <mods:mods xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:mods="http://www.loc.gov/mods/v3" version="3.0" xsi:schemaLocation="http://www.loc.gov/mods/v3 http://www.loc.gov/standards/mods/v3/mods-3-0.xsd">

                    <mods:identifier type="local">mcalA01F01i01</mods:identifier>
                    <mods:titleInfo>
                        <mods:title>A.D. Pease Grain Co.</mods:title>
                    </mods:titleInfo>
                    <mods:name type="personal" authority="lcsh" ID="n94044990">
                        <mods:namePart>McAllister, L. L. (Louis L.)</mods:namePart>
                        <mods:namePart type="date">1877-1963</mods:namePart>

                        <mods:role>
                            <mods:roleTerm authority="marcrelator" type="code">pht</mods:roleTerm>
                            <mods:roleTerm authority="marcrelator" type="text">Photographer</mods:roleTerm>
                        </mods:role>
                    </mods:name>
                    <mods:originInfo>
                        <mods:dateCaptured keyDate="yes">2007-10-04T00:00:00</mods:dateCaptured>

                        <mods:publisher>University of Vermont, Bailey/Howe Library, Special
                            Collections</mods:publisher>
                    </mods:originInfo>
                    <mods:typeOfResource>still image</mods:typeOfResource>
                    <mods:genre authority="aat">photographs</mods:genre>
                    <mods:genre authority="aat">black-and-white photographs</mods:genre>
                    <mods:physicalDescription>
                        <mods:internetMediaType>image/tiff</mods:internetMediaType>

                        <mods:extent>1 image</mods:extent>
                        <mods:digitalOrigin>reformatted digital</mods:digitalOrigin>
                        <mods:note>Photographs/Color: 24 bits; 600 ppi</mods:note>
                    </mods:physicalDescription>
                    <mods:relatedItem type="host">
                        <mods:titleInfo ID="mcallister">
                            <mods:title>Louis L. McAllister Photographs</mods:title>

                        </mods:titleInfo>
                    </mods:relatedItem>
                    <mods:relatedItem type="original">
                        <mods:originInfo>
                            <mods:dateCreated keyDate="yes">undated</mods:dateCreated>
                        </mods:originInfo>
                        <mods:note>Louis L. McAllister Photographs, Box A1, Folder 1, Item
                        1</mods:note>
                    </mods:relatedItem>

                    <mods:abstract>A photograph of the A. D. Pease Grain Co.</mods:abstract>
                    <mods:subject xlink:href="http://cdi.uvm.edu/authorities/sh85017769">
                        <mods:topic authority="lcsh">Buildings</mods:topic>
                    </mods:subject>
                    <mods:subject xlink:href="http://cdi.uvm.edu/authorities/ln0002">
                        <mods:name type="corporate" authority="local">
                            <mods:namePart>A.D. Pease Grain Co.</mods:namePart>

                        </mods:name>
                    </mods:subject>
                    <mods:accessCondition type="useAndReproduction" xlink:href="http://cdi.uvm.edu/rights/">For usage rights related to this
                        resource please visit: http://cdi.uvm.edu/rights/</mods:accessCondition>
                </mods:mods>
            </xforms:instance>
            <!-- 
                  Template of complete MODS element set. 
                  This template will be used to populate the working instance with empty, 
                  well formed nodes when items are selected from the "Optional Fields" menu 
              -->
            <xforms:instance id="template">
                <mods:mods xmlns:mods="http://www.loc.gov/mods/v3" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.loc.gov/mods/v3 http://www.loc.gov/standards/mods/v3/mods-3-0.xsd">

                    <mods:titleInfo type="" authority="" displayLabel="">
                        <mods:nonSort/>
                        <mods:title/>
                        <mods:subTitle/>
                        <mods:partName/>
                        <mods:partNumber/>
                    </mods:titleInfo>
                    <mods:name type="" authority="">
                        <mods:namePart type=""/>

                        <mods:namePart type="date"/>
                        <mods:role>
                            <mods:roleTerm authority="marcrelator" type="text"/>
                        </mods:role>
                    </mods:name>
                    <mods:typeOfResource collection="yes" manuscript="yes"/>
                    <mods:genre authority=""/>
                    <mods:originInfo>
                        <mods:place>

                            <mods:placeTerm type="text"/>
                        </mods:place>
                        <mods:place>
                            <mods:placeTerm type="text"/>
                            <mods:placeTerm authority="" type="code"/>
                        </mods:place>
                        <mods:publisher/>
                        <mods:dateIssued encoding="w3cdtf"/>
                        <mods:dateIssued encoding="w3cdtf" point=""/>

                        <mods:dateIssued encoding="w3cdtf" qualifier="" point=""/>
                        <mods:dateCaptured encoding="w3cdtf"/>
                        <mods:dateCaptured encoding="w3cdtf" point=""/>
                        <mods:dateCaptured encoding="w3cdtf" qualifier="" point=""/>
                        <mods:dateCreated encoding="w3cdtf"/>
                        <mods:dateCreated encoding="w3cdtf" point=""/>
                        <mods:dateCreated encoding="w3cdtf" qualifier="" point=""/>
                        <mods:copyrightDate encoding="w3cdtf"/>
                        <mods:copyrightDate encoding="w3cdtf" point=""/>

                        <mods:copyrightDate encoding="w3cdtf" qualifier="" point=""/>
                        <mods:dateOther encoding="w3cdtf"/>
                        <mods:dateOther encoding="w3cdtf" point=""/>
                        <mods:dateOther encoding="w3cdtf" qualifier="" point=""/>
                        <mods:edition/>
                        <mods:issuance/>
                        <mods:frequency/>
                    </mods:originInfo>
                    <mods:language>

                        <mods:languageTerm type="text"/>
                        <mods:languageTerm authority="iso639-2b" type="code"/>
                    </mods:language>
                    <mods:physicalDescription>
                        <mods:form authority=""/>
                        <mods:extent/>
                        <mods:internetMediaType/>
                        <mods:reformattingQuality/>
                        <mods:digitalOrigin/>

                        <mods:note/>
                    </mods:physicalDescription>
                    <mods:abstract displayLabel="" type=""/>
                    <mods:note type="" displayLabel=""/>
                    <mods:subject authority="">
                        <mods:topic/>
                        <mods:topic/>
                        <mods:geographic/>
                    </mods:subject>

                    <mods:classification authority=""/>
                    <mods:relatedItem displayLabel="" type="" ID="">
                        <mods:titleInfo>
                            <mods:title/>
                        </mods:titleInfo>
                        <mods:note/>
                    </mods:relatedItem>
                    <mods:identifier type="" invalid="yes" displayLabel=""/>
                    <mods:location>

                        <mods:physicalLocation/>
                        <mods:physicalLocation authority=""/>
                        <mods:url access="" usage="prmary display" displayLabel=""/>
                    </mods:location>
                    <mods:accessCondition type="" displayLabel=""/>
                    <!-- part, extension -->
                    <mods:recordInfo>
                        <mods:recordContentSource authority=""/>
                        <mods:recordCreationDate encoding="w3cdtf"/>

                        <mods:recordCreationDate encoding="w3cdtf" point=""/>
                        <mods:recordCreationDate encoding="w3cdtf" qualifier="" point=""/>
                        <mods:recordChangeDate encoding="w3cdtf"/>
                        <mods:recordChangeDate encoding="w3cdtf" point=""/>
                        <mods:recordChangeDate encoding="w3cdtf" qualifier="" point=""/>
                        <mods:recordIdentifier/>
                        <mods:languageOfCataloging>
                            <mods:languageTerm type="text"/>
                            <mods:languageTerm authority="iso639-2b" type="code"/>

                        </mods:languageOfCataloging>
                        <mods:recordOrigin/>
                    </mods:recordInfo>
                </mods:mods>

            </xforms:instance>
            <!-- 
                 A basic MODS template, allowing for the creation of the most simple elements/nodes. 
                 Nodes can be extended using the "Optional Fields" menu, which draws from the template instance
                 Change this template to match the minimum specification for your institution.
             -->
            <xforms:instance id="basic">
                <mods:mods xmlns:mods="http://www.loc.gov/mods/v3" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.loc.gov/mods/v3 http://www.loc.gov/standards/mods/v3/mods-3-0.xsd">

                    <mods:titleInfo>
                        <mods:title/>
                    </mods:titleInfo>
                    <mods:titleInfo type="">
                        <mods:title/>
                    </mods:titleInfo>
                    <mods:name type="" authority="">
                        <mods:namePart type="" authority=""/>
                        <mods:role>

                            <mods:roleTerm authority="marcrelator" type="text"/>
                        </mods:role>
                    </mods:name>
                    <mods:typeOfResource/>
                    <mods:genre authority="marcgt"/>
                    <mods:originInfo>
                        <mods:dateCreated encoding="w3cdtf" keydate="yes"/>
                    </mods:originInfo>
                    <mods:language>

                        <mods:languageTerm type="text"/>
                    </mods:language>
                    <mods:physicalDescription>
                        <mods:internetMediaType/>
                        <mods:digitalOrigin/>
                    </mods:physicalDescription>
                    <mods:abstract/>
                    <mods:note type=""/>
                    <mods:subject authority="lcsh">

                        <mods:topic/>
                        <mods:topic/>
                        <mods:geographic/>
                    </mods:subject>
                    <mods:classification authority=""/>
                    <mods:relatedItem type="">
                        <mods:titleInfo>
                            <mods:title/>
                        </mods:titleInfo>

                    </mods:relatedItem>
                    <mods:identifier type=""/>
                    <mods:location>
                        <mods:url/>
                    </mods:location>
                    <mods:accessCondition type=""/>
                    <!-- part, extension -->
                    <mods:recordInfo>
                        <mods:recordContentSource/>

                        <mods:languageOfCataloging>
                            <mods:languageTerm type="text"/>
                        </mods:languageOfCataloging>
                        <mods:recordOrigin/>
                    </mods:recordInfo>
                </mods:mods>
            </xforms:instance>
            <xforms:instance id="genre">
                <bh:genreList xmlns:bh="http://cdi.uvm.edu/ns/bh">

                    <bh:list id="marcgt" authority="MARC genre terms">
                        <bh:item>abstract or summary</bh:item>

                        <bh:item>art original</bh:item>
                        <bh:item>art reproduction</bh:item>
                        <bh:item>atlas</bh:item>
                        <bh:item>autobiography</bh:item>

                        <bh:item>bibliography</bh:item>
                        <bh:item>biography</bh:item>

                        <bh:item>book</bh:item>
                        <bh:item>catalog</bh:item>
                        <bh:item>chart</bh:item>
                        <bh:item>comic strip</bh:item>

                        <bh:item>conference publication</bh:item>
                        <bh:item>database</bh:item>

                        <bh:item>dictionary</bh:item>
                        <bh:item>diorama</bh:item>
                        <bh:item>directory</bh:item>
                        <bh:item>discography</bh:item>

                        <bh:item>drama</bh:item>
                        <bh:item>encyclopedia</bh:item>

                        <bh:item>essay</bh:item>
                        <bh:item>festschrift</bh:item>
                        <bh:item>fiction</bh:item>
                        <bh:item>filmography</bh:item>

                        <bh:item>filmstrip</bh:item>
                        <bh:item>finding aid</bh:item>

                        <bh:item>flash card</bh:item>
                        <bh:item>folktale</bh:item>
                        <bh:item>font</bh:item>
                        <bh:item>game</bh:item>

                        <bh:item>government publication</bh:item>
                        <bh:item>graphic</bh:item>

                        <bh:item>globe</bh:item>
                        <bh:item>handbook</bh:item>
                        <bh:item>history</bh:item>
                        <bh:item>humor, satire</bh:item>

                        <bh:item>index</bh:item>
                        <bh:item>instruction</bh:item>

                        <bh:item>interview</bh:item>
                        <bh:item>kit</bh:item>
                        <bh:item>language instruction</bh:item>
                        <bh:item>law report or digest</bh:item>

                        <bh:item>legal article</bh:item>
                        <bh:item>legal case and case notes</bh:item>

                        <bh:item>legislation</bh:item>
                        <bh:item>letter</bh:item>
                        <bh:item>loose-leaf</bh:item>
                        <bh:item>map</bh:item>

                        <bh:item>memoir</bh:item>
                        <bh:item>microscope slide</bh:item>

                        <bh:item>model</bh:item>
                        <bh:item>motion picture</bh:item>
                        <bh:item>multivolume monograph</bh:item>
                        <bh:item>newspaper</bh:item>

                        <bh:item>novel</bh:item>
                        <bh:item>numeric data</bh:item>

                        <bh:item>online system or service</bh:item>
                        <bh:item>patent</bh:item>
                        <bh:item>periodical</bh:item>
                        <bh:item>picture</bh:item>

                        <bh:item>poetry</bh:item>
                        <bh:item>programmed text</bh:item>

                        <bh:item>realia</bh:item>
                        <bh:item>rehearsal</bh:item>
                        <bh:item>remote sensing image</bh:item>
                        <bh:item>reporting</bh:item>

                        <bh:item>review</bh:item>
                        <bh:item>series</bh:item>

                        <bh:item>short story</bh:item>
                        <bh:item>slide</bh:item>
                        <bh:item>sound</bh:item>
                        <bh:item>speech</bh:item>

                        <bh:item>statistics</bh:item>
                        <bh:item>survey of literature</bh:item>

                        <bh:item>technical drawing</bh:item>
                        <bh:item>technical report</bh:item>
                        <bh:item>theses</bh:item>
                        <bh:item>toy</bh:item>

                        <bh:item>transparency</bh:item>
                        <bh:item>treaty</bh:item>

                        <bh:item>videorecording</bh:item>
                        <bh:item>web site</bh:item>
                    </bh:list>
                    <bh:list id="dct" authority="Dublin Core">

                        <bh:item>Collection</bh:item>
                        <bh:item>Dataset</bh:item>
                        <bh:item>Event</bh:item>

                        <bh:item>Image</bh:item>
                        <bh:item>Interactive Resource</bh:item>
                        <bh:item>Moving Image</bh:item>

                        <bh:item>Physical Object</bh:item>
                        <bh:item>Service</bh:item>
                        <bh:item>Software</bh:item>

                        <bh:item>Sound</bh:item>
                        <bh:item>Still Image</bh:item>
                        <bh:item>Text</bh:item>

                    </bh:list>
                    <bh:list id="aat" authority="Art and Architecture Thesaurus">
                        <bh:item>photographs</bh:item>
                        <bh:item>black-and-white photographs</bh:item>

                        <bh:item>engravings (prints)</bh:item>
                    </bh:list>
                </bh:genreList>

            </xforms:instance>
            <!-- 
                A shortened version of the MARC Relator Codes, 
                full list can be retrieved via the getRoles submission button  
            -->
            <xforms:instance id="roleShort">
                <mods:mods>
                    <mods:role>
                        <mods:roleTerm authority="marcrelator" type="code">art</mods:roleTerm>
                        <mods:roleTerm authority="marcrelator" type="text">Artist</mods:roleTerm>
                    </mods:role>

                    <mods:role>
                        <mods:roleTerm authority="marcrelator" type="code">aut</mods:roleTerm>
                        <mods:roleTerm authority="marcrelator" type="text">Author</mods:roleTerm>
                    </mods:role>
                    <mods:role>
                        <mods:roleTerm authority="marcrelator" type="code">cmp</mods:roleTerm>
                        <mods:roleTerm authority="marcrelator" type="text">Composer</mods:roleTerm>

                    </mods:role>
                    <mods:role>
                        <mods:roleTerm authority="marcrelator" type="code">cre</mods:roleTerm>
                        <mods:roleTerm authority="marcrelator" type="text">Creator</mods:roleTerm>
                    </mods:role>
                    <mods:role>
                        <mods:roleTerm authority="marcrelator" type="code">crp</mods:roleTerm>

                        <mods:roleTerm authority="marcrelator" type="text">Correspondent</mods:roleTerm>
                    </mods:role>
                    <mods:role>
                        <mods:roleTerm authority="marcrelator" type="code">ctb</mods:roleTerm>
                        <mods:roleTerm authority="marcrelator" type="text">Contributor</mods:roleTerm>
                    </mods:role>
                    <mods:role>

                        <mods:roleTerm authority="marcrelator" type="code">ctg</mods:roleTerm>
                        <mods:roleTerm authority="marcrelator" type="text">Cartographer</mods:roleTerm>
                    </mods:role>
                    <mods:role>
                        <mods:roleTerm authority="marcrelator" type="code">edt</mods:roleTerm>
                        <mods:roleTerm authority="marcrelator" type="text">Editor</mods:roleTerm>
                    </mods:role>

                    <mods:role>
                        <mods:roleTerm authority="marcrelator" type="code">pht</mods:roleTerm>
                        <mods:roleTerm authority="marcrelator" type="text">Photographer</mods:roleTerm>
                    </mods:role>
                    <mods:role>
                        <mods:roleTerm authority="marcrelator" type="code">rcp</mods:roleTerm>
                        <mods:roleTerm authority="marcrelator" type="text">Recipient</mods:roleTerm>

                    </mods:role>
                </mods:mods>
            </xforms:instance>
            <!-- 
                Used by the get-name and get-sugest function to look up names and subjects in UVM's 
                controlled vocabulary. This function executes an xquery that looks up MADS records.
                The response and subject response instances have been prepopulated with data for this example. 
                To get this function working you will need to have a lookup script that will bring back XML formated
                as shown in the examples.
            -->
            <xforms:instance id="requestName">
                <query xmlns="">
                    <term/>
                </query>
            </xforms:instance>

            <xforms:instance id="requestSubject">
                <query xmlns="">
                    <term/>
                </query>
            </xforms:instance>
            <xforms:instance id="response">
                <temp>
                    <record id="nr93005560.mads.xml">
                        <name xmlns="http://www.loc.gov/mods/v3" type="personal" authority="naf">

                            <namePart>Allen, Heman</namePart>
                            <namePart type="date">1779-1852</namePart>
                        </name>
                    </record>
                    <record id="n86013628.mads.xml">
                        <name xmlns="http://www.loc.gov/mods/v3" type="personal" authority="naf">
                            <namePart>Ashburton, Alexander Baring</namePart>

                            <namePart type="termsOfAddress">Baron</namePart>
                            <namePart type="date">1774-1848</namePart>
                        </name>
                    </record>
                </temp>
            </xforms:instance>
            <xforms:instance id="subjectResponse">
                <temp>

                    <record id="sh85002351.mads.xml">
                        <subject xmlns="http://www.loc.gov/mods/v3">
                            <topic authority="lcsh">Agricultural laws and legislation</topic>
                            <geographic>United States</geographic>
                        </subject>
                    </record>
                    <record id="sh85026398.mads.xml">

                        <subject xmlns="http://www.loc.gov/mods/v3">
                            <topic authority="lcsh">Civil service</topic>
                            <geographic>United States</geographic>
                        </subject>
                    </record>
                </temp>
            </xforms:instance>
            <xforms:instance id="subjects">

                <dummy xmlns="">
                    <subject/>
                </dummy>
            </xforms:instance>
            <xforms:instance id="names">
                <dummy xmlns="">
                    <nameSuggest/>
                </dummy>
            </xforms:instance>

            <xforms:bind id="titleType" nodeset="instance('metadata')/mods:titleInfo/@type" relevant="instance('metadata')/mods:titleInfo[position() &gt; 1]"/>
            <xforms:bind nodeset="instance('metadata')/mods:titleInfo/@authority" relevant="instance('metadata')/mods:titleInfo[@type = 'uniform']"/>
            <xforms:submission id="get-suggest" action="http://cdi2.uvm.edu/exist/processing/subjectSuggest.xql" separator="&amp;" ref="instance('requestSubject')" method="get" replace="instance" instance="subjectResponse"/>
            <xforms:submission id="get-name" action="http://cdi2.uvm.edu/exist/xquery/nameSuggest.xql" separator="&amp;" ref="instance('requestName')" method="get" replace="instance" instance="response"/>
            <xforms:submission id="submit" method="put" replace="none" action="metadata.xml">
                <xforms:action ev:event="xforms-submit-done" ev:observer="submit">
                    <xforms:message level="modal">Task successfully requested.</xforms:message>
                    <xforms:refresh/>

                </xforms:action>
                <xforms:action ev:event="xforms-submit-error" ev:observer="submit">
                    <xforms:message level="modal">Error requesting task.</xforms:message>
                    <xforms:refresh/>
                </xforms:action>
            </xforms:submission>
            <xforms:submission id="submitNames" method="put" replace="instance" instance="subjects" action="names.xml" ref="instance('subjects')"/>
            <xforms:submission id="getRoles" method="get" replace="instance" instance="roleShort" action="roles.xml"/>

        </xforms:model>

let $content :=
<div class="content">
        <div id="main">
            <!-- Optional Header Information  -->
            <div id="header">
                <div id="banner">
                    <h1>

                        <a href="#">
                            <span>MODS Metadata Processing Interface</span>
                        </a>
                    </h1>
                </div>
                <br class="clear"/>
            </div>
            <!-- Record Summary, customizble or removable -->

            <div id="formInfo">
                <div class="thumbnail">
                    <img src="http://cdi.uvm.edu/archives/mcallister/mcalA01F11i18-thumb.jpg"/>
                </div>
                <div class="left">
                    <p>
                        <xforms:output ref="instance('metadata')//mods:identifier">
                            <xforms:label>Record ID: </xforms:label>

                        </xforms:output>
                    </p>
                    <p>
                        <xforms:output id="titleDisplay" ref="instance('metadata')//mods:titleInfo/mods:title" value="if(. = ' ' ,'New Record')">
                            <xforms:label>Title: </xforms:label>
                        </xforms:output>
                    </p>
                    <p>

                        <xforms:output ref="instance('metadata')//mods:name/mods:namePart[not(@type='date')]">
                            <xforms:label>Name: </xforms:label>
                        </xforms:output>
                        <xforms:output ref="instance('metadata')//mods:name/mods:namePart[@type='date']">
                            <xforms:label>, </xforms:label>
                        </xforms:output>
                    </p>
                    <p>

                        <xforms:output ref="instance('metadata')//mods:originInfo/mods:publisher">
                            <xforms:label>Publisher: </xforms:label>
                        </xforms:output>
                    </p>
                   
                </div>

            </div>
            <!-- Tabs for switching to between form parts -->
            <div id="tabs">
                <xforms:trigger id="tab1" appearance="minimal">
                    <xforms:label>Citation Information </xforms:label>
                    <xforms:toggle case="case1" ev:event="DOMActivate"/>
                </xforms:trigger> :: <xforms:trigger id="tab2" appearance="minimal">

                    <xforms:label>Resource Description </xforms:label>
                    <xforms:toggle case="case2" ev:event="DOMActivate"/>
                </xforms:trigger> :: <xforms:trigger id="tab3" appearance="minimal">
                    <xforms:label>Subject Analysis </xforms:label>
                    <xforms:toggle case="case3" ev:event="DOMActivate"/>
                </xforms:trigger> :: <xforms:trigger id="tab4" appearance="minimal">

                    <xforms:label>Relationships</xforms:label>
                    <xforms:toggle case="case4" ev:event="DOMActivate"/>
                </xforms:trigger> :: <xforms:trigger id="tab5" appearance="minimal">
                    <xforms:label>Administrative</xforms:label>
                    <xforms:toggle case="case5" ev:event="DOMActivate"/>
                </xforms:trigger>
                <xforms:submit submission="submit" class="submit">

                    <xforms:label>Save</xforms:label>
                    <xforms:hint>Save record to database</xforms:hint>
                </xforms:submit>
            </div>
            <xforms:switch>
                <xforms:case id="case1" selected="true()">
                    <h3>Citation Information</h3>

                    <fieldset>
                        <legend>
                            <xforms:trigger class="add" appearance="minimal">
                                <xforms:label><img src="../styles/images/add.gif" alt="Add"/></xforms:label>
                                    <xforms:insert ev:event="DOMActivate" context="instance('metadata')" nodeset="instance('metadata')/mods:titleInfo[last()]" at="index('titleInfo')" position="after" origin="instance('basic')/mods:titleInfo[2]"/>
                            </xforms:trigger> Title </legend>
                        <xforms:repeat nodeset="instance('metadata')/mods:titleInfo" id="titleInfo">
                            <div class="section">

                                <p class="deleteSection">
                                    <xforms:trigger appearance="minimal" ref="self::node()[count(../mods:titleInfo) &gt; 1]">
                                        <xforms:label><img src="../styles/images/remove.gif" alt="Remove"/></xforms:label>
                                            <xforms:delete ev:event="DOMActivate" nodeset="." at="index('titleInfo')"/>
                                    </xforms:trigger>
                                </p>
                                <div class="left">
                                    <!-- Title type should only appear on subsequent titles, and authority should be inserted if value of type is either uniform or abbriviated -->
                                    <p>

                                        <xforms:select1 ref="@type" id="titleType">
                                            <xforms:label class="mods-label">Type:     </xforms:label>
                                            <xforms:item>
                                                <xforms:label>Abbreviated</xforms:label>
                                                <xforms:value>abbreviated</xforms:value>
                                            </xforms:item>
                                            <xforms:item>

                                                <xforms:label>Alternative</xforms:label>
                                                <xforms:value>alternative </xforms:value>
                                            </xforms:item>
                                            <xforms:item>
                                                <xforms:label>Translated</xforms:label>
                                                <xforms:value>translated</xforms:value>
                                            </xforms:item>

                                            <xforms:item>
                                                <xforms:label>Uniform</xforms:label>
                                                <xforms:value>uniform</xforms:value>
                                            </xforms:item>
                                        </xforms:select1>
                                        <xforms:trigger class="delete" appearance="minimal" ref="self::node()[@type]">
                                            <xforms:label><img src="../styles/images/remove.gif" alt="Remove"/></xforms:label>
                                                <xforms:delete ev:event="DOMActivate" nodeset="self::node()/@type" at="index('titleInfo')"/>

                                        </xforms:trigger>
                                    </p>
                                    <p>
                                        <xforms:input ref="@authority" class="attribute">
                                            <xforms:label class="mods-label">Authority: </xforms:label>
                                        </xforms:input>
                                    </p>
                                    <p>

                                        <xforms:input ref="mods:nonSort">
                                            <xforms:label class="mods-label">Non-sort:</xforms:label>
                                        </xforms:input>
                                        <xforms:trigger class="delete" appearance="minimal" ref="self::node()[count(mods:nonSort) &gt; 0]">
                                            <xforms:label><img src="../styles/images/remove.gif" alt="Remove"/></xforms:label>
                                                <xforms:delete ev:event="DOMActivate" nodeset="mods:nonSort" at="index('titleInfo')"/>
                                        </xforms:trigger>
                                    </p>

                                    <p class="longItem">
                                        <xforms:input ref="mods:title">
                                            <xforms:label class="mods-label">Title:    </xforms:label>
                                        </xforms:input>
                                    </p>
                                    <p class="longItem">
                                        <xforms:input ref="mods:subTitle">
                                            <xforms:label class="mods-label">Sub-title: </xforms:label>

                                        </xforms:input>
                                        <xforms:trigger class="delete" appearance="minimal" ref="self::node()[count(mods:subTitle) &gt; 0]">
                                            <xforms:label><img src="../styles/images/remove.gif" alt="Remove"/></xforms:label>
                                                <xforms:delete ev:event="DOMActivate" nodeset="mods:subTitle" at="index('titleInfo')"/>
                                        </xforms:trigger>
                                    </p>
                                    <p>
                                        <xforms:input ref="mods:partNumber">
                                            <xforms:label class="mods-label">Part Number: </xforms:label>

                                        </xforms:input>
                                        <xforms:trigger class="delete" appearance="minimal" ref="self::node()[count(mods:partNumber) &gt; 0]">
                                            <xforms:label><img src="../styles/images/remove.gif" alt="Remove"/></xforms:label>
                                                <xforms:delete ev:event="DOMActivate" nodeset="mods:partNumber" at="index('titleInfo')"/>
                                        </xforms:trigger>
                                    </p>
                                    <p>
                                        <xforms:input ref="mods:partName">
                                            <xforms:label class="mods-label">Part Name:  </xforms:label>

                                        </xforms:input>
                                        <xforms:trigger class="delete" appearance="minimal" ref="self::node()[count(mods:partName) &gt; 0]">
                                            <xforms:label><img src="../styles/images/remove.gif" alt="Remove"/></xforms:label>
                                                <xforms:delete ev:event="DOMActivate" nodeset="mods:partName" at="index('titleInfo')"/>
                                        </xforms:trigger>
                                    </p>
                                    <p>
                                        <xforms:input ref="@displayLabel">
                                            <xforms:label class="mods-label">Display Label: </xforms:label>

                                            <xforms:trigger class="delete" appearance="minimal" ref=".">
                                                <xforms:label><img src="../styles/images/remove.gif" alt="Remove"/></xforms:label>
                                                <xforms:delete ev:event="DOMActivate" nodeset="." at="index('titleInfo')"/>
                                            </xforms:trigger>
                                        </xforms:input>

                                    </p>
                                </div>
                                <dl class="optionalElements">

                                    <dt>Optional Fields</dt>
                                    <dd>
                                        <xforms:trigger appearance="minimal" ref="self::node()[count(mods:nonSort) = 0]">
                                            <xforms:label><img src="../styles/images/add.gif"/>NonSort </xforms:label>
                                            <xforms:insert ev:event="DOMActivate" context="instance('metadata')" nodeset="instance('metadata')/mods:titleInfo[index('titleInfo')]/child::*" at="index('titleInfo')" position="after" origin="instance('template')/mods:titleInfo/mods:nonSort"/>
                                        </xforms:trigger>
                                    </dd>
                                    <dd>

                                        <xforms:trigger class="add" appearance="minimal" ref="self::node()[count(mods:subTitle) = 0]">
                                            <xforms:label><img src="../styles/images/add.gif"/>SubTitle</xforms:label>
                                            <xforms:insert ev:event="DOMActivate" context="instance('metadata')" nodeset="instance('metadata')/mods:titleInfo[index('titleInfo')]/child::*" at="index('titleInfo')" position="after" origin="instance('template')/mods:titleInfo/mods:subTitle"/>
                                        </xforms:trigger>
                                    </dd>
                                    <dd>
                                        <xforms:trigger class="add" appearance="minimal" ref="self::node()[count(mods:partNumber) = 0]">
                                            <xforms:label><img src="../styles/images/add.gif"/> Part Number</xforms:label>

                                            <xforms:insert ev:event="DOMActivate" context="instance('metadata')" nodeset="instance('metadata')/mods:titleInfo[index('titleInfo')]/child::*" at="index('titleInfo')" position="after" origin="instance('template')/mods:titleInfo/mods:partNumber"/>
                                        </xforms:trigger>
                                    </dd>
                                    <dd>
                                        <xforms:trigger class="add" appearance="minimal" ref="self::node()[count(mods:partName) = 0]">
                                            <xforms:label><img src="../styles/images/add.gif"/> Part Name</xforms:label>
                                            <xforms:insert ev:event="DOMActivate" context="instance('metadata')" nodeset="instance('metadata')/mods:titleInfo[index('titleInfo')]/child::*" at="index('titleInfo')" position="after" origin="instance('template')/mods:titleInfo/mods:partName"/>
                                        </xforms:trigger>

                                    </dd>
                                    <dd>
                                        <xforms:trigger appearance="minimal" ref="self::node()[not(@displayLabel)]">
                                            <xforms:label><img src="../styles/images/add.gif"/>Display Label</xforms:label>
                                            <xforms:insert ev:event="DOMActivate" context="instance('metadata')" nodeset="instance('metadata')/mods:titleInfo[index('titleInfo')]" at="index('titleInfo')" position="after" origin="instance('template')/mods:titleInfo/@displayLabel"/>
                                        </xforms:trigger>
                                    </dd>
                                </dl>

                                <br class="clear"/>
                            </div>
                        </xforms:repeat>
                    </fieldset>
                    <fieldset>
                        <legend>
                            <xforms:trigger class="add" appearance="minimal">
                                <xforms:label><img src="../styles/images/add.gif" alt="Add"/></xforms:label>
                                    <xforms:insert ev:event="DOMActivate" context="instance('metadata')" nodeset="instance('metadata')/child::*" at="index('name')" position="after" origin="instance('basic')/mods:name"/>

                            </xforms:trigger> Name </legend>
                        <div class="lookup">
                            <h3>Look up names in authority files</h3>
                            <p>
                                <xforms:input ref="instance('requestName')/term" incremental="true">
                                    <xforms:label>Find Names:</xforms:label>
                                    <xforms:action ev:event="xforms-value-changed">

                                        <xforms:send submission="get-name"/>
                                    </xforms:action>
                                </xforms:input>
                                <xforms:trigger class="add" appearance="minimal">
                                    <xforms:label><img src="../styles/images/add.gif" alt="Add"/>Add Selected</xforms:label>
                                        <xforms:insert ev:event="DOMActivate" context="instance('metadata')" nodeset="instance('metadata')/mods:name[last()]" at="index('name')" position="after" origin="instance('names')/child::*/child::*"/>
                                </xforms:trigger>
                                <xforms:select ref="instance('names')/child::*" appearance="full">

                                    <xforms:label/>
                                    <xforms:itemset nodeset="instance('response')/child::*">
                                        <xforms:label style="display: block;" ref="child::*/child::*"/>
                                        <xforms:copy ref="child::*"/>
                                    </xforms:itemset>
                                </xforms:select>
                                <br class="clear"/>
                            </p>
                        </div>

                        <br class="clear"/>
                        <xforms:repeat nodeset="instance('metadata')/mods:name" id="name">
                            <div class="section">
                                <p class="deleteSection">
                                    <xforms:trigger appearance="minimal" ref="self::node()[count(../mods:name) &gt; 1]">
                                        <xforms:label><img src="../styles/images/remove.gif" alt="Remove"/></xforms:label>
                                            <xforms:delete ev:event="DOMActivate" nodeset="." at="index('name')"/>
                                    </xforms:trigger>
                                </p>

                                <div class="left">
                                    <p>
                                        <xforms:output ref="@type">
                                            <xforms:label>Name Type: </xforms:label>
                                        </xforms:output>
                                    </p>
                                    <p>
                                        <xforms:output ref="@authority">

                                            <xforms:label>Authority: </xforms:label>
                                        </xforms:output>
                                    </p>
                                    <p>
                                        <xforms:output ref="mods:namePart[not(@type='date')]">
                                            <xforms:label>Name: </xforms:label>
                                        </xforms:output>
                                        <xforms:output ref="mods:namePart[@type='date']">

                                            <xforms:label>, </xforms:label>
                                        </xforms:output>
                                    </p>
                                    <xforms:repeat nodeset="mods:role" id="roleInfo">
                                        <p>
                                            <xforms:select1 ref="mods:roleTerm[@type='text']">
                                                <xforms:label>Role: </xforms:label>
                                                <xforms:itemset nodeset="instance('roleShort')/mods:role">

                                                  <xforms:label ref="mods:roleTerm[@type='text']"/>
                                                  <xforms:value ref="mods:roleTerm[@type='text']"/>
                                                </xforms:itemset>
                                            </xforms:select1>
                                            <xforms:input ref="mods:roleTerm[@type='code']">
                                                <xforms:label>Role [code]: </xforms:label>
                                            </xforms:input>
                                            <xforms:submit submission="getRoles" class="submit">

                                                <xforms:label>View full list of codes</xforms:label>
                                                <xforms:hint>View full list of MARC codes for this field</xforms:hint>
                                            </xforms:submit>
                                            <xforms:trigger class="delete" appearance="minimal">
                                                <xforms:label><img src="../styles/images/remove.gif" alt="remove"/></xforms:label>
                                                    <xforms:delete ev:event="DOMActivate" nodeset="." at="index('roleInfo')"/>
                                            </xforms:trigger>
                                            <xforms:trigger class="add" appearance="minimal">

                                                <xforms:label><img src="../styles/images/add.gif" alt="add"/></xforms:label>
                                                    <xforms:insert ev:event="DOMActivate" context="instance('metadata')" nodeset="instance('metadata')/mods:name[index('name')]/mods:role" at="index('roleInfo')" position="after" origin="instance('template')/mods:name/mods:role"/>
                                            </xforms:trigger>
                                        </p>
                                    </xforms:repeat>
                                </div>
                                <dl class="optionalElements">
                                    <dt>Optional Fields</dt>

                                    <dd>
                                        <xforms:trigger appearance="minimal" ref="self::node()[not(@type)]">
                                            <xforms:label><img src="../styles/images/add.gif"/>Type</xforms:label>
                                            <xforms:insert ev:event="DOMActivate" context="instance('metadata')" nodeset="instance('metadata')/mods:name[index('name')]" at="index('name')" position="after" origin="instance('template')/mods:titleInfo/@type"/>
                                        </xforms:trigger>
                                    </dd>
                                    <dd>
                                        <xforms:trigger appearance="minimal" ref="self::node()[not(@authority)]">

                                            <xforms:label><img src="../styles/images/add.gif"/>Authority</xforms:label>
                                            <xforms:insert ev:event="DOMActivate" context="instance('metadata')" nodeset="instance('metadata')/mods:name[index('name')]" at="index('name')" position="after" origin="instance('template')/mods:titleInfo/@authority"/>
                                        </xforms:trigger>
                                    </dd>
                                    <dd>
                                        <xforms:trigger class="add" appearance="minimal" ref="self::node()[count(mods:namePart[@type='date']) = 0]">
                                            <xforms:label><img src="../styles/images/add.gif"/> Date</xforms:label>

                                            <xforms:insert ev:event="DOMActivate" context="instance('metadata')" nodeset="instance('metadata')/mods:name[index('name')]/child::*" at="index('name')" position="after" origin="instance('template')/mods:name/mods:namePart[@type='date']"/>
                                        </xforms:trigger>
                                    </dd>
                                    <dd>
                                        <xforms:trigger class="add" appearance="minimal" ref="self::node()[count(mods:role) = 0]">
                                            <xforms:label><img src="../styles/images/add.gif"/> Role </xforms:label>
                                            <xforms:insert ev:event="DOMActivate" context="instance('metadata')" nodeset="instance('metadata')/mods:name[index('name')]/child::*" at="index('name')" position="after" origin="instance('template')/mods:name/mods:role"/>
                                        </xforms:trigger>

                                    </dd>
                                </dl>
                                <br class="clear"/>
                            </div>
                        </xforms:repeat>
                    </fieldset>
                    <fieldset>
                        <legend> Publisher Information </legend>

                        <!-- BUG: Need to prevent all child noded from being deleted, perhaps by requiring at least one date element -->
                        <xforms:repeat nodeset="instance('metadata')/mods:originInfo" id="originInfo">
                            <div class="section">
                                <p class="deleteSection">
                                    <xforms:trigger class="delete" appearance="minimal" ref="self::node()[count(../mods:originInfo) &gt; 1]">
                                        <xforms:label><img src="../styles/images/remove.gif" alt="Remove"/></xforms:label>
                                            <xforms:delete ev:event="DOMActivate" nodeset="." at="index('genreInfo')"/>
                                    </xforms:trigger>
                                </p>

                                <div class="left">
                                    <!-- Also left out dateCaptured, dateValid, and dateModified according to DLF recomendations, they would be easy enough to add in, but we are not going to use them -->
                                    <xforms:repeat nodeset="mods:dateCaptured" id="dateCaptured">
                                        <p class="date">
                                            <xforms:trigger class="delete" appearance="minimal" ref="self::node()[@point = 'end']">
                                                <xforms:label><img src="../styles/images/remove.gif" alt="Remove"/></xforms:label>
                                                <xforms:action ev:event="DOMActivate">
                                                    <xforms:delete nodeset="self::node()" at="index('dateCreated')"/>
                                                    <xforms:delete nodeset="instance('metadata')/mods:originInfo[index('originInfo')]/mods:dateCaptured[@point = 'start']/@point" at="index('dateCaptured')"/>

                                                </xforms:action>    
                                            </xforms:trigger>
                                            <xforms:trigger class="delete" appearance="minimal" ref="self::node()[not(@point = 'end')]">
                                                <xforms:label><img src="../styles/images/remove.gif"/></xforms:label>
                                                    <xforms:delete ev:event="DOMActivate" nodeset="." at="index('dateCaptured')"/>
                                            </xforms:trigger>
                                            <xforms:input ref=".[not(@point)]">
                                                <xforms:label>Date Captured: </xforms:label>
                                            </xforms:input>

                                            <xforms:input ref=".[@point = 'start']">
                                                <xforms:label>Date Captured (start): </xforms:label>
                                            </xforms:input>
                                            <xforms:input ref=".[@point = 'end']">
                                                <xforms:label>Date Captured(end): </xforms:label>
                                            </xforms:input>
                                            <xforms:select1 ref="@qualifier">
                                                <xforms:label>Qualifier: </xforms:label>

                                                <xforms:item>
                                                  <xforms:label>Approximate</xforms:label>
                                                  <xforms:value>approximate</xforms:value>
                                                </xforms:item>
                                                <xforms:item>
                                                  <xforms:label>Inferred</xforms:label>
                                                  <xforms:value>inferred</xforms:value>

                                                </xforms:item>
                                                <xforms:item>
                                                  <xforms:label>Questionable</xforms:label>
                                                  <xforms:value>questionable</xforms:value>
                                                </xforms:item>
                                            </xforms:select1>
                                            <xforms:trigger class="delete" appearance="minimal" ref="self::node()[@qualifier]">
                                                <xforms:label><img src="../styles/images/remove.gif" alt="Remove"/></xforms:label>

                                                <xforms:delete ev:event="DOMActivate" nodeset="self::node()/@qualifier" at="index('dateCaptured')"/>
                                            </xforms:trigger>
                                            <xforms:trigger class="add" appearance="minimal" ref="self::node()[not(@qualifier)]">
                                                <xforms:label>Add qualifier?</xforms:label>
                                                <xforms:action ev:event="DOMActivate">
                                                  <xforms:insert nodeset="instance('metadata')/mods:originInfo[index('originInfo')]/mods:dateCaptured[index('dateCaptured')][1]" at="index('dateCaptured')" context="instance('metadata')/mods:originInfo/mods:dateCaptured" origin="instance('template')/mods:originInfo/mods:dateCaptured[3]/@qualifier" position="after"/>
                                                  <xforms:setvalue ref="instance('metadata')/mods:originInfo[index('originInfo')]/mods:dateCaptured[1]/@point" value="'start'"/>
                                                  <xforms:setvalue ref="instance('metadata')/mods:originInfo[index('originInfo')]/mods:dateCaptured[2]/@point" value="'end'"/>

                                                 </xforms:action>   
                                            </xforms:trigger>
                                            <xforms:trigger class="add" appearance="minimal" ref="self::node()[not(@point)]">
                                                <xforms:label>Add End Date?</xforms:label>
                                                <xforms:action ev:event="DOMActivate">
                                                  <xforms:insert nodeset="instance('metadata')/mods:originInfo[index('originInfo')]/mods:dateCaptured[index('dateCaptured')]" at="index('dateCaptured')" context="instance('metadata')/mods:originInfo/mods:dateCaptured" origin="instance('template')/mods:originInfo/mods:dateCaptured[2]" position="after"/>
                                                  <xforms:insert nodeset="instance('metadata')/mods:originInfo[index('originInfo')]/mods:dateCaptured[index('dateCaptured')][1]" at="index('dateCaptured')" context="instance('metadata')/mods:originInfo/mods:dateCaptured" origin="instance('template')/mods:originInfo/mods:dateCaptured[2]/@point" position="after"/>
                                                  <xforms:setvalue ref="instance('metadata')/mods:originInfo[index('originInfo')]/mods:dateCaptured[1]/@point" value="'start'"/>
                                                  <xforms:setvalue ref="instance('metadata')/mods:originInfo[index('originInfo')]/mods:dateCaptured[2]/@point" value="'end'"/>

                                                </xforms:action>
                                            </xforms:trigger>
                                        </p>
                                    </xforms:repeat>
                                    <xforms:repeat nodeset="mods:dateIssued" id="dateIssued">
                                        <p class="date">
                                            <xforms:trigger class="delete" appearance="minimal" ref="self::node()[not(@point = 'end')]">
                                                <xforms:label><img src="../styles/images/remove.gif"/></xforms:label>
                                                    <xforms:delete ev:event="DOMActivate" nodeset="." at="index('dateIssued')"/>

                                            </xforms:trigger>
                                            <xforms:trigger class="delete" appearance="minimal" ref="self::node()[@point = 'end']">
                                                <xforms:label><img src="../styles/images/remove.gif" alt="Remove"/></xforms:label>
                                                <xforms:action ev:event="DOMActivate">
                                                    <xforms:delete nodeset="self::node()" at="index('dateIssued')"/>
                                                    <xforms:delete nodeset="instance('metadata')/mods:originInfo[index('originInfo')]/mods:dateIssued[@point = 'start']/@point" at="index('dateIssued')"/>
                                                </xforms:action>
                                            </xforms:trigger>
                                            <xforms:input ref=".[not(@point)]">

                                                <xforms:label>Date Issued: </xforms:label>
                                            </xforms:input>
                                            <xforms:input ref=".[@point = 'start']">
                                                <xforms:label>Publication Date (start):
                                                </xforms:label>
                                            </xforms:input>
                                            <xforms:input ref=".[@point = 'end']">
                                                <xforms:label>Publication Date (end):
                                                </xforms:label>

                                            </xforms:input>
                                            <xforms:select1 ref="@qualifier">
                                                <xforms:label>Qualifier: </xforms:label>
                                                <xforms:item>
                                                  <xforms:label>Approximate</xforms:label>
                                                  <xforms:value>approximate</xforms:value>
                                                </xforms:item>

                                                <xforms:item>
                                                  <xforms:label>Inferred</xforms:label>
                                                  <xforms:value>inferred</xforms:value>
                                                </xforms:item>
                                                <xforms:item>
                                                  <xforms:label>Questionable</xforms:label>
                                                  <xforms:value>questionable</xforms:value>

                                                </xforms:item>
                                            </xforms:select1>
                                            <xforms:trigger class="add" appearance="minimal" ref="self::node()[not(@qualifier)]">
                                                <xforms:label>Add qualifier?</xforms:label>
                                                <xforms:action ev:event="DOMActivate">
                                                    <xforms:insert nodeset="instance('metadata')/mods:originInfo[index('originInfo')]/mods:dateIssued[index('dateIssued')][1]" at="index('dateIssued')" context="instance('metadata')/mods:originInfo/mods:dateIssued" origin="instance('template')/mods:originInfo/mods:dateIssued[3]/@qualifier" position="after"/>
                                                    <xforms:setvalue ref="instance('metadata')/mods:originInfo[index('originInfo')]/mods:dateIssued[1]/@point" value="'start'"/>
                                                    <xforms:setvalue ref="instance('metadata')/mods:originInfo[index('originInfo')]/mods:dateIssued[2]/@point" value="'end'"/>

                                               </xforms:action>     
                                            </xforms:trigger>
                                            <xforms:trigger class="delete" appearance="minimal" ref="self::node()[@qualifier]">
                                                <xforms:label><img src="../styles/images/remove.gif" alt="Remove"/></xforms:label>
                                                    <xforms:delete ev:event="DOMActivate" nodeset="self::node()/@qualifier" at="index('dateIssued')"/>
                                            </xforms:trigger>
                                            <xforms:trigger class="add" appearance="minimal" ref="self::node()[not(@point)]">
                                                <xforms:label>Add End Date?</xforms:label>
                                                <xforms:action ev:event="DOMActivate">

                                                    <xforms:insert nodeset="instance('metadata')/mods:originInfo[index('originInfo')]/mods:dateIssued[index('dateIssued')]" at="index('dateIssued')" context="instance('metadata')/mods:originInfo/mods:dateIssued" origin="instance('template')/mods:originInfo/mods:dateIssued[2]" position="after"/>
                                                    <xforms:insert nodeset="instance('metadata')/mods:originInfo[index('originInfo')]/mods:dateIssued[index('dateIssued')][1]" at="index('dateIssued')" context="instance('metadata')/mods:originInfo/mods:dateIssued" origin="instance('template')/mods:originInfo/mods:dateIssued[2]/@point" position="after"/>
                                                    <xforms:setvalue ref="instance('metadata')/mods:originInfo[index('originInfo')]/mods:dateIssued[1]/@point" value="'start'"/>
                                                    <xforms:setvalue ref="instance('metadata')/mods:originInfo[index('originInfo')]/mods:dateIssued[2]/@point" value="'end'"/>
                                                </xforms:action>    
                                            </xforms:trigger>
                                        </p>
                                    </xforms:repeat>
                                    <xforms:repeat nodeset="mods:dateCreated" id="dateCreated">

                                        <p class="date">
                                            <xforms:trigger class="delete" appearance="minimal" ref="self::node()[@point = 'end']">
                                                <xforms:label><img src="../styles/images/remove.gif" alt="Remove"/></xforms:label>
                                                <xforms:action ev:event="DOMActivate">
                                                    <xforms:delete nodeset="self::node()" at="index('dateCreated')"/>
                                                    <xforms:delete nodeset="instance('metadata')/mods:originInfo[index('originInfo')]/mods:dateCreated[@point = 'start']/@point" at="index('dateCreated')"/>
                                               </xforms:action>     
                                            </xforms:trigger>
                                            <xforms:trigger class="delete" appearance="minimal" ref="self::node()[not(@point = 'end')]">

                                                <xforms:label><img src="../styles/images/remove.gif"/></xforms:label>
                                                    <xforms:delete ev:event="DOMActivate" nodeset="." at="index('dateCreated')"/>
                                            </xforms:trigger>
                                            <xforms:input ref=".[not(@point)]">
                                                <xforms:label>Date Created: </xforms:label>
                                            </xforms:input>
                                            <xforms:input ref=".[@point = 'start']">
                                                <xforms:label>Date Created (start): </xforms:label>

                                            </xforms:input>
                                            <xforms:input ref=".[@point = 'end']">
                                                <xforms:label>Date Created (end): </xforms:label>
                                            </xforms:input>
                                            <xforms:select1 ref="@qualifier">
                                                <xforms:label>Qualifier: </xforms:label>
                                                <xforms:item>
                                                  <xforms:label>Approximate</xforms:label>

                                                  <xforms:value>approximate</xforms:value>
                                                </xforms:item>
                                                <xforms:item>
                                                  <xforms:label>Inferred</xforms:label>
                                                  <xforms:value>inferred</xforms:value>
                                                </xforms:item>
                                                <xforms:item>

                                                  <xforms:label>Questionable</xforms:label>
                                                  <xforms:value>questionable</xforms:value>
                                                </xforms:item>
                                            </xforms:select1>
                                            <xforms:trigger class="add" appearance="minimal" ref="self::node()[not(@qualifier)]">
                                                <xforms:label>Add qualifier?</xforms:label>
                                                <xforms:action ev:event="DOMActivate">

                                                    <xforms:insert nodeset="instance('metadata')/mods:originInfo[index('originInfo')]/mods:dateCreated[index('dateCreated')][1]" at="index('dateCreated')" context="instance('metadata')/mods:originInfo/mods:dateCreated" origin="instance('template')/mods:originInfo/mods:dateCreated[3]/@qualifier" position="after"/>
                                                    <xforms:setvalue ref="instance('metadata')/mods:originInfo[index('originInfo')]/mods:dateCreated[1]/@point" value="'start'"/>
                                                    <xforms:setvalue ref="instance('metadata')/mods:originInfo[index('originInfo')]/mods:dateCreated[2]/@point" value="'end'"/>
                                                </xforms:action>
                                            </xforms:trigger>
                                            <xforms:trigger class="delete" appearance="minimal" ref="self::node()[@qualifier]">
                                                <xforms:label><img src="../styles/images/remove.gif" alt="Remove"/></xforms:label>
                                                <xforms:delete ev:event="DOMActivate" nodeset="self::node()/@qualifier" at="index('dateCreated')"/>
                                            </xforms:trigger>

                                            <xforms:trigger class="add" appearance="minimal" ref="self::node()[not(@point)]">
                                                <xforms:label>Add End Date?</xforms:label>
                                                <xforms:action ev:event="DOMActivate">
                                                      <xforms:insert nodeset="instance('metadata')/mods:originInfo[index('originInfo')]/mods:dateCreated[index('dateCreated')]" at="index('dateCreated')" context="instance('metadata')/mods:originInfo/mods:dateCreated" origin="instance('template')/mods:originInfo/mods:dateCreated[2]" position="after"/>
                                                      <xforms:insert nodeset="instance('metadata')/mods:originInfo[index('originInfo')]/mods:dateCreated[index('dateCreated')][1]" at="index('dateCreated')" context="instance('metadata')/mods:originInfo/mods:dateCreated" origin="instance('template')/mods:originInfo/mods:dateCreated[2]/@point" position="after"/>
                                                      <xforms:setvalue ref="instance('metadata')/mods:originInfo[index('originInfo')]/mods:dateCreated[1]/@point" value="'start'"/>
                                                      <xforms:setvalue ref="instance('metadata')/mods:originInfo[index('originInfo')]/mods:dateCreated[2]/@point" value="'end'"/>
                                                </xforms:action>

                                            </xforms:trigger>
                                        </p>
                                    </xforms:repeat>
                                    <xforms:repeat nodeset="mods:copyrightDate" id="copyrightDate">
                                        <p class="date">
                                            <xforms:trigger class="delete" appearance="minimal" ref="self::node()[@point = 'end']">
                                                <xforms:label><img src="../styles/images/remove.gif" alt="Remove"/> </xforms:label>
                                                <xforms:action ev:event="DOMActivate">    
                                                    <xforms:delete nodeset="self::node()" at="index('copyrightDate')"/>

                                                    <xforms:delete nodeset="instance('metadata')/mods:originInfo[index('originInfo')]/mods:copyrightDate[@point = 'start']/@point" at="index('copyrightDate')"/>
                                                </xforms:action>
                                            </xforms:trigger>
                                            <xforms:trigger class="delete" appearance="minimal" ref="self::node()[not(@point = 'end')]">
                                                <xforms:label><img src="../styles/images/remove.gif"/></xforms:label>
                                                <xforms:delete ev:event="DOMActivate" nodeset="." at="index('copyrightDate')"/>
                                            </xforms:trigger>
                                            <xforms:input ref=".[not(@point)]">
                                                <xforms:label>Copyright Date: </xforms:label>

                                            </xforms:input>
                                            <xforms:input ref=".[@point = 'start']">
                                                <xforms:label>Copyright Date (start):
                                                </xforms:label>
                                            </xforms:input>
                                            <xforms:input ref=".[@point = 'end']">
                                                <xforms:label>Copyright Date (end): </xforms:label>
                                            </xforms:input>
                                            <xforms:select1 ref="@qualifier">

                                                <xforms:label>Qualifier: </xforms:label>
                                                <xforms:item>
                                                  <xforms:label>Approximate</xforms:label>
                                                  <xforms:value>approximate</xforms:value>
                                                </xforms:item>
                                                <xforms:item>
                                                  <xforms:label>Inferred</xforms:label>

                                                  <xforms:value>inferred</xforms:value>
                                                </xforms:item>
                                                <xforms:item>
                                                  <xforms:label>Questionable</xforms:label>
                                                  <xforms:value>questionable</xforms:value>
                                                </xforms:item>
                                            </xforms:select1>

                                            <xforms:trigger class="add" appearance="minimal" ref="self::node()[not(@qualifier)]">
                                                <xforms:label>Add qualifier?</xforms:label>
                                                <xforms:action ev:event="DOMActivate">
                                                    <xforms:insert nodeset="instance('metadata')/mods:originInfo[index('originInfo')]/mods:copyrightDate[index('copyrightDate')][1]" at="index('copyrightDate')" context="instance('metadata')/mods:originInfo/mods:copyrightDate" origin="instance('template')/mods:originInfo/mods:copyrightDate[3]/@qualifier" position="after"/>
                                                    <xforms:setvalue ref="instance('metadata')/mods:originInfo[index('originInfo')]/mods:copyrightDate[1]/@point" value="'start'"/>
                                                    <xforms:setvalue ref="instance('metadata')/mods:originInfo[index('originInfo')]/mods:copyrightDate[2]/@point" value="'end'"/>
                                                </xforms:action>                                                
                                            </xforms:trigger>
                                            <xforms:trigger class="delete" appearance="minimal" ref="self::node()[@qualifier]">

                                                <xforms:label>
                                                  <img src="../styles/images/remove.gif" alt="Remove"/>
                                                </xforms:label>
                                                <xforms:delete ev:event="DOMActivate" nodeset="self::node()/@qualifier" at="index('copyrightDate')"/>
                                            </xforms:trigger>
                                            <xforms:trigger class="add" appearance="minimal" ref="self::node()[not(@point)]">
                                                <xforms:label>Add End Date?</xforms:label>
                                                <xforms:action ev:event="DOMActivate">  
                                                    <xforms:insert nodeset="instance('metadata')/mods:originInfo[index('originInfo')]/mods:copyrightDate[index('copyrightDate')]" at="index('copyrightDate')" context="instance('metadata')/mods:originInfo/mods:copyrightDate" origin="instance('template')/mods:originInfo/mods:copyrightDate[2]" position="after"/>

                                                    <xforms:insert nodeset="instance('metadata')/mods:originInfo[index('originInfo')]/mods:copyrightDate[index('copyrightDate')][1]" at="index('dateCreated')" context="instance('metadata')/mods:originInfo/mods:copyrightDate" origin="instance('template')/mods:originInfo/mods:copyrightDate[2]/@point" position="after"/>
                                                    <xforms:setvalue ref="instance('metadata')/mods:originInfo[index('originInfo')]/mods:copyrightDate[1]/@point" value="'start'"/>
                                                    <xforms:setvalue ref="instance('metadata')/mods:originInfo[index('originInfo')]/mods:copyrightDate[2]/@point" value="'end'"/>
                                                </xforms:action>
                                            </xforms:trigger> 
                                        </p>
                                    </xforms:repeat>
                                    <!-- Date Other is a little buggy still -->
                                    <xforms:repeat nodeset="mods:dateOther" id="dateOther">

                                        <p class="date">
                                            <xforms:trigger class="delete" appearance="minimal" ref="self::node()[@point = 'end']">
                                                <xforms:label> <img src="../styles/images/remove.gif" alt="Remove"/></xforms:label>
                                                <xforms:action ev:event="DOMActivate">
                                                    <xforms:delete nodeset="self::node()" at="index('dateOther')"/>
                                                    <xforms:delete nodeset="instance('metadata')/mods:originInfo[index('originInfo')]/mods:dateOther[@point = 'start']/@point" at="index('dateOther')"/>
                                                </xforms:action>
                                            </xforms:trigger>

                                            <xforms:trigger class="delete" appearance="minimal" ref="not(self::node()[@point = 'end'])">
                                                <xforms:label><img src="../styles/images/remove.gif"/></xforms:label>
                                                <xforms:delete ev:event="DOMActivate" nodeset="." at="index('dateOther')"/>
                                            </xforms:trigger>
                                            <xforms:input ref=".[not(@point)]">
                                                <xforms:label>Other Dates : </xforms:label>
                                            </xforms:input>
                                            <xforms:input ref=".[@point = 'start']">

                                                <xforms:label>Other Dates (start): </xforms:label>
                                            </xforms:input>
                                            <xforms:input ref=".[@point = 'end']">
                                                <xforms:label>Other Dates (end): </xforms:label>
                                            </xforms:input>
                                            <xforms:select1 ref="@qualifier">
                                                <xforms:label>Qualifier: </xforms:label>

                                                <xforms:item>
                                                  <xforms:label>Approximate</xforms:label>
                                                  <xforms:value>approximate</xforms:value>
                                                </xforms:item>
                                                <xforms:item>
                                                  <xforms:label>Inferred</xforms:label>
                                                  <xforms:value>inferred</xforms:value>

                                                </xforms:item>
                                                <xforms:item>
                                                  <xforms:label>Questionable</xforms:label>
                                                  <xforms:value>questionable</xforms:value>
                                                </xforms:item>
                                            </xforms:select1>
                                            <xforms:trigger class="add" appearance="minimal" ref="self::node()[not(@qualifier)]">
                                                <xforms:label>Add qualifier?</xforms:label>

                                                <xforms:action ev:event="DOMActivate">
                                                    <xforms:insert nodeset="instance('metadata')/mods:originInfo[index('originInfo')]/mods:dateOther[index('dateOther')][1]" at="index('dateOther')" context="instance('metadata')/mods:originInfo/mods:dateOther" origin="instance('template')/mods:originInfo/mods:dateOther[3]/@qualifier" position="after"/>
                                                    <xforms:setvalue ref="instance('metadata')/mods:originInfo[index('originInfo')]/mods:dateOther[1]/@point" value="'start'"/>
                                                    <xforms:setvalue ref="instance('metadata')/mods:originInfo[index('originInfo')]/mods:dateOther[2]/@point" value="'end'"/>
                                               </xforms:action>     
                                            </xforms:trigger>
                                            <xforms:trigger class="delete" appearance="minimal" ref="self::node()[@qualifier]">
                                                <xforms:label><img src="../styles/images/remove.gif" alt="Remove"/></xforms:label>
                                                <xforms:delete ev:event="DOMActivate" nodeset="self::node()/@qualifier" at="index('dateOther')"/>

                                            </xforms:trigger>
                                            <xforms:trigger class="add" appearance="minimal" ref="self::node()[not(@point)]">
                                                <xforms:label>Add End Date?</xforms:label>
                                                <xforms:action ev:event="DOMActivate">  
                                                    <xforms:insert nodeset="instance('metadata')/mods:originInfo[index('originInfo')]/mods:dateOther[index('dateOther')]" at="index('dateOther')" context="instance('metadata')/mods:originInfo/mods:dateOther" origin="instance('template')/mods:originInfo/mods:dateOther[2]" position="after"/>
                                                    <xforms:insert nodeset="instance('metadata')/mods:originInfo[index('originInfo')]/mods:dateOther[index('dateOther')][1]" at="index('dateOther')" context="instance('metadata')/mods:originInfo/mods:dateOther" origin="instance('template')/mods:originInfo/mods:copyrightDate[2]/@point" position="after"/>
                                                    <xforms:setvalue ref="instance('metadata')/mods:originInfo[index('originInfo')]/mods:dateOther[1]/@point" value="'start'"/>
                                                    <xforms:setvalue ref="instance('metadata')/mods:originInfo[index('originInfo')]/mods:dateOther[2]/@point" value="'end'"/>
                                                </xforms:action>

                                            </xforms:trigger>
                                        </p>
                                    </xforms:repeat>
                                    <xforms:repeat nodeset="mods:place" id="placeInfo">
                                        <xforms:repeat nodeset="mods:placeTerm" id="placeTermInfo">
                                            <p>
                                                <xforms:input ref=".[not(@type = 'code')]">
                                                  <xforms:label>Place: </xforms:label>

                                                </xforms:input>
                                                <xforms:input ref=".[@type = 'code']">
                                                  <xforms:label>Place (code): </xforms:label>
                                                </xforms:input>
                                                <xforms:select1 ref="@authority">
                                                  <xforms:label>Authority: </xforms:label>
                                                  <xforms:item>
                                                  <xforms:label>MARC Country Codes</xforms:label>

                                                  <xforms:value>marccountry</xforms:value>
                                                  </xforms:item>
                                                  <xforms:item>
                                                  <xforms:label>ISO-3166 Country Codes</xforms:label>
                                                  <xforms:value>iso3166</xforms:value>
                                                  </xforms:item>
                                                </xforms:select1>

                                                <xforms:trigger class="add" appearance="minimal" ref="self::node()[@type='text']">
                                                  <xforms:label>Add Code</xforms:label>
                                                  <xforms:insert ev:event="DOMActivate" nodeset="instance('metadata')/mods:originInfo[index('originInfo')]/mods:place[index('placeInfo')]/mods:placeTerm" at="index('placeTermInfo')" context="instance('metadata')/mods:originInfo/mods:place/mods:placeTerm" origin="instance('template')/mods:originInfo/mods:place[2]/mods:placeTerm[2]" position="after"/>
                                                </xforms:trigger>
                                                <xforms:trigger class="delete" appearance="minimal" ref="self::node()[@type='code']">
                                                  <xforms:label> <img src="../styles/images/remove.gif" alt="Remove"/> </xforms:label>
                                                    <xforms:delete ev:event="DOMActivate" nodeset="." at="index('placeTermInfo')"/>

                                                </xforms:trigger>
                                                <xforms:trigger class="delete" appearance="minimal" ref="self::node()[not(@type='code')]">
                                                  <xforms:label><img src="../styles/images/remove.gif" alt="Remove"/></xforms:label>
                                                    <xforms:delete ev:event="DOMActivate" nodeset="parent::*" at="index('placeInfo')"/>
                                                </xforms:trigger>
                                            </p>
                                        </xforms:repeat>
                                    </xforms:repeat>
                                    <p class="longItem">

                                        <xforms:input ref="mods:publisher">
                                            <xforms:label>Publisher: </xforms:label>
                                            <xforms:trigger class="delete" appearance="minimal">
                                                <xforms:label><img src="../styles/images/remove.gif" alt="Remove"/></xforms:label>
                                                <xforms:delete ev:event="DOMActivate" nodeset="." at="index('originInfo')"/>
                                            </xforms:trigger>
                                        </xforms:input>
                                    </p>

                                    <p>
                                        <xforms:input ref="mods:edition">
                                            <xforms:label>Edition</xforms:label>
                                            <xforms:trigger class="delete" appearance="minimal">
                                                <xforms:label><img src="../styles/images/remove.gif" alt="Remove"/></xforms:label>
                                                <xforms:delete ev:event="DOMActivate" nodeset="." at="index('originInfo')"/>
                                            </xforms:trigger>
                                        </xforms:input>

                                    </p>
                                    <p>
                                        <xforms:select1 ref="mods:issuance">
                                            <xforms:label>Issuance: </xforms:label>
                                            <xforms:item>
                                                <xforms:label>continuing</xforms:label>
                                                <xforms:value>continuing</xforms:value>

                                            </xforms:item>
                                            <xforms:item>
                                                <xforms:label>monographic</xforms:label>
                                                <xforms:value>monographic</xforms:value>
                                            </xforms:item>
                                        </xforms:select1>
                                        <xforms:trigger class="delete" appearance="minimal" ref="self::node()[count(mods:issuance) &gt; 0]">
                                            <xforms:label><img src="../styles/images/remove.gif" alt="Remove"/>

                                            </xforms:label>
                                            <xforms:delete ev:event="DOMActivate" nodeset="mods:issuance" at="index('originInfo')"/>
                                        </xforms:trigger>
                                    </p>
                                    <p>
                                        <xforms:input ref="mods:frequency">
                                            <xforms:label>Frequency: </xforms:label>
                                            <xforms:trigger class="delete" appearance="minimal">

                                                <xforms:label><img src="../styles/images/remove.gif" alt="Remove"/></xforms:label>
                                                <xforms:delete ev:event="DOMActivate" nodeset="." at="index('originInfo')"/>
                                            </xforms:trigger>
                                        </xforms:input>
                                    </p>
                                </div>
                                <dl class="optionalElements">
                                    <dt>Optional Fields</dt>

                                    <dd>
                                        <xforms:trigger class="add" appearance="minimal" ref="self::node()[count(mods:place) = 0]">
                                            <xforms:label><img src="../styles/images/add.gif"/>Place</xforms:label>
                                            <xforms:insert ev:event="DOMActivate" context="instance('metadata')" nodeset="instance('metadata')/mods:originInfo[index('originInfo')]/child::*" at="index('originInfo')" position="after" origin="instance('template')/mods:originInfo/mods:place[1]"/>
                                        </xforms:trigger>
                                    </dd>
                                    <dd>
                                        <xforms:trigger class="add" appearance="minimal" ref="self::node()[count(mods:publisher) = 0]">

                                            <xforms:label><img src="../styles/images/add.gif"/>Publisher</xforms:label>
                                            <xforms:insert ev:event="DOMActivate" context="instance('metadata')" nodeset="instance('metadata')/mods:originInfo[index('originInfo')]/child::*" at="index('originInfo')" position="after" origin="instance('template')/mods:originInfo/mods:publisher"/>
                                        </xforms:trigger>
                                    </dd>
                                    <dd>
                                        <xforms:trigger class="add" appearance="minimal" ref="self::node()[count(mods:edition) = 0]">
                                            <xforms:label><img src="../styles/images/add.gif"/>Edition</xforms:label>
                                            <xforms:insert ev:event="DOMActivate" context="instance('metadata')" nodeset="instance('metadata')/mods:originInfo[index('originInfo')]/child::*" at="index('originInfo')" position="after" origin="instance('template')/mods:originInfo/mods:edition"/>

                                        </xforms:trigger>
                                    </dd>
                                    <dd>
                                        <xforms:trigger class="add" appearance="minimal" ref="self::node()[count(mods:issuance) = 0]">
                                            <xforms:label><img src="../styles/images/add.gif"/>Issuance</xforms:label>
                                            <xforms:insert ev:event="DOMActivate" context="instance('metadata')" nodeset="instance('metadata')/mods:originInfo[index('originInfo')]/child::*" at="index('originInfo')" position="after" origin="instance('template')/mods:originInfo/mods:issuance"/>
                                        </xforms:trigger>
                                    </dd>

                                    <dd>
                                        <xforms:trigger class="add" appearance="minimal" ref="self::node()[count(mods:frequency) = 0]">
                                            <xforms:label><img src="../styles/images/add.gif"/>Frequency</xforms:label>
                                            <xforms:insert ev:event="DOMActivate" context="instance('metadata')" nodeset="instance('metadata')/mods:originInfo[index('originInfo')]/child::*" at="index('originInfo')" position="after" origin="instance('template')/mods:originInfo/mods:frequency"/>
                                        </xforms:trigger>
                                    </dd>
                                    <dd>
                                        <xforms:trigger class="add" appearance="minimal" ref="self::node()[count(mods:dateCaptured) = 0]">

                                            <xforms:label><img src="../styles/images/add.gif"/> Date Captured</xforms:label>
                                            <xforms:insert ev:event="DOMActivate" context="instance('metadata')" nodeset="instance('metadata')/mods:originInfo[index('originInfo')]/child::*" at="index('originInfo')" position="after" origin="instance('template')/mods:originInfo/mods:dateCaptured[1]"/>
                                        </xforms:trigger>
                                    </dd>
                                    <dd>
                                        <xforms:trigger class="add" appearance="minimal" ref="self::node()[count(mods:dateIssued) = 0]">
                                            <xforms:label><img src="../styles/images/add.gif"/> Date Issued</xforms:label>

                                            <xforms:insert ev:event="DOMActivate" context="instance('metadata')" nodeset="instance('metadata')/mods:originInfo[index('originInfo')]/child::*" at="index('originInfo')" position="after" origin="instance('template')/mods:originInfo/mods:dateIssued[1]"/>
                                        </xforms:trigger>
                                    </dd>
                                    <dd>
                                        <xforms:trigger class="add" appearance="minimal" ref="self::node()[count(mods:dateCreated) = 0]">
                                            <xforms:label><img src="../styles/images/add.gif"/> Date Created</xforms:label>
                                            <xforms:insert ev:event="DOMActivate" context="instance('metadata')" nodeset="instance('metadata')/mods:originInfo[index('originInfo')]/child::*" at="index('originInfo')" position="after" origin="instance('template')/mods:originInfo/mods:dateCreated[1]"/>
                                        </xforms:trigger>

                                    </dd>
                                    <dd>
                                        <xforms:trigger class="add" appearance="minimal" ref="self::node()[count(mods:copyrightDate) = 0]">
                                            <xforms:label><img src="../styles/images/add.gif"/>Copyright Date</xforms:label>
                                            <xforms:insert ev:event="DOMActivate" context="instance('metadata')" nodeset="instance('metadata')/mods:originInfo[index('originInfo')]/child::*" at="index('originInfo')" position="after" origin="instance('template')/mods:originInfo/mods:copyrightDate[1]"/>
                                        </xforms:trigger>
                                    </dd>
                                    <!--<dd>
                                        <xforms:trigger class="add" appearance="minimal" ref="self::node()[count(mods:dateOther) = 0]">
                                            <xforms:label><img src="../styles/images/add.gif"/>Other Date</xforms:label>
                                            <xforms:insert ev:event="DOMActivate" context="instance('metadata')" nodeset="instance('metadata')/mods:originInfo[index('originInfo')]/child::*" at="index('originInfo')" position="after" origin="instance('template')/mods:originInfo/mods:dateOther[1]"/>
                                        </xforms:trigger>
                                    </dd>-->

                                </dl>
                                <br class="clear"/>
                            </div>
                        </xforms:repeat>
                    </fieldset>
                </xforms:case>
                <xforms:case id="case2" selected="false()">
                    <h3>Resource Description</h3>

                    <fieldset>
                        <legend>
                            <xforms:trigger class="add" appearance="minimal">
                                <xforms:label><img src="../styles/images/add.gif" alt="Add"/></xforms:label>
                                    <xforms:insert ev:event="DOMActivate" context="instance('metadata')" nodeset="instance('metadata')/child::*" at="last()" position="after" origin="instance('basic')/mods:language"/>
                            </xforms:trigger> Language </legend>
                        <!-- BUG: Need to prevent all child noded from being deleted -->
                        <xforms:repeat nodeset="instance('metadata')/mods:language" id="langInfo">

                            <div class="section">
                                <p class="deleteSection">
                                    <xforms:trigger class="delete" appearance="minimal" ref="self::node()[count(../mods:language) &gt; 1]">
                                        <xforms:label><img src="../styles/images/remove.gif" alt="Remove"/></xforms:label>
                                        <xforms:delete ev:event="DOMActivate" nodeset="." at="index('langInfo')"/>
                                    </xforms:trigger>
                                </p>
                                <div class="left">
                                    <xforms:repeat nodeset="mods:languageTerm" id="langTerm">

                                        <p>
                                            <xforms:input ref=".[not(@type = 'code')]">
                                                <xforms:label>Language: </xforms:label>
                                                <xforms:trigger appearance="minimal">
                                                  <xforms:label><img src="../styles/images/remove.gif" alt="Remove"/></xforms:label>
                                                  <xforms:delete ev:event="DOMActivate" nodeset="."/>
                                                </xforms:trigger>
                                            </xforms:input>

                                            <xforms:input ref=".[@type = 'code']">
                                                <xforms:label>Language (code): </xforms:label>
                                                <xforms:trigger appearance="minimal">
                                                  <xforms:label><img src="../styles/images/remove.gif" alt="Remove"/></xforms:label>
                                                  <xforms:delete ev:event="DOMActivate" nodeset="."/>
                                                </xforms:trigger>
                                            </xforms:input>
                                            <xforms:input ref="@authority" class="attribute">

                                                <xforms:label>Authority: </xforms:label>
                                            </xforms:input>
                                        </p>
                                    </xforms:repeat>
                                </div>
                                <dl class="optionalElements">
                                    <dt>Optional Elements</dt>
                                    <dd>

                                        <xforms:trigger class="add" appearance="minimal" ref="self::node()[not(mods:languageTerm[@type ='code'])]">
                                            <xforms:label><img src="../styles/images/add.gif"/> Code</xforms:label>
                                            <xforms:insert ev:event="DOMActivate" context="instance('metadata')" nodeset="instance('metadata')/mods:language[index('langInfo')]/child::*" at="index('langInfo')" position="after" origin="instance('template')/mods:language/mods:languageTerm[@type = 'code']"/>
                                        </xforms:trigger>
                                    </dd>
                                    <dd>
                                        <xforms:trigger class="add" appearance="minimal" ref="self::node()[not(mods:languageTerm[@type ='text'])]">
                                            <xforms:label><img src="../styles/images/add.gif"/> Text</xforms:label>

                                            <xforms:insert ev:event="DOMActivate" context="instance('metadata')" nodeset="instance('metadata')/mods:language[index('langInfo')]/child::*" at="index('langInfo')" position="after" origin="instance('template')/mods:language/mods:languageTerm[@type = 'text']"/>
                                        </xforms:trigger>
                                    </dd>
                                </dl>
                                <br class="clear"/>
                            </div>
                        </xforms:repeat>
                    </fieldset>
                    <fieldset>

                        <legend>
                            <xforms:trigger class="add" appearance="minimal" ref="self::node()[count(instance('metadata')/mods:physicalDescription) &lt; 1]">
                                <xforms:label><img src="../styles/images/add.gif" alt="Add"/></xforms:label>
                                    <xforms:insert ev:event="DOMActivate" context="instance('metadata')" nodeset="instance('metadata')/child::*" at="last()" position="after" origin="instance('basic')/mods:physicalDescription"/>
                            </xforms:trigger> Physical Description </legend>
                        <div class="section">
                            <p class="deleteSection">
                                <xforms:trigger class="delete" appearance="minimal">

                                    <xforms:label><img src="../styles/images/remove.gif" alt="Remove"/></xforms:label>
                                    <xforms:delete ev:event="DOMActivate" nodeset="instance('metadata')/mods:physicalDescription"/>
                                </xforms:trigger>
                            </p>
                            <xforms:group ref="instance('metadata')/mods:physicalDescription">
                                <div class="left">
                                    <xforms:repeat nodeset="mods:form" id="form">
                                        <p>
                                            <xforms:select1 ref=".">

                                                <xforms:label>Form: </xforms:label>
                                                <xforms:item>
                                                  <xforms:label>braille</xforms:label>
                                                  <xforms:value>braille</xforms:value>
                                                </xforms:item>
                                                <xforms:item>
                                                  <xforms:label>electronic</xforms:label>

                                                  <xforms:value>electronic</xforms:value>
                                                </xforms:item>
                                                <xforms:item>
                                                  <xforms:label>microfiche</xforms:label>
                                                  <xforms:value>microfiche</xforms:value>
                                                </xforms:item>
                                                <xforms:item>

                                                  <xforms:label>print</xforms:label>
                                                  <xforms:value>print</xforms:value>
                                                </xforms:item>
                                                <xforms:item>
                                                  <xforms:label>large print </xforms:label>
                                                  <xforms:value>large print </xforms:value>
                                                </xforms:item>

                                            </xforms:select1>
                                            <xforms:trigger class="delete" appearance="minimal" ref="self::node()[count(../mods:form) &gt; 0]">
                                                <xforms:label><img src="../styles/images/remove.gif" alt="Remove"/></xforms:label>
                                                    <xforms:delete ev:event="DOMActivate" nodeset="."/>
                                            </xforms:trigger>
                                            <xforms:trigger class="add" appearance="minimal" ref="self::node()[count(../mods:form) &gt; 0]">
                                                <xforms:label><img src="../styles/images/add.gif" alt="add"/></xforms:label>
                                                  <xforms:insert ev:event="DOMActivate" context="instance('metadata')" nodeset="instance('metadata')/mods:physicalDescription/mods:form" at="index('form')" position="after" origin="instance('template')/mods:physicalDescription/mods:form"/>
                                            </xforms:trigger>

                                        </p>
                                    </xforms:repeat>
                                    <p>
                                        <xforms:select1 ref="mods:reformattingQuality">
                                            <xforms:label>Reformatting Quality: </xforms:label>
                                            <xforms:item>
                                                <xforms:label>access</xforms:label>
                                                <xforms:value>access</xforms:value>

                                            </xforms:item>
                                            <xforms:item>
                                                <xforms:label>preservation</xforms:label>
                                                <xforms:value>preservation</xforms:value>
                                            </xforms:item>
                                            <xforms:item>
                                                <xforms:label>replacement</xforms:label>

                                                <xforms:value>replacement</xforms:value>
                                            </xforms:item>
                                        </xforms:select1>
                                        <xforms:trigger class="delete" appearance="minimal" ref="self::node()[count(mods:reformattingQuality) &gt; 0]">
                                            <xforms:label><img src="../styles/images/remove.gif" alt="Remove"/></xforms:label>
                                            <xforms:delete ev:event="DOMActivate" nodeset="mods:reformattingQuality"/>
                                        </xforms:trigger>
                                    </p>

                                    <!-- Should/could be a select box with mime types -->
                                    <xforms:repeat nodeset="mods:internetMediaType" id="mediaType">
                                        <p>
                                            <xforms:input ref=".">
                                                <xforms:label>Internet Media Type: </xforms:label>
                                            </xforms:input>
                                            <xforms:trigger class="delete" appearance="minimal">
                                                <xforms:label><img src="../styles/images/remove.gif" alt="Remove"/></xforms:label>

                                                <xforms:delete ev:event="DOMActivate" nodeset="." at="index('mediaType')"/>
                                            </xforms:trigger>
                                            <xforms:trigger class="add" appearance="minimal">
                                                <xforms:label><img src="../styles/images/add.gif" alt="Add"/></xforms:label>
                                                <xforms:insert ev:event="DOMActivate" context="instance('metadata')" nodeset="instance('metadata')/mods:physicalDescription/mods:internetMediaType[index('mediaType')]" at="index('mediaType')" position="after" origin="instance('template')/mods:physicalDescription/mods:internetMediaType"/> 
                                            </xforms:trigger>
                                        </p>
                                    </xforms:repeat>
                                    <p>

                                        <xforms:input ref="mods:extent">
                                            <xforms:label>Extent: </xforms:label>
                                        </xforms:input>
                                        <xforms:trigger class="delete" appearance="minimal" ref="self::node()[count(mods:extent) &gt; 0]">
                                            <xforms:label><img src="../styles/images/remove.gif" alt="Remove"/></xforms:label>
                                            <xforms:delete ev:event="DOMActivate" nodeset="mods:extent"/>
                                        </xforms:trigger>
                                    </p>

                                    <p>
                                        <xforms:select1 ref="mods:digitalOrigin">
                                            <xforms:label>Digital Origin: </xforms:label>
                                            <xforms:item>
                                                <xforms:label>born digital</xforms:label>
                                                <xforms:value>born digital</xforms:value>
                                            </xforms:item>

                                            <xforms:item>
                                                <xforms:label>reformatted digital</xforms:label>
                                                <xforms:value>reformatted digital</xforms:value>
                                            </xforms:item>
                                            <xforms:item>
                                                <xforms:label>digitized microfilm</xforms:label>
                                                <xforms:value>digitized microfilm</xforms:value>

                                            </xforms:item>
                                            <xforms:item>
                                                <xforms:label>digitized other analog</xforms:label>
                                                <xforms:value>digitized other analog</xforms:value>
                                            </xforms:item>
                                        </xforms:select1>
                                    </p>
                                    <p>

                                        <xforms:trigger class="delete" appearance="minimal" ref="self::node()[count(mods:note) &gt; 0]">
                                            <xforms:label><img src="../styles/images/remove.gif" alt="Remove"/></xforms:label>
                                                <xforms:delete ev:event="DOMActivate" nodeset="mods:note"/>
                                        </xforms:trigger>
                                        <xforms:textarea ref="mods:note">
                                            <xforms:label>Note(s): </xforms:label>
                                        </xforms:textarea>
                                    </p>

                                </div>
                                <dl class="optionalElements">
                                    <dt>Optional Fields</dt>
                                    <dd>
                                        <xforms:trigger appearance="minimal" ref="self::node()[count(mods:form) = 0]">
                                            <xforms:label><img src="../styles/images/add.gif"/> Form </xforms:label>
                                            <xforms:insert ev:event="DOMActivate" context="instance('metadata')" nodeset="instance('metadata')/mods:physicalDescription/child::*" at="last()" position="after" origin="instance('template')/mods:physicalDescription/mods:form"/>

                                        </xforms:trigger>
                                    </dd>
                                    <dd>
                                        <xforms:trigger class="add" appearance="minimal" ref="self::node()[count(mods:reformattingQuality) = 0]">
                                            <xforms:label><img src="../styles/images/add.gif"/>Reformatting Quality</xforms:label>
                                            <xforms:insert ev:event="DOMActivate" context="instance('metadata')" nodeset="instance('metadata')/mods:physicalDescription/child::*" at="last()" position="after" origin="instance('template')/mods:physicalDescription/mods:reformattingQuality"/>
                                        </xforms:trigger>
                                    </dd>

                                    <dd>
                                        <xforms:trigger class="add" appearance="minimal" ref="self::node()[count(mods:internetMediaType) = 0]">
                                            <xforms:label><img src="../styles/images/add.gif"/>Internet Media Type </xforms:label>
                                            <xforms:insert ev:event="DOMActivate" context="instance('metadata')" nodeset="instance('metadata')/mods:physicalDescription/child::*" at="last()" position="after" origin="instance('template')/mods:physicalDescription/mods:internetMediaType"/>
                                        </xforms:trigger>
                                    </dd>
                                    <dd>
                                        <xforms:trigger appearance="minimal" ref="self::node()[count(mods:extent) = 0]">

                                            <xforms:label><img src="../styles/images/add.gif"/>Extent </xforms:label>
                                            <xforms:insert ev:event="DOMActivate" context="instance('metadata')" nodeset="instance('metadata')/mods:physicalDescription/child::*" at="last()" position="after" origin="instance('template')/mods:physicalDescription/mods:extent"/>
                                        </xforms:trigger>
                                    </dd>
                                    <dd>
                                        <xforms:trigger class="add" appearance="minimal" ref="self::node()[count(mods:digitalOrigin) = 0]">
                                            <xforms:label><img src="../styles/images/add.gif"/>Digital Origin</xforms:label>
                                            <xforms:insert ev:event="DOMActivate" context="instance('metadata')" nodeset="instance('metadata')/mods:physicalDescription/child::*" at="last()" position="after" origin="instance('template')/mods:physicalDescription/mods:digitalOrigin"/>

                                        </xforms:trigger>
                                    </dd>
                                    <dd>
                                        <xforms:trigger class="add" appearance="minimal" ref="self::node()[count(mods:note) = 0]">
                                            <xforms:label><img src="../styles/images/add.gif"/> Note</xforms:label>
                                            <xforms:insert ev:event="DOMActivate" context="instance('metadata')" nodeset="instance('metadata')/mods:physicalDescription/child::*" at="last()" position="after" origin="instance('template')/mods:physicalDescription/mods:note"/>
                                        </xforms:trigger>
                                    </dd>

                                </dl>
                                <br class="clear"/>
                            </xforms:group>
                        </div>
                    </fieldset>
                    <fieldset>
                        <legend>
                            <xforms:trigger class="add" appearance="minimal">
                                <xforms:label><img src="../styles/images/add.gif" alt="Add"/></xforms:label>

                                    <xforms:insert ev:event="DOMActivate" context="instance('metadata')" nodeset="instance('metadata')/child::*" at="last()" position="after" origin="instance('basic')/mods:abstract"/>
                            </xforms:trigger> Abstract </legend>
                        <xforms:repeat nodeset="instance('metadata')/mods:abstract" id="abstractInfo">
                            <div class="section">
                                <p class="deleteSection">
                                    <xforms:trigger class="delete" appearance="minimal">
                                        <xforms:label><img src="../styles/images/remove.gif" alt="remove"/></xforms:label>
                                        <xforms:delete ev:event="DOMActivate" nodeset="." at="index('abstractInfo')"/>

                                    </xforms:trigger>
                                </p>
                                <div class="left">
                                    <p>
                                        <xforms:input ref="@type">
                                            <xforms:label>Type</xforms:label>
                                            <xforms:trigger class="delete" appearance="minimal">
                                                <xforms:label><img src="../styles/images/remove.gif" alt="remove"/></xforms:label>

                                                <xforms:delete ev:event="DOMActivate" nodeset="." at="index('abstractInfo')"/>
                                            </xforms:trigger>
                                        </xforms:input>
                                    </p>
                                    <p>
                                        <xforms:input ref="@displayLabel">
                                            <xforms:label>Display Label: </xforms:label>
                                            <xforms:trigger class="delete" appearance="minimal">

                                                <xforms:label><img src="../styles/images/remove.gif" alt="remove"/></xforms:label>
                                                <xforms:delete ev:event="DOMActivate" nodeset="." at="index('abstractInfo')"/>
                                            </xforms:trigger>
                                        </xforms:input>
                                    </p>
                                    <xforms:textarea ref=".">
                                        <xforms:label/>
                                    </xforms:textarea>
                                </div>

                                <dl class="optionalElements">
                                    <dt>Optional Fields</dt>
                                    <dd>
                                        <xforms:trigger appearance="minimal" ref="self::node()[not(@type)]">
                                            <xforms:label><img src="../styles/images/add.gif"/>Type </xforms:label>
                                            <xforms:insert ev:event="DOMActivate" context="instance('metadata')" nodeset="instance('metadata')/mods:abstract[index('abstractInfo')]" at="index('abstractInfo')" position="after" origin="instance('template')/mods:abstract/@type"/>
                                        </xforms:trigger>
                                    </dd>

                                    <dd>
                                        <xforms:trigger class="add" appearance="minimal" ref="self::node()[not(@displayLabel)]">
                                            <xforms:label><img src="../styles/images/add.gif"/>Display Label</xforms:label>
                                            <xforms:insert ev:event="DOMActivate" context="instance('metadata')" nodeset="instance('metadata')/mods:abstract[index('abstractInfo')]" at="index('abstractInfo')" position="after" origin="instance('template')/mods:abstract/@displayLabel"/>
                                        </xforms:trigger>
                                    </dd>
                                </dl>
                                <br class="clear"/>

                            </div>
                        </xforms:repeat>
                    </fieldset>
                    <fieldset>
                        <legend>
                            <xforms:trigger class="add" appearance="minimal">
                                <xforms:label><img src="../styles/images/add.gif" alt="Add"/></xforms:label>
                                    <xforms:insert ev:event="DOMActivate" context="instance('metadata')" nodeset="instance('metadata')/child::*" at="last()" position="after" origin="instance('basic')/mods:note"/>
                            </xforms:trigger> Note </legend>

                        <xforms:repeat nodeset="instance('metadata')/mods:note" id="note">
                            <div class="section">
                                <p class="deleteSection">
                                    <xforms:trigger class="delete" appearance="minimal">
                                        <xforms:label><img src="../styles/images/remove.gif" alt="remove"/></xforms:label>
                                        <xforms:delete ev:event="DOMActivate" nodeset="." at="index('note')"/>
                                    </xforms:trigger>
                                </p>
                                <div class="left">

                                    <p>
                                        <xforms:input ref="@type">
                                            <xforms:label>Type</xforms:label>
                                            <xforms:trigger class="delete" appearance="minimal">
                                                <xforms:label><img src="../styles/images/remove.gif" alt="remove"/></xforms:label>
                                                <xforms:delete ev:event="DOMActivate" nodeset="." at="index('note')"/>
                                            </xforms:trigger>
                                        </xforms:input>

                                    </p>
                                    <p>
                                        <xforms:input ref="@displayLabel">
                                            <xforms:label>Display Label: </xforms:label>
                                            <xforms:trigger class="delete" appearance="minimal">
                                                <xforms:label><img src="../styles/images/remove.gif" alt="remove"/></xforms:label>
                                                <xforms:delete ev:event="DOMActivate" nodeset="." at="index('note')"/>
                                            </xforms:trigger>

                                        </xforms:input>
                                    </p>
                                    <xforms:textarea ref=".">
                                        <xforms:label/>
                                    </xforms:textarea>
                                </div>
                                <dl class="optionalElements">
                                    <dt>Optional Fields</dt>

                                    <dd>
                                        <xforms:trigger appearance="minimal" ref="self::node()[not(@type)]">
                                            <xforms:label><img src="../styles/images/add.gif"/>Type </xforms:label>
                                            <xforms:insert ev:event="DOMActivate" context="instance('metadata')" nodeset="instance('metadata')/mods:note[index('note')]" at="index('note')" position="after" origin="instance('template')/mods:note/@type"/>
                                        </xforms:trigger>
                                    </dd>
                                    <dd>
                                        <xforms:trigger class="add" appearance="minimal" ref="self::node()[not(@displayLabel)]">

                                            <xforms:label><img src="../styles/images/add.gif"/>Display Label</xforms:label>
                                            <xforms:insert ev:event="DOMActivate" context="instance('metadata')" nodeset="instance('metadata')/mods:note[index('note')]" at="index('note')" position="after" origin="instance('template')/mods:note/@displayLabel"/>
                                        </xforms:trigger>
                                    </dd>
                                </dl>
                                <br class="clear"/>
                            </div>
                        </xforms:repeat>

                    </fieldset>
                </xforms:case>
                <xforms:case id="case3" selected="flase()">
                    <h3>Subject Analysis</h3>
                    <fieldset>
                        <legend>
                            <xforms:trigger class="add" appearance="minimal">
                                <xforms:label><img src="../styles/images/add.gif" alt="Add"/></xforms:label>

                                    <xforms:insert ev:event="DOMActivate" context="instance('metadata')" nodeset="instance('metadata')/child::*" at="last()" position="after" origin="instance('basic')/mods:typeOfResource"/>
                            </xforms:trigger> Type of Resource </legend>
                        <xforms:repeat nodeset="instance('metadata')/mods:typeOfResource" id="typeReource">
                            <div class="section">
                                <p class="deleteSection">
                                    <xforms:trigger class="delete" appearance="minimal" ref="self::node()[count(../mods:typeOfResource) &gt; 1]">
                                        <xforms:label><img src="../styles/images/remove.gif" alt="Remove"/></xforms:label>
                                        <xforms:delete ev:event="DOMActivate" nodeset="." at="index('typeReource')"/>

                                    </xforms:trigger>
                                </p>
                                <div class="left">
                                    <p>
                                        <xforms:select1 ref=".">
                                            <xforms:label>Type: </xforms:label>
                                            <xforms:item>
                                                <xforms:label>text</xforms:label>

                                                <xforms:value>text</xforms:value>
                                            </xforms:item>
                                            <xforms:item>
                                                <xforms:label>cartographic</xforms:label>
                                                <xforms:value>cartographic</xforms:value>
                                            </xforms:item>
                                            <xforms:item>

                                                <xforms:label>notated music</xforms:label>
                                                <xforms:value>notated music</xforms:value>
                                            </xforms:item>
                                            <xforms:item>
                                                <xforms:label>sound recording</xforms:label>
                                                <xforms:value>sound recording</xforms:value>
                                            </xforms:item>

                                            <xforms:item>
                                                <xforms:label>sound recording-musical</xforms:label>
                                                <xforms:value>sound recording-musical</xforms:value>
                                            </xforms:item>
                                            <xforms:item>
                                                <xforms:label>sound recording-nonmusical</xforms:label>
                                                <xforms:value>sound recording-nonmusical</xforms:value>

                                            </xforms:item>
                                            <xforms:item>
                                                <xforms:label>still image</xforms:label>
                                                <xforms:value>still image</xforms:value>
                                            </xforms:item>
                                            <xforms:item>
                                                <xforms:label>moving image</xforms:label>

                                                <xforms:value>moving image</xforms:value>
                                            </xforms:item>
                                            <xforms:item>
                                                <xforms:label>three dimensional object</xforms:label>
                                                <xforms:value>three dimensional object</xforms:value>
                                            </xforms:item>
                                            <xforms:item>

                                                <xforms:label>software, multimedia</xforms:label>
                                                <xforms:value>software, multimedia</xforms:value>
                                            </xforms:item>
                                            <xforms:item>
                                                <xforms:label>mixed materials</xforms:label>
                                                <xforms:value>mixed materials</xforms:value>
                                            </xforms:item>

                                        </xforms:select1>
                                        <xforms:output ref="@collection">
                                            <xforms:label>Collection: </xforms:label>
                                            <xforms:trigger class="delete" appearance="minimal">
                                                <xforms:label><img src="../styles/images/remove.gif" alt="Remove"/></xforms:label>
                                                <xforms:delete ev:event="DOMActivate" nodeset="." at="index('typeReource')"/>
                                            </xforms:trigger>
                                        </xforms:output>

                                        <xforms:output ref="@manuscript">
                                            <xforms:label>Manuscript: </xforms:label>
                                            <xforms:trigger class="delete" appearance="minimal">
                                                <xforms:label><img src="../styles/images/remove.gif" alt="Remove"/></xforms:label>
                                                    <xforms:delete ev:event="DOMActivate" nodeset="." at="index('typeReource')"/>
                                            </xforms:trigger>
                                        </xforms:output>
                                    </p>

                                </div>
                                <dl class="optionalElements">
                                    <dt>Optional Elements</dt>
                                    <dd>
                                        <xforms:trigger appearance="minimal" ref="self::node()[not(@collection)]">
                                            <xforms:label><img src="../styles/images/add.gif"/>Is a Collection?</xforms:label>
                                            <xforms:insert ev:event="DOMActivate" context="instance('metadata')" nodeset="instance('metadata')/mods:typeOfResource[index('typeReource')]" at="index('titleInfo')" position="after" origin="instance('template')/mods:typeOfResource/@collection"/>
                                        </xforms:trigger>

                                    </dd>
                                    <dd>
                                        <xforms:trigger class="add" appearance="minimal" ref="self::node()[not(@manuscript)]">
                                            <xforms:label><img src="../styles/images/add.gif"/> Is a Manuscript?</xforms:label>
                                            <xforms:insert ev:event="DOMActivate" context="instance('metadata')" nodeset="instance('metadata')/mods:typeOfResource[index('typeReource')]" at="index('titleInfo')" position="after" origin="instance('template')/mods:typeOfResource/@manuscript"/>
                                        </xforms:trigger>
                                    </dd>
                                </dl>

                                <br class="clear"/>
                            </div>
                        </xforms:repeat>
                    </fieldset>
                    <fieldset>
                        <legend>
                            <xforms:trigger class="add" appearance="minimal">
                                <xforms:label><img src="../styles/images/add.gif" alt="Add"/></xforms:label>
                                    <xforms:insert ev:event="DOMActivate" context="instance('metadata')" nodeset="instance('metadata')/child::*" at="last()" position="after" origin="instance('basic')/mods:genre"/>

                            </xforms:trigger>Genre</legend>
                        <xforms:repeat nodeset="instance('metadata')/mods:genre" id="genreInfo">
                            <div class="section">
                                <p class="deleteSection">
                                    <xforms:trigger class="delete" appearance="minimal" ref="self::node()[count(../mods:genre) &gt; 1]">
                                        <xforms:label><img src="../styles/images/remove.gif" alt="Remove"/></xforms:label>
                                        <xforms:delete ev:event="DOMActivate" nodeset="." at="index('genreInfo')"/>
                                    </xforms:trigger>

                                </p>
                                <div class="left">
                                    <p>
                                        <xforms:select1 ref="@authority" class="attribute">
                                            <xforms:label>Select Authority List: </xforms:label>
                                            <xforms:itemset nodeset="instance('genre')/child::*">
                                                <xforms:label ref="@authority"/>
                                                <xforms:value ref="@id"/>

                                            </xforms:itemset>
                                        </xforms:select1>
                                        <xforms:select1 ref=".">
                                            <xforms:label>Genre: </xforms:label>
                                            <xforms:itemset nodeset="instance('genre')/child::*[@id = instance('metadata')/mods:genre[index('genreInfo')]/@authority]/child::*">
                                                <xforms:label ref="."/>
                                                <xforms:value ref="."/>
                                            </xforms:itemset>

                                        </xforms:select1>
                                    </p>
                                </div>
                            </div>
                        </xforms:repeat>
                    </fieldset>
                    <fieldset>
                        <legend> Subject </legend>

                        <div class="lookup">
                            <h3>Look up subjects in authority records</h3>
                            <p>
                                <xforms:input ref="instance('requestSubject')/term" incremental="true">
                                    <xforms:label>
                                        <strong>Find Subjects:</strong>
                                    </xforms:label>
                                    <xforms:action ev:event="xforms-value-changed">

                                        <xforms:send submission="get-name"/>
                                    </xforms:action>
                                </xforms:input>
                                <xforms:trigger class="add">
                                    <xforms:label>Add Selected</xforms:label>
                                        <xforms:insert ev:event="DOMActivate" context="instance('metadata')" nodeset="instance('metadata')/child::*" at="last()" position="after" origin="instance('subjects')/child::*/child::*"/>
                                </xforms:trigger>
                                <xforms:select ref="instance('subjects')/child::*" appearance="full">

                                    <xforms:label/>
                                    <xforms:itemset nodeset="instance('subjectResponse')/child::*">
                                        <xforms:label style="display: block;" ref="child::*/child::*"/>
                                        <xforms:copy ref="child::*"/>
                                    </xforms:itemset>
                                </xforms:select>
                                <br class="clear"/>
                            </p>
                        </div>

                        <br class="clear"/>
                        <xforms:repeat nodeset="instance('metadata')/mods:subject" id="subject">
                            <div class="section">
                                <p class="deleteSection">
                                    <xforms:trigger class="delete" appearance="minimal">
                                        <xforms:label><img src="../styles/images/remove.gif" alt="Remove"/></xforms:label>
                                        <xforms:delete ev:event="DOMActivate" nodeset="." at="index('subject')"/>
                                    </xforms:trigger>
                                </p>

                                <div class="left">
                                    <xforms:output ref="@authority">
                                        <xforms:label>Authority: </xforms:label>
                                    </xforms:output>
                                    <xforms:repeat nodeset="mods:topic" id="topic">
                                        <xforms:output ref=".">
                                            <xforms:label>Topic: </xforms:label>
                                        </xforms:output>

                                    </xforms:repeat>
                                    <xforms:repeat nodeset="mods:name" id="subjectName">
                                        <p>
                                            <xforms:output ref="@type">
                                                <xforms:label>Name Type: </xforms:label>
                                            </xforms:output>
                                        </p>
                                        <p>

                                            <xforms:output ref="@authority">
                                                <xforms:label>Authority: </xforms:label>
                                            </xforms:output>
                                        </p>
                                        <p>
                                            <xforms:output ref="mods:namePart[not(@type='date')]">
                                                <xforms:label>Name: </xforms:label>
                                            </xforms:output>

                                            <xforms:output ref="mods:namePart[@type='date']">
                                                <xforms:label>, </xforms:label>
                                            </xforms:output>
                                        </p>
                                    </xforms:repeat>
                                    <xforms:repeat nodeset="mods:geographic" id="geographic">
                                        <xforms:output ref=".">
                                            <xforms:label>Geographic Area: </xforms:label>

                                        </xforms:output>
                                    </xforms:repeat>
                                    <xforms:repeat nodeset="mods:temporal" id="temporal">
                                        <xforms:output ref=".">
                                            <xforms:label>Time Period: </xforms:label>
                                        </xforms:output>
                                    </xforms:repeat>
                                </div>

                                <br class="clear"/>
                            </div>
                        </xforms:repeat>
                    </fieldset>
                </xforms:case>
                <xforms:case id="case4" selected="flase()">
                    <h3>Relationships</h3>
                    <fieldset>

                        <legend>
                            <xforms:trigger class="add" appearance="minimal">
                                <xforms:label><img src="../styles/images/add.gif" alt="Add"/></xforms:label>
                                    <xforms:insert ev:event="DOMActivate" context="instance('metadata')" nodeset="instance('metadata')/mods:relatedItem" at="last()" position="after" origin="instance('basic')/mods:relatedItem"/>
                            </xforms:trigger> Related Item </legend>
                        <xforms:repeat nodeset="instance('metadata')/mods:relatedItem" id="relatedItem">
                            <div class="section">
                                <p class="deleteSection">

                                    <xforms:trigger class="delete" appearance="minimal">
                                        <xforms:label><img src="../styles/images/remove.gif" alt="remove"/></xforms:label>
                                        <xforms:delete ev:event="DOMActivate" nodeset="." at="index('relatedItem')"/>
                                    </xforms:trigger>
                                </p>
                                <div class="left">
                                    <p>
                                        <xforms:select1 ref="@type">
                                            <xforms:label>Type</xforms:label>

                                            <xforms:item>
                                                <xforms:label>host</xforms:label>
                                                <xforms:value>host</xforms:value>
                                            </xforms:item>
                                            <xforms:item>
                                                <xforms:label>preceding</xforms:label>
                                                <xforms:value>preceding</xforms:value>

                                            </xforms:item>
                                            <xforms:item>
                                                <xforms:label>succeeding</xforms:label>
                                                <xforms:value>succeeding</xforms:value>
                                            </xforms:item>
                                            <xforms:item>
                                                <xforms:label>original</xforms:label>

                                                <xforms:value>original</xforms:value>
                                            </xforms:item>
                                            <xforms:item>
                                                <xforms:label>constituent</xforms:label>
                                                <xforms:value>constituent</xforms:value>
                                            </xforms:item>
                                            <xforms:item>

                                                <xforms:label>series</xforms:label>
                                                <xforms:value>series</xforms:value>
                                            </xforms:item>
                                            <xforms:item>
                                                <xforms:label>Other Version</xforms:label>
                                                <xforms:value>otherVersion</xforms:value>
                                            </xforms:item>

                                            <xforms:item>
                                                <xforms:label>Other Format</xforms:label>
                                                <xforms:value>otherFormat</xforms:value>
                                            </xforms:item>
                                            <xforms:item>
                                                <xforms:label>Is Referenced By</xforms:label>
                                                <xforms:value>isReferencedBy</xforms:value>

                                            </xforms:item>
                                        </xforms:select1>
                                    </p>
                                    <p>
                                        <xforms:input ref="@displayLabel">
                                            <xforms:label>Display Label: </xforms:label>
                                            <xforms:trigger class="delete" appearance="minimal">
                                                <xforms:label><img src="../styles/images/remove.gif" alt="remove"/></xforms:label>

                                                <xforms:delete ev:event="DOMActivate" nodeset="." at="index('relatedItem')"/>
                                            </xforms:trigger>
                                        </xforms:input>
                                    </p>
                                    <p>
                                        <xforms:input ref="@xlink:href">
                                            <xforms:label>Link: </xforms:label>
                                            <xforms:trigger class="delete" appearance="minimal">

                                                <xforms:label><img src="../styles/images/remove.gif" alt="remove"/></xforms:label>
                                                    <xforms:delete ev:event="DOMActivate" nodeset="." at="index('relatedItem')"/>
                                            </xforms:trigger>
                                        </xforms:input>
                                    </p>
                                    <p>
                                        <xforms:input ref="@ID">
                                            <xforms:label>ID: </xforms:label>

                                            <xforms:trigger class="delete" appearance="minimal">
                                                <xforms:label><img src="../styles/images/remove.gif" alt="remove"/></xforms:label>
                                                    <xforms:delete ev:event="DOMActivate" nodeset="." at="index('relatedItem')"/>
                                            </xforms:trigger>
                                        </xforms:input>
                                    </p>
                                    <xforms:group ref="mods:titleInfo">
                                        <p>
                                            <xforms:input ref="mods:title">

                                                <xforms:label>Title: </xforms:label>
                                            </xforms:input>
                                        </p>
                                    </xforms:group>
                                    <p>
                                        <xforms:trigger class="delete" appearance="minimal" ref="mods:note">
                                            <xforms:label><img src="../styles/images/remove.gif" alt="remove"/></xforms:label>
                                            <xforms:delete ev:event="DOMActivate" nodeset="." at="index('relatedItem')"/>

                                        </xforms:trigger>
                                        <xforms:textarea ref="mods:note">
                                            <xforms:label>Note(s):</xforms:label>
                                        </xforms:textarea>    
                                    </p>
                                </div>
                                <dl class="optionalElements">
                                    <dt>Optional Fields</dt>

                                    <dd>
                                        <xforms:trigger appearance="minimal" ref="self::node()[not(@type)]">
                                            <xforms:label><img src="../styles/images/add.gif"/>Type </xforms:label>
                                            <xforms:insert ev:event="DOMActivate" context="instance('metadata')" nodeset="instance('metadata')/mods:relatedItem[index('relatedItem')]" at="index('relatedItem')" position="after" origin="instance('template')/mods:relatedItem/@type"/>
                                        </xforms:trigger>
                                    </dd>
                                    <dd>
                                        <xforms:trigger class="add" appearance="minimal" ref="self::node()[not(@displayLabel)]">

                                            <xforms:label><img src="../styles/images/add.gif"/>Display Label</xforms:label>
                                            <xforms:insert ev:event="DOMActivate" context="instance('metadata')" nodeset="instance('metadata')/mods:relatedItem[index('relatedItem')]" at="index('relatedItem')" position="after" origin="instance('template')/mods:relatedItem/@displayLabel"/>
                                        </xforms:trigger>
                                    </dd>
                                    <dd>
                                        <xforms:trigger class="add" appearance="minimal" ref="self::node()[not(@ID)]">
                                            <xforms:label><img src="../styles/images/add.gif"/>ID</xforms:label>
                                            <xforms:insert ev:event="DOMActivate" context="instance('metadata')" nodeset="instance('metadata')/mods:relatedItem[index('relatedItem')]" at="index('relatedItem')" position="after" origin="instance('template')/mods:relatedItem/@ID"/>

                                        </xforms:trigger>
                                    </dd>
                                    <!-- BUG: insert on xlink:href not working properly -->
                                    <!--  
                                    <dd>
                                        <xforms:trigger class="add" appearance="minimal" ref="self::node()[not(@xlink:href)]">
                                            <xforms:label><img src="../styles/images/add.gif"/>Link</xforms:label>
                                            <xforms:insert ev:event="DOMActivate" context="instance('metadata')" nodeset="instance('metadata')/mods:relatedItem[index('relatedItem')]" at="index('relatedItem')" position="after" origin="instance('template')/mods:relatedItem/@xlink:href"/>
                                        </xforms:trigger>
                                    </dd>
                                    -->
                                    <dd>
                                        <xforms:trigger appearance="minimal" ref="self::node()[count(mods:note) = 0]">
                                            <xforms:label><img src="../styles/images/add.gif"/> Note </xforms:label>
                                            <xforms:insert ev:event="DOMActivate" context="instance('metadata')" nodeset="instance('metadata')/mods:relatedItem[index('relatedItem')]/child::*" at="index('relatedItem')" position="after" origin="instance('template')/mods:relatedItem/mods:note"/>

                                        </xforms:trigger>
                                    </dd>
                                </dl>
                                <br class="clear"/>
                            </div>
                        </xforms:repeat>
                    </fieldset>
                </xforms:case>
                <xforms:case id="case5" selected="false()">

                    <h3>Administrative</h3>
                    <fieldset>
                        <legend>
                            <xforms:trigger class="add" appearance="minimal">
                                <xforms:label><img src="../styles/images/add.gif" alt="Add"/></xforms:label>
                                    <xforms:insert ev:event="DOMActivate" context="instance('metadata')" nodeset="instance('metadata')/child::*" at="last()" position="after" origin="instance('basic')/mods:identifier"/>
                            </xforms:trigger> Identifier </legend>

                        <xforms:repeat nodeset="instance('metadata')/mods:identifier" id="id">
                            <div class="section">
                                <p class="deleteSection">
                                    <xforms:trigger class="delete" appearance="minimal">
                                        <xforms:label><img src="../styles/images/remove.gif" alt="remove"/></xforms:label>
                                        <xforms:delete ev:event="DOMActivate" nodeset="." at="index('id')"/>
                                    </xforms:trigger>
                                </p>
                                <div class="left">

                                    <p>
                                        <xforms:input ref=".">
                                            <xforms:label>ID: </xforms:label>
                                        </xforms:input>
                                        <xforms:input ref="@type">
                                            <xforms:label>Type: </xforms:label>
                                        </xforms:input>
                                    </p>

                                    <p>
                                        <xforms:input ref="@invalid">
                                            <xforms:label>Invalid</xforms:label>
                                            <xforms:trigger class="delete" appearance="minimal" ref=".">
                                                <xforms:label><img src="../styles/images/remove.gif" alt="Remove"/></xforms:label>
                                                <xforms:delete ev:event="DOMActivate" nodeset="." at="index('id')"/>
                                            </xforms:trigger>
                                        </xforms:input>

                                    </p>
                                    <p>
                                        <xforms:input ref="@displayLabel">
                                            <xforms:label>Display Label</xforms:label>
                                            <xforms:trigger class="delete" appearance="minimal" ref=".">
                                                <xforms:label><img src="../styles/images/remove.gif" alt="Remove"/> </xforms:label>
                                                    <xforms:delete ev:event="DOMActivate" nodeset="." at="index('id')"/>
                                            </xforms:trigger>

                                        </xforms:input>
                                    </p>
                                </div>
                                <dl class="optionalElements">
                                    <dt>Optional Fields</dt>
                                    <dd>
                                        <xforms:trigger appearance="minimal" ref="self::node()[not(@invalid)]">
                                            <xforms:label><img src="../styles/images/add.gif"/>Invalid</xforms:label>

                                            <xforms:insert ev:event="DOMActivate" context="instance('metadata')" nodeset="instance('metadata')/mods:identifier[index('id')]" at="index('id')" position="after" origin="instance('template')/mods:identifier/@invalid"/>
                                        </xforms:trigger>
                                    </dd>
                                    <dd>
                                        <xforms:trigger appearance="minimal" ref="self::node()[not(@displayLabel)]">
                                            <xforms:label><img src="../styles/images/add.gif"/>Display Label</xforms:label>
                                            <xforms:insert ev:event="DOMActivate" context="instance('metadata')" nodeset="instance('metadata')/mods:identifier[index('id')]" at="index('id')" position="after" origin="instance('template')/mods:identifier/@displayLabel"/>
                                        </xforms:trigger>

                                    </dd>
                                </dl>
                                <br class="clear"/>
                            </div>
                        </xforms:repeat>
                    </fieldset>
                    <fieldset>
                        <legend>
                            <xforms:trigger class="add" appearance="minimal">

                                <xforms:label><img src="../styles/images/add.gif" alt="Add"/></xforms:label>
                                    <xforms:insert ev:event="DOMActivate" context="instance('metadata')" nodeset="instance('metadata')/child::*" at="last()" position="after" origin="instance('basic')/mods:location"/>
                            </xforms:trigger> Location </legend>
                        <xforms:repeat nodeset="instance('metadata')/mods:location" id="location">
                            <div class="section">
                                <p class="deleteSection">
                                    <xforms:trigger class="delete" appearance="minimal">
                                        <xforms:label><img src="../styles/images/remove.gif" alt="remove"/></xforms:label>

                                            <xforms:delete ev:event="DOMActivate" nodeset="." at="index('location')"/>
                                    </xforms:trigger>
                                </p>
                                <div class="left">
                                    <p>
                                        <xforms:input ref="mods:physicalLocation">
                                            <xforms:label>Physical Location: </xforms:label>
                                            <xforms:trigger class="delete" appearance="minimal" ref=".">

                                                <xforms:label><img src="../styles/images/remove.gif" alt="Remove"/></xforms:label>
                                                <xforms:delete ev:event="DOMActivate" nodeset="." at="index('id')"/>
                                            </xforms:trigger>
                                            <xforms:trigger appearance="minimal" ref="self::node()[not(@authority)]">
                                                <xforms:label><img src="../styles/images/add.gif"/>Add Authority?</xforms:label>
                                                <xforms:insert ev:event="DOMActivate" context="instance('metadata')" nodeset="instance('metadata')/mods:location[index('location')]/mods:physicalLocation" at="index('location')" position="after" origin="instance('template')/mods:location/mods:physicalLocation/@authority"/>
                                            </xforms:trigger>
                                        </xforms:input>

                                    </p>
                                    <p>
                                        <xforms:input ref="mods:physicalLocation/@authority">
                                            <xforms:label>Authority: </xforms:label>
                                            <xforms:trigger class="delete" appearance="minimal" ref=".">
                                                <xforms:label><img src="../styles/images/remove.gif" alt="Remove"/></xforms:label>
                                                <xforms:delete ev:event="DOMActivate" nodeset="." at="index('location')"/>
                                            </xforms:trigger>

                                            <a href="http://www.loc.gov/marc/sourcecode/organization/organizationsource.html">See list</a>
                                        </xforms:input>
                                    </p>
                                    <p>
                                        <xforms:input ref="mods:url">
                                            <xforms:label>URL: </xforms:label>
                                            <xforms:trigger appearance="minimal" ref="self::node()[not(@access)]">
                                                <xforms:label><img src="../styles/images/add.gif"/>Add Access Type?</xforms:label>

                                                <xforms:insert ev:event="DOMActivate" context="instance('metadata')" nodeset="instance('metadata')/mods:location[index('location')]/mods:url" at="index('location')" position="after" origin="instance('template')/mods:location/mods:url/@access"/>
                                            </xforms:trigger>
                                            <xforms:trigger appearance="minimal" ref="self::node()[not(@usage)]">
                                                <xforms:label><img src="../styles/images/add.gif"/>Primary Display?</xforms:label>
                                                <xforms:insert ev:event="DOMActivate" context="instance('metadata')" nodeset="instance('metadata')/mods:location[index('location')]/mods:url" at="index('location')" position="after" origin="instance('template')/mods:location/mods:url/@usage"/>
                                            </xforms:trigger>
                                        </xforms:input>
                                    </p>

                                    <p>
                                        <xforms:select1 ref="mods:url/@access">
                                            <xforms:label>Access: </xforms:label>
                                            <xforms:item>
                                                <xforms:label>Preview</xforms:label>
                                                <xforms:value>preview</xforms:value>
                                            </xforms:item>

                                            <xforms:item>
                                                <xforms:label>Raw Object</xforms:label>
                                                <xforms:value>raw object</xforms:value>
                                            </xforms:item>
                                            <xforms:item>
                                                <xforms:label>Object in Context</xforms:label>
                                                <xforms:value>object in context</xforms:value>

                                            </xforms:item>
                                        </xforms:select1>
                                        <xforms:trigger class="delete" appearance="minimal" ref="mods:url/@access">
                                            <xforms:label><img src="../styles/images/remove.gif" alt="Remove"/></xforms:label>
                                                <xforms:delete ev:event="DOMActivate" nodeset="." at="index('location')"/>
                                        </xforms:trigger>
                                    </p>
                                    <p>
                                        <xforms:output ref="mods:url/@usage">

                                            <xforms:label>Is </xforms:label>
                                            <xforms:trigger class="delete" appearance="minimal" ref=".">
                                                <xforms:label> <img src="../styles/images/remove.gif" alt="Remove"/></xforms:label>
                                                <xforms:delete ev:event="DOMActivate" nodeset="." at="index('location')"/>
                                            </xforms:trigger>
                                        </xforms:output>
                                    </p>

                                </div>
                                <dl class="optionalElements">
                                    <dt>Optional Fields</dt>
                                    <dd>
                                        <xforms:trigger appearance="minimal" ref="self::node()[not(mods:physicalLocation)]">
                                            <xforms:label><img src="../styles/images/add.gif"/>Physical Location</xforms:label>
                                            <xforms:insert ev:event="DOMActivate" context="instance('metadata')" nodeset="instance('metadata')/mods:location[index('location')]/child::*" at="index('location')" position="after" origin="instance('template')/mods:location/mods:physicalLocation[1]"/>
                                        </xforms:trigger>

                                    </dd>
                                </dl>
                                <br class="clear"/>
                            </div>
                        </xforms:repeat>
                    </fieldset>
                    <fieldset>
                        <legend>
                            <xforms:trigger class="add" appearance="minimal">

                                <xforms:label><img src="../styles/images/add.gif" alt="Add"/></xforms:label>
                                    <xforms:insert ev:event="DOMActivate" context="instance('metadata')" nodeset="instance('metadata')/child::*" at="last()" position="after" origin="instance('basic')/mods:accessCondition"/>
                            </xforms:trigger> Access Conditions </legend>
                        <xforms:repeat nodeset="instance('metadata')/mods:accessCondition" id="access">
                            <div class="section">
                                <p class="deleteSection">
                                    <xforms:trigger class="delete" appearance="minimal">
                                        <xforms:label><img src="../styles/images/remove.gif" alt="remove"/></xforms:label>

                                        <xforms:delete ev:event="DOMActivate" nodeset="." at="index('access')"/>
                                    </xforms:trigger>
                                </p>
                                <div class="left">
                                    <p>
                                        <xforms:select1 ref="@type">
                                            <xforms:label>Type</xforms:label>
                                            <xforms:item>

                                                <xforms:label>Use and Reproduction</xforms:label>
                                                <xforms:value>useAndReproduction</xforms:value>
                                            </xforms:item>
                                            <xforms:item>
                                                <xforms:label>Restriction on Access</xforms:label>
                                                <xforms:value>restrictionOnAccess</xforms:value>
                                            </xforms:item>

                                        </xforms:select1>
                                    </p>
                                    <p>
                                        <xforms:input ref="@displayLabel">
                                            <xforms:label>Display Label: </xforms:label>
                                            <xforms:trigger class="delete" appearance="minimal">
                                                <xforms:label><img src="../styles/images/remove.gif" alt="remove"/></xforms:label>
                                                <xforms:delete ev:event="DOMActivate" nodeset="." at="index('access')"/>

                                            </xforms:trigger>
                                        </xforms:input>
                                    </p>
                                    <p>
                                        <xforms:textarea ref=".">
                                            <xforms:label/>
                                        </xforms:textarea>
                                    </p>
                                </div>

                                <dl class="optionalElements">
                                    <dt>Optional Fields</dt>
                                    <!-- Would like to add xlink also, but it seems to be a bit buggy -->
                                    <dd>
                                        <xforms:trigger appearance="minimal" ref="self::node()[not(@type)]">
                                            <xforms:label><img src="../styles/images/add.gif"/>Type </xforms:label>
                                            <xforms:insert ev:event="DOMActivate" context="instance('metadata')" nodeset="instance('metadata')/mods:accessCondition[index('access')]" at="index('access')" position="after" origin="instance('template')/mods:accessCondition/@type"/>
                                        </xforms:trigger>

                                    </dd>
                                    <dd>
                                        <xforms:trigger class="add" appearance="minimal" ref="self::node()[not(@displayLabel)]">
                                            <xforms:label><img src="../styles/images/add.gif"/>Display Label</xforms:label>
                                            <xforms:insert ev:event="DOMActivate" context="instance('metadata')" nodeset="instance('metadata')/mods:accessCondition[index('access')]" at="index('access')" position="after" origin="instance('template')/mods:accessCondition/@displayLabel"/>
                                        </xforms:trigger>
                                    </dd>
                                </dl>

                                <br class="clear"/>
                            </div>
                        </xforms:repeat>
                    </fieldset>
                    <fieldset>
                        <legend>
                            <xforms:trigger class="add" appearance="minimal" ref="self::node()[not(mods:recordInfo)]">
                                <xforms:label><img src="../styles/images/add.gif" alt="Add"/></xforms:label>
                                    <xforms:insert ev:event="DOMActivate" context="instance('metadata')" nodeset="instance('metadata')/child::*" at="last()" position="after" origin="instance('basic')/mods:recordInfo"/>

                            </xforms:trigger> Record Information </legend>
                        <xforms:group ref="instance('metadata')/mods:recordInfo">
                            <div class="section">
                                <p class="deleteSection">
                                    <xforms:trigger class="delete" appearance="minimal">
                                        <xforms:label><img src="../styles/images/remove.gif" alt="remove"/></xforms:label>
                                            <xforms:delete ev:event="DOMActivate" nodeset="."/>
                                    </xforms:trigger>

                                </p>
                                <div class="left">
                                    <p>
                                        <xforms:input ref="mods:recordContentSource">
                                            <xforms:label>Content Source: </xforms:label>
                                            <xforms:trigger class="delete" appearance="minimal">
                                                <xforms:label><img src="../styles/images/remove.gif" alt="remove"/></xforms:label>
                                                <xforms:delete ev:event="DOMActivate" nodeset="."/>

                                            </xforms:trigger>
                                            <xforms:trigger appearance="minimal" ref="self::node()[not(@authority)]">
                                                <xforms:label><img src="../styles/images/add.gif"/>Add Authority?</xforms:label>
                                                <xforms:insert ev:event="DOMActivate" context="instance('metadata')" nodeset="instance('metadata')/mods:recordInfo/mods:recordContentSource" position="after" origin="instance('template')/mods:recordInfo/mods:recordContentSource/@authority"/>
                                            </xforms:trigger>
                                            <a href="http://www.loc.gov/marc/sourcecode/organization/organizationsource.html#orgcodes">View Source Code Lists</a>
                                        </xforms:input>
                                    </p>

                                    <p>
                                        <xforms:input ref="mods:recordContentSource/@authority">
                                            <xforms:label>Authority: </xforms:label>
                                            <xforms:trigger class="delete" appearance="minimal" ref=".">
                                                <xforms:label><img src="../styles/images/remove.gif" alt="Remove"/></xforms:label>
                                                <xforms:delete ev:event="DOMActivate" nodeset="."/>
                                            </xforms:trigger>
                                        </xforms:input>

                                    </p>
                                    <xforms:repeat nodeset="mods:recordCreationDate" id="recordCreationDate">
                                        <p class="date">
                                            <xforms:trigger class="delete" appearance="minimal" ref="self::node()[@point = 'end']">
                                                <xforms:label><img src="../styles/images/remove.gif" alt="Remove"/></xforms:label>
                                                <xforms:action ev:event="DOMActivate">
                                                    <xforms:delete nodeset="self::node()" at="index('recordCreationDate')"/>
                                                    <xforms:delete nodeset="instance('metadata')/mods:recordInfo/mods:recordCreationDate[@point = 'start']/@point" at="index('dateCaptured')"/>
                                                </xforms:action>

                                            </xforms:trigger>
                                            <xforms:trigger class="delete" appearance="minimal" ref="self::node()[not(@point = 'end')]">
                                                <xforms:label><img src="../styles/images/remove.gif"/></xforms:label>
                                                    <xforms:delete ev:event="DOMActivate" nodeset="." at="index('recordCreationDate')"/>
                                            </xforms:trigger>
                                            <xforms:input ref=".[not(@point)]">
                                                <xforms:label>Creation Date: </xforms:label>
                                            </xforms:input>

                                            <xforms:input ref=".[@point = 'start']">
                                                <xforms:label>Creation Date (start): </xforms:label>
                                            </xforms:input>
                                            <xforms:input ref=".[@point = 'end']">
                                                <xforms:label>Creation Date (end): </xforms:label>
                                            </xforms:input>
                                            <xforms:select1 ref="@qualifier">
                                                <xforms:label>Qualifier: </xforms:label>

                                                <xforms:item>
                                                  <xforms:label>Approximate</xforms:label>
                                                  <xforms:value>approximate</xforms:value>
                                                </xforms:item>
                                                <xforms:item>
                                                  <xforms:label>Inferred</xforms:label>
                                                  <xforms:value>inferred</xforms:value>

                                                </xforms:item>
                                                <xforms:item>
                                                  <xforms:label>Questionable</xforms:label>
                                                  <xforms:value>questionable</xforms:value>
                                                </xforms:item>
                                            </xforms:select1>
                                            <xforms:trigger class="delete" appearance="minimal" ref="self::node()[@qualifier]">
                                                <xforms:label><img src="../styles/images/remove.gif" alt="Remove"/></xforms:label>

                                                <xforms:delete ev:event="DOMActivate" nodeset="self::node()/@qualifier" at="index('recordCreationDate')"/>
                                            </xforms:trigger>
                                            <xforms:trigger class="add" appearance="minimal" ref="self::node()[not(@qualifier)]">
                                                <xforms:label>Add qualifier?</xforms:label>
                                                  <xforms:insert ev:event="DOMActivate" nodeset="instance('metadata')/mods:recordInfo/mods:recordCreationDate[index('recordCreationDate')][1]" at="index('recordCreationDate')" context="instance('metadata')/mods:recordInfo/mods:recordCreationDate" origin="instance('template')/mods:recordInfo/mods:recordCreationDate[3]/@qualifier" position="after"/>
                                            </xforms:trigger>
                                            <xforms:trigger class="add" appearance="minimal" ref="self::node()[not(@point)]">
                                                <xforms:label>Add End Date?</xforms:label>

                                                <xforms:action ev:event="DOMActivate">  
                                                    <xforms:insert nodeset="instance('metadata')/mods:recordInfo/mods:recordCreationDate[index('recordCreationDate')]" at="index('recordCreationDate')" context="instance('metadata')/mods:recordInfo/mods:recordCreationDate" origin="instance('template')/mods:recordInfo/mods:recordCreationDate[2]" position="after"/>
                                                    <xforms:insert nodeset="instance('metadata')/mods:recordInfo/mods:recordCreationDate[1]" at="index('recordCreationDate')" context="instance('metadata')/mods:recordInfo/mods:recordCreationDate" origin="instance('template')/mods:recordInfo/mods:recordCreationDate[2]/@point" position="after"/>
                                                    <xforms:setvalue ref="instance('metadata')/mods:recordInfo/mods:recordCreationDate[1]/@point" value="'start'"/>
                                                    <xforms:setvalue ref="instance('metadata')/mods:recordInfo/mods:recordCreationDate[2]/@point" value="'end'"/>
                                                </xforms:action>
                                            </xforms:trigger>
                                        </p>
                                    </xforms:repeat>

                                    <xforms:repeat nodeset="mods:recordChangeDate" id="recordChangeDate">
                                        <p class="date">
                                            <xforms:trigger class="delete" appearance="minimal" ref="self::node()[@point = 'end']">
                                                <xforms:label><img src="../styles/images/remove.gif" alt="Remove"/></xforms:label>
                                                <xforms:action ev:event="DOMActivate">
                                                    <xforms:delete nodeset="self::node()" at="index('recordChangeDate')"/>
                                                    <xforms:delete nodeset="instance('metadata')/mods:recordInfo/mods:recordChangeDate[@point = 'start']/@point" at="index('recordChangeDate')"/>
                                                </xforms:action>
                                            </xforms:trigger>

                                            <xforms:trigger class="delete" appearance="minimal" ref="self::node()[not(@point = 'end')]">
                                                <xforms:label><img src="../styles/images/remove.gif"/></xforms:label>
                                                    <xforms:delete ev:event="DOMActivate" nodeset="." at="index('recordChangeDate')"/>
                                            </xforms:trigger>
                                            <xforms:input ref=".[not(@point)]">
                                                <xforms:label>Date Changed: </xforms:label>
                                            </xforms:input>
                                            <xforms:input ref=".[@point = 'start']">

                                                <xforms:label>Date Changed (start): </xforms:label>
                                            </xforms:input>
                                            <xforms:input ref=".[@point = 'end']">
                                                <xforms:label>Date Changed (end): </xforms:label>
                                            </xforms:input>
                                            <xforms:select1 ref="@qualifier">
                                                <xforms:label>Qualifier: </xforms:label>

                                                <xforms:item>
                                                  <xforms:label>Approximate</xforms:label>
                                                  <xforms:value>approximate</xforms:value>
                                                </xforms:item>
                                                <xforms:item>
                                                  <xforms:label>Inferred</xforms:label>
                                                  <xforms:value>inferred</xforms:value>

                                                </xforms:item>
                                                <xforms:item>
                                                  <xforms:label>Questionable</xforms:label>
                                                  <xforms:value>questionable</xforms:value>
                                                </xforms:item>
                                            </xforms:select1>
                                            <xforms:trigger class="delete" appearance="minimal" ref="self::node()[@qualifier]">
                                                <xforms:label><img src="../styles/images/remove.gif" alt="Remove"/></xforms:label>

                                                <xforms:delete ev:event="DOMActivate" nodeset="self::node()/@qualifier" at="index('recordChangeDate')"/>
                                            </xforms:trigger>
                                            <xforms:trigger class="add" appearance="minimal" ref="self::node()[not(@qualifier)]">
                                                <xforms:label>Add qualifier?</xforms:label>
                                                <xforms:insert ev:event="DOMActivate" nodeset="instance('metadata')/mods:recordInfo/mods:recordChangeDate[index('recordChangeDate')][1]" at="index('recordChangeDate')" context="instance('metadata')/mods:recordInfo/mods:recordChangeDate" origin="instance('template')/mods:recordInfo/mods:recordChangeDate[3]/@qualifier" position="after"/>
                                            </xforms:trigger>
                                            <xforms:trigger class="add" appearance="minimal" ref="self::node()[not(@point)]">
                                                <xforms:label>Add End Date?</xforms:label>

                                                <xforms:action ev:event="DOMActivate">  
                                                    <xforms:insert nodeset="instance('metadata')/mods:recordInfo/mods:recordChangeDate[index('recordChangeDate')]" at="index('recordChangeDate')" context="instance('metadata')/mods:recordInfo/mods:recordChangeDate" origin="instance('template')/mods:recordInfo/mods:recordChangeDate[2]" position="after"/>
                                                    <xforms:insert nodeset="instance('metadata')/mods:recordInfo/mods:recordChangeDate[1]" at="index('recordChangeDate')" context="instance('metadata')/mods:recordInfo/mods:recordChangeDate" origin="instance('template')/mods:recordInfo/mods:recordChangeDate[2]/@point" position="after"/>
                                                    <xforms:setvalue ref="instance('metadata')/mods:recordInfo/mods:recordChangeDate[1]/@point" value="'start'"/>
                                                    <xforms:setvalue ref="instance('metadata')/mods:recordInfo/mods:recordChangeDate[2]/@point" value="'end'"/>
                                                </xforms:action>
                                            </xforms:trigger>
                                            
                                        </p>
                                    </xforms:repeat>

                                    <p>
                                        <xforms:input ref="mods:recordIdentifier">
                                            <xforms:label>Record Identifier:</xforms:label>
                                            <xforms:trigger class="delete" appearance="minimal">
                                                <xforms:label><img src="../styles/images/remove.gif" alt="remove"/></xforms:label>
                                                    <xforms:delete ev:event="DOMActivate" nodeset="."/>
                                            </xforms:trigger>
                                        </xforms:input>

                                        <xforms:input ref="mods:recordIdentifier/@source">
                                            <xforms:label>Source:</xforms:label>
                                            <xforms:trigger class="delete" appearance="minimal">
                                                <xforms:label><img src="../styles/images/remove.gif" alt="remove"/></xforms:label>
                                                    <xforms:delete ev:event="DOMActivate" nodeset="."/>
                                            </xforms:trigger>
                                        </xforms:input>
                                    </p>

                                    <p>
                                        <xforms:trigger class="delete" appearance="minimal" ref="mods:recordOrigin">
                                            <xforms:label><img src="../styles/images/remove.gif" alt="remove"/></xforms:label>
                                                <xforms:delete ev:event="DOMActivate" nodeset="."/>
                                        </xforms:trigger>
                                        <xforms:textarea ref="mods:recordOrigin">
                                            <xforms:label>Record Origin:</xforms:label>
                                        </xforms:textarea>

                                    </p>
                                    <p>
                                        <xforms:group ref="mods:languageOfCataloging">
                                            <xforms:repeat nodeset="mods:languageTerm" id="langTerm">
                                                <p>
                                                  <xforms:input ref=".[not(@type = 'code')]">
                                                      <xforms:label>Language: </xforms:label>
                                                      <xforms:trigger appearance="minimal">

                                                          <xforms:label><img src="../styles/images/remove.gif" alt="Remove"/></xforms:label>
                                                              <xforms:delete ev:event="DOMActivate" nodeset="."/>
                                                      </xforms:trigger>
                                                      <xforms:trigger class="add" appearance="minimal" ref=".[not(following-sibling::*[@type = 'code'])]">
                                                          <xforms:label><img src="../styles/images/add.gif"/>Code</xforms:label>
                                                              <xforms:insert ev:event="DOMActivate" context="instance('metadata')" nodeset="instance('metadata')/mods:recordInfo/mods:languageOfCataloging/child::*" at="index('langInfo')" position="after" origin="instance('template')/mods:recordInfo/mods:languageOfCataloging/mods:languageTerm[@type = 'code']"/>
                                                      </xforms:trigger>
                                                  </xforms:input>

                                                  <xforms:input ref=".[@type = 'code']">
                                                      <xforms:label>Language (code): </xforms:label>
                                                      <xforms:trigger appearance="minimal">
                                                          <xforms:label><img src="../styles/images/remove.gif" alt="Remove"/></xforms:label>
                                                              <xforms:delete ev:event="DOMActivate" nodeset="."/>
                                                      </xforms:trigger>
                                                      <xforms:trigger class="add" appearance="minimal" ref=".[not(preceding-sibling::*[@type = 'text'])]">
                                                          <xforms:label><img src="../styles/images/add.gif"/>Text</xforms:label>

                                                              <xforms:insert ev:event="DOMActivate" context="instance('metadata')" nodeset="instance('metadata')/mods:recordInfo/mods:languageOfCataloging/child::*" at="index('langInfo')" position="after" origin="instance('template')/mods:recordInfo/mods:languageOfCataloging/mods:languageTerm[@type = 'text']"/>
                                                      </xforms:trigger>
                                                  </xforms:input>
                                                </p>
                                                <p>
                                                  <xforms:input ref="@authority" class="attribute">
                                                      <xforms:label>Authority: </xforms:label>
                                                  </xforms:input>

                                                </p>
                                            </xforms:repeat>
                                        </xforms:group>
                                    </p>
                                </div>
                                <dl class="optionalElements">
                                    <dt>Optional Fields</dt>
                                    <dd>

                                        <xforms:trigger appearance="minimal" ref="self::node()[not(mods:recordContentSource)]">
                                            <xforms:label><img src="../styles/images/add.gif"/>Content Source </xforms:label>
                                            <xforms:insert ev:event="DOMActivate" context="instance('metadata')" nodeset="instance('metadata')/mods:recordInfo/child::*" position="after" origin="instance('basic')/mods:recordInfo/mods:recordContentSource"/>
                                        </xforms:trigger>
                                    </dd>
                                    <dd>
                                        <xforms:trigger appearance="minimal" ref="self::node()[not(mods:recordCreationDate)]">
                                            <xforms:label><img src="../styles/images/add.gif"/>Creation Date </xforms:label>

                                            <xforms:insert ev:event="DOMActivate" context="instance('metadata')" nodeset="instance('metadata')/mods:recordInfo/child::*" position="after" origin="instance('template')/mods:recordInfo/mods:recordCreationDate[1]"/>
                                        </xforms:trigger>
                                    </dd>
                                    <dd>
                                        <xforms:trigger appearance="minimal" ref="self::node()[not(mods:recordChangeDate)]">
                                            <xforms:label><img src="../styles/images/add.gif"/>Change Date </xforms:label>
                                            <xforms:insert ev:event="DOMActivate" context="instance('metadata')" nodeset="instance('metadata')/mods:recordInfo/child::*" position="after" origin="instance('template')/mods:recordInfo/mods:recordChangeDate[1]"/>
                                        </xforms:trigger>

                                    </dd>
                                    <dd>
                                        <xforms:trigger appearance="minimal" ref="self::node()[not(mods:recordIdentifier)]">
                                            <xforms:label><img src="../styles/images/add.gif"/>Record Identifier </xforms:label>
                                            <xforms:insert ev:event="DOMActivate" context="instance('metadata')" nodeset="instance('metadata')/mods:recordInfo/child::*" position="after" origin="instance('template')/mods:recordInfo/mods:recordIdentifier"/>
                                        </xforms:trigger>
                                    </dd>
                                    <dd>

                                        <xforms:trigger appearance="minimal" ref="self::node()[not(mods:languageOfCataloging)]">
                                            <xforms:label><img src="../styles/images/add.gif"/>Language of Cataloging </xforms:label>
                                            <xforms:insert ev:event="DOMActivate" context="instance('metadata')" nodeset="instance('metadata')/mods:recordInfo/child::*" position="after" origin="instance('basic')/mods:recordInfo/mods:languageOfCataloging"/>
                                        </xforms:trigger>
                                    </dd>
                                    <dd>
                                        <xforms:trigger appearance="minimal" ref="self::node()[not(mods:recordOrigin)]">
                                            <xforms:label><img src="../styles/images/add.gif"/>Record Origin </xforms:label>

                                            <xforms:insert ev:event="DOMActivate" context="instance('metadata')" nodeset="instance('metadata')/mods:recordInfo" position="after" origin="instance('template')/mods:recordInfo/mods:recordOrigin"/>
                                        </xforms:trigger>
                                    </dd>
                                </dl>
                                <br class="clear"/>
                            </div>
                        </xforms:group>
                    </fieldset>
                </xforms:case>

            </xforms:switch>
            <!-- Not implemented:  mods:part and mods:extension-->
        </div>
</div>

return style:assemble-form((), $style, $model, $content)
