xquery version "1.0";
import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";
declare option exist:serialize "method=xhtml media-type=text/html omit-xml-declaration=yes indent=yes";

let $page :=
<html>
	<head>
		<script type="text/javascript" language="javascript" src="/rest/db/dma/resources/js/anychart/js/AnyChart5.js"></script>
		<script type="text/javascript" language="javascript" src="dan-auto-save-png-to-server5.js"></script>

		<title>Sample Chart Auto Save</title>
	</head>
	<body>
		<h1>Sample Chart Auto Save</h1>

		<p>When the chart is displayed - <b>saveChartAsImage</b> function is called and
		it gets PNG image of a chart. Then this image is passed to "save-png.xq" script
		which puts a PNG image of a chart to the server "/db/tmp" folder.</p>
		

		
		<!-- report -->
		<div id="report">
			<div id="chart_container"></div>
		</div>
		
		<h2>Listing of /db/tmp/dan*</h2>
		<ul>
		{for $file in xmldb:get-child-resources('/db/tmp')
		   return
		   if (starts-with($file, 'dan'))
		   then
		      <li><a href="/rest/db/tmp/{$file}">{$file} </a> {' '} {xmldb:last-modified('/db/tmp', $file)}</li>
		      else ()
		 }
		</ul>
	</body>
</html>

return $page