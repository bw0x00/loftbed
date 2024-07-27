/*
    Variables and globals
*/
// Render Precision
$fn                     =   80;
// board_ID counter for CSV output
board_id                =   0;
csv_sep                 =   ";";
// colors for model
color_carrier           =   "Blue";
color_placeholder       =   "Yellow";
color_placeholder_soft  =   "Orange";

/*
Dimension definitions
*/
board_thick             =   30;
board_medium            =   21;

// dimensions of loftbed
entry_height            =   2000;    // distance floor to upper surface of the mattress
bedrail_height          =   250;     // hight of rail above lying_surface


// space for slatted frame and mattress
mattress_height         =   200;
mattress_width          =   1200;
mattress_length         =   2000;
slattedframe_height     =   80;
slattedframe_width      =   1200;
slattedframe_length     =   2000;
tolerance_slattedframe  =   10;
lying_surface_height    =   slattedframe_height + mattress_height;
lying_surface_width     =   slattedframe_width + tolerance_slattedframe;
lying_surface_length    =   slattedframe_length + tolerance_slattedframe;

// dimensions slatted frame carrier
carrier_board_width     =   100;
carrier_height          =   entry_height - lying_surface_height;
carrier_total_width     =   lying_surface_width+2*board_medium;
carrier_total_length    =   lying_surface_length+2*board_medium;;

/*
    Generats a cube and prints the sizes as CSV output via echo. 
    For output, dimensons are sorted to represent a horizontal board.
*/
module board(size=[1,1,1], center=false) {
    function quicksort(arr) = !(len(arr)>0) ? [] : let(
        pivot   = arr[floor(len(arr)/2)],
        lesser  = [ for (y = arr) if (y  < pivot) y ],
        equal   = [ for (y = arr) if (y == pivot) y ],
        greater = [ for (y = arr) if (y  > pivot) y ]
        ) concat(
            quicksort(lesser), equal, quicksort(greater)
        );
    cube(size,center);
    s_size = quicksort(size);
    echo(str("CSV:",board_id,csv_sep,s_size[0],csv_sep,s_size[1],csv_sep,s_size[2]));
}

// Draw a slatted frame and a mattress
use <dummy_lying_surface.scad>

translate([board_medium+tolerance_slattedframe/2,board_medium+tolerance_slattedframe/2,carrier_height])
    lying_surface([slattedframe_length,slattedframe_width,slattedframe_height],color_placeholder,
                  [mattress_length,mattress_width,mattress_height],color_placeholder_soft);

module framecarrier() {
    length = carrier_total_length; 
    width = carrier_total_width;

    for (i=[0,1,1]){
        // carrier element
        translate([0,board_medium+i*(width-carrier_board_width-board_medium),0])
            board([length,carrier_board_width,board_thick]);
        // rail element head and foot
        translate([i*(length-board_medium),board_medium,board_thick])
            board([board_medium,width-board_medium,bedrail_height+lying_surface_height]);
        // rail element sides
        translate([0,i*(width),0])
           board([length,board_medium,bedrail_height+lying_surface_height+board_thick]);
    }
}

color(color_carrier)
    translate([0,0,carrier_height-board_medium]) framecarrier();
