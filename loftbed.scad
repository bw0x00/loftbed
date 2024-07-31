/*
    Variables and globals
*/
// Render Precision
$fn                     =   100;
// colors for model
color_carrier           =   "Blue";
color_placeholder       =   "Yellow";
color_placeholder_soft  =   "Orange";

/*
Dimension definitions; Designed for multiplex
*/
board_thick             =   30;
board_medium            =   21;
board_thin              =   10;

// dimensions of loftbed
bed_height              =   2000;    // distance floor to upper surface of the mattress


// space for slatted frame and mattress
mattress_height         =   200;
mattress_width          =   1200;
mattress_length         =   2000;
slattedframe_height     =   80;
slattedframe_width      =   1200;
slattedframe_length     =   2000;
tolerance_slattedframe  =   5;
lying_surface_height    =   slattedframe_height + mattress_height;
lying_surface_width     =   slattedframe_width + tolerance_slattedframe;
lying_surface_length    =   slattedframe_length + tolerance_slattedframe;

// dimensions slatted frame carrier
carrier_board_width     =   100;
carrier_positionZ       =   bed_height - lying_surface_height;
carrier_total_width     =   lying_surface_width+2*board_medium;
carrier_total_length    =   lying_surface_length+2*board_medium;
bedrail_height          =   250;    // hight of rail above lying_surface
entry_width             =   500;    // width of the entry cutout
entry_height            =   300;    // depth of coutout for entry from top level of rail
entry_radius            =   100;
rail_overhang           =   10;

/*
    Generats a cube and prints the sizes as CSV output via echo. 
    For output, dimensons are sorted to represent a horizontal board.
*/
use <modules/board.scad>
use <modules/pattern.scad>

// Draw a slatted frame and a mattress
use <parts/dummy_lying_surface.scad>

translate([board_medium+tolerance_slattedframe/2,board_medium+tolerance_slattedframe/2,carrier_positionZ])
    lying_surface([slattedframe_length,slattedframe_width,slattedframe_height],color_placeholder,
                  [mattress_length,mattress_width,mattress_height],color_placeholder_soft);

use <parts/framecarrier.scad>

module posts() {
    module post() {
        translate([(carrier_board_width-board_thick)/2,board_medium,0])
            board([board_thick,carrier_board_width,carrier_height-board_thick]);
        translate([0,0,0])
            board([carrier_board_width,board_medium,carrier_height-board_thick-rail_overhang]);    
//        translate([0,board_medium+carrier_board_width,0])
//            board([carrier_board_width,board_medium,carrier_height-board_thick+rail_overhang]);
        
    }
    for(i=[0,1])
        translate([50+i*(carrier_total_length-carrier_board_width-2*50),0,0]) post();
    
}

color(color_carrier)
translate([0,0,carrier_positionZ-board_thick])
    framecarrier(   [lying_surface_length,lying_surface_width,lying_surface_height+bedrail_height],
                    [entry_width,entry_height,entry_radius],
                    carrier_board_width,board_thick,board_medium,rail_overhang);

// test pattern for side rails
difference(){
    cube([2000,1200,board_medium]);
    pattern_two_triangle([500,1200,board_medium],40);
}
// TODO
// color("Red") posts();
