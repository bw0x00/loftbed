// Render Precision
$fn=50;

/*
Dimension definitions
*/
structural_thickness    =   21;
color_loadbearing       =   "Blue";
color_placeholder       =   "Yellow";
color_placeholder_soft  =   "Orange";

tolerance_slattedframe  =   10;

// space for slatted frame and mattress
mattress_height         =   200;
mattress_width          =   1200;
mattress_length         =   2000;
slattedframe_height     =   80;
slattedframe_width      =   1200;
slattedframe_length     =   2000;
lying_surface_height    =   slattedframe_height + mattress_height + tolerance_slattedframe;
lying_surface_width     =   slattedframe_width + tolerance_slattedframe;
lying_surface_length    =   slattedframe_length + tolerance_slattedframe;

// dimensions of loftbed
entry_height            =   2000;    // distance floor to upper surface of the mattress
bedrail_height          =   250; 

// Draw a slatted frame and a mattress
use <dummy_lying_surface.scad>

translate([0,0,entry_height - lying_surface_height])
    lying_surface([slattedframe_length,slattedframe_width,slattedframe_height],color_placeholder,
                  [mattress_length,mattress_width,mattress_height],color_placeholder_soft);


