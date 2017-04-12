function makeGraph (evt, amp, period) {
        
        var startx = 0;
        var length = 300; 
        var times = 300;
        
        if ( window.svgDocument == null )
            svgDocument = evt.target.ownerDocument;

        var svgns = "http://www.w3.org/2000/svg";
        
        shape = svgDocument.createElementNS(svgns, "polyline");

        shape.setAttributeNS(null, "fill", "none");
        shape.setAttributeNS(null, "stroke", "black");
        
        var interval = 1;
        var pString = "";
        
        for (x = startx; x < startx + length; x = x + interval) {
                pString = pString + " " + (x) + "," + -(Math.sin(x/period)) * 50 * amp;
        }

        shape.setAttributeNS(null, "points", pString);
            
        svgDocument.getElementById("draw-line").appendChild(shape);
        window.status = "Graph plotted";

    }

function overGraph (evt) {
    var shape = svgDocument.getElementById("marker");
    x = (evt.clientX-10)/170 * 100 -50;
    window.status = "Graph plotted" + x;
    shape.setAttributeNS(null, "cx", x);
    shape.setAttributeNS(null, "cy", -( (Math.sin(x))));
}