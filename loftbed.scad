/*
    Variables and globals
*/
// Render Precision
$fn                         =   50;
// colors for model
color_carrier               =   "Blue";
color_placeholder           =   "Yellow";
color_placeholder_soft      =   "Orange";

/*
Dimension definitions; Designed for multiplex
*/
board_thick                 =   30;
board_medium                =   21;
board_thin                  =   10;

// dimensions of loftbed
bed_height                  =   2000;    // distance floor to upper surface of the mattress


// space for slatted frame and mattress
mattress_height             =   200;
mattress_width              =   1200;
mattress_length             =   2000;
slattedframe_height         =   80;
slattedframe_width          =   1200;
slattedframe_length         =   2000;
tolerance_slattedframe      =   5;
lying_surface_height        =   slattedframe_height + mattress_height;
lying_surface_width         =   slattedframe_width + tolerance_slattedframe;
lying_surface_length        =   slattedframe_length + tolerance_slattedframe;

// dimensions slatted frame carrier
carrier_board_width         =   100;
carrier_positionZ           =   bed_height - lying_surface_height;
carrier_total_depth         =   lying_surface_width+2*board_medium;
carrier_total_width         =   lying_surface_length+2*board_medium;
bedrail_height              =   250;    // hight of rail above lying_surface
entry_width                 =   500;    // width of the entry cutout
entry_height                =   300;    // depth of coutout for entry from top level of rail
entry_radius                =   50;
entry_positionZ             =   carrier_positionZ+lying_surface_height;
rail_overhang               =   10;

// dimension of structure
structure_offset            = 30;
structure_carrier_tolerance = 1;
structure_width             = carrier_total_width- structure_offset*2;
structure_depth             = carrier_total_depth - structure_carrier_tolerance;
structure_height            = carrier_positionZ;
post_width                  = carrier_board_width;
post_depth                  = carrier_board_width+board_medium;
post_height                 = structure_height+rail_overhang;

/*
    Generats a cube and prints the sizes as CSV output via echo. 
    For output, dimensons are sorted to represent a horizontal board.
*/
use <modules/board.scad>
use <modules/pattern.scad>

// Draw a slatted frame and a mattress
use <parts/dummy_lying_surface.scad>

translate([board_medium+tolerance_slattedframe/2,board_medium+tolerance_slattedframe/2,
            carrier_positionZ+rail_overhang+board_thick])
    lying_surface([slattedframe_length,slattedframe_width,slattedframe_height],color_placeholder,
                  [mattress_length,mattress_width,mattress_height],color_placeholder_soft);

// the bad as if it would be placed on the floor without the loft
use <parts/framecarrier.scad>

color(color_carrier)
translate([0,0,carrier_positionZ])
    framecarrier(   [lying_surface_length,lying_surface_width,lying_surface_height+bedrail_height],
                    [entry_width,entry_height,entry_radius],
                    carrier_board_width,board_thick,board_medium,rail_overhang);


use <parts/structure.scad>
translate([structure_offset,0,0])
    scaffolding([structure_width,structure_depth-structure_carrier_tolerance,structure_height],
                [post_width,post_depth,post_height],
                [entry_width,entry_height],entry_positionZ,
                rail_overhang,board_thick,board_medium); 

