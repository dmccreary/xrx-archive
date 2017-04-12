xquery version "1.0";

(: XRX support module for Ecology Metadata Language
   Dan McCreary
   June, 2012 :)

module namespace e = "http://www.danmccreary.com/ecology-metadata";

(: put this line in your file to import these funtions:
import module namespace e = "http://www.danmccreary.com/ecology-metadata" at "../modules/eml-module.xqm";
:)
declare namespace eml="eml://ecoinformatics.org/eml-2.1.0";

declare namespace res="eml://ecoinformatics.org/resource-2.1.0";
declare namespace doc="eml://ecoinformatics.org/documentation-2.1.0";
declare namespace att="eml://ecoinformatics.org/attribute-2.1.0";
declare namespace spref="eml://ecoinformatics.org/spatialReference-2.1.0";
declare namespace ent="eml://ecoinformatics.org/entity-2.1.0";
declare namespace acc="eml://ecoinformatics.org/access-2.1.0";
declare namespace prot="eml://ecoinformatics.org/protocol-2.1.0";
declare namespace ds="eml://ecoinformatics.org/dataset-2.1.0";
declare namespace cit="eml://ecoinformatics.org/literature-2.1.0";
declare namespace sw="eml://ecoinformatics.org/software-2.1.0";
declare namespace rp="eml://ecoinformatics.org/party-2.1.0";
declare namespace cov="eml://ecoinformatics.org/coverage-2.1.0";
declare namespace proj="eml://ecoinformatics.org/project-2.1.0";
declare namespace txt="eml://ecoinformatics.org/text-2.1.0";
declare namespace v="eml://ecoinformatics.org/view-2.1.0";
declare namespace sp="eml://ecoinformatics.org/storedProcedure-2.1.0";
declare namespace sv="eml://ecoinformatics.org/spatialVector-2.1.0";
declare namespace md="eml://ecoinformatics.org/methods-2.1.0";
declare namespace sr="eml://ecoinformatics.org/spatialRaster-2.1.0";
declare namespace dat="eml://ecoinformatics.org/dataTable-2.1.0";
declare namespace phys="eml://ecoinformatics.org/physical-2.1.0";
declare namespace unit="eml://ecoinformatics.org/units-2.1.0";
declare namespace xsi="http://www.w3.org/2001/XMLSchema-instance";

(: put this line in your file to import these funtions:

import module template = "http://www.danmccreary.com/ecology-metadata" at "../../../modules/eml-module.xqm";

:)

declare namespace request="http://exist-db.org/xquery/request";
declare namespace xf="http://www.w3.org/2002/xforms";
declare namespace xrx="http://code.google.com/p/xrx";

(: we are going to hard code this path so we don't want to import the style module.  This avoids import loops.  :)
declare variable $e:app-home := '/db/dma/apps/eml';
declare variable $e:data-collection := concat($e:app-home, '/data');

declare function e:get($dataset-id as xs:string) as node() {
collection($temp:data-collection)/eml:eml[eml:dataset/@id=$dataset-id]
};

declare function e:title($dataset-id as xs:string) as xs:string {
collection($e:data-collection)/eml:eml[eml:dataset/@id=$dataset-id]/eml:dataset/eml:title/text()
};
 