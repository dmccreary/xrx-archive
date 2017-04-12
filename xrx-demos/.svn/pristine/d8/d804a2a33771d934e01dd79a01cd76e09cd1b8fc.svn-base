xquery version "1.0";
declare namespace exist="http://exist.sourceforge.net/NS/exist";
declare option exist:serialize "method=html media-type=text/html indent=yes";
import module namespace cms = "http://cms.metadata.thrivent.com" at "/db/mdr/cms/cms-module.xq";

let $doc := '/db/mdr/patterns/eip/patterns.xml'

let $count := count(doc($doc)/PatternLibrary/Pattern)

return
<PatternLibrary>
{
                for $pattern in doc($doc)/PatternLibrary/Pattern
                return
                <Pattern>
                    <Classifier>{$pattern/Classifier/text()}</Classifier>
                    <PatternName>{$pattern/TD[2]/pattern-name/text()}</PatternName>
                    <Image><img>{$pattern/TD[1]/img/@src}</img></Image>
                    <Reference>{$pattern/TD[2]/reference/text()}</Reference>
                    <Description>{$pattern/TD[3]/text()}</Description>
                </Pattern>
              }
</PatternLibrary>

