/*
    Variables and globals
*/
// Render Precision
$fn                     =   50;
// board_ID counter for CSV output
board_id                =   0;
csv_sep                 =   ";";
// colors for model
color_loadbearing       =   "Blue";
color_placeholder       =   "Yellow";
color_placeholder_soft  =   "Orange";

/*
Dimension definitions
*/
board_thickness         =   21;

// dimensions of loftbed
entry_height            =   2000;    // distance floor to upper surface of the mattress
bedrail_height          =   250; 


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
carrier_board_width     =   50;
carrier_height          =   entry_height - lying_surface_height;

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
    echo(str("CSV:",board_id,csv_sep,size[0],csv_sep,size[1],csv_sep,size[2]));
}

// Draw a slatted frame and a mattress
use <dummy_lying_surface.scad>

translate([board_thickness+tolerance_slattedframe,tolerance_slattedframe,carrier_height])
    lying_surface([slattedframe_length,slattedframe_width,slattedframe_height],color_placeholder,
                  [mattress_length,mattress_width,mattress_height],color_placeholder_soft);

module framecarrier() {
    length = slattedframe_length+2*(board_thickness+tolerance_slattedframe);
    color(color_loadbearing) {
        board([length,carrier_board_width,board_thickness]);
        translate([0,slattedframe_width-carrier_board_width+2*tolerance_slattedframe,0])
            board([length,carrier_board_width,board_thickness]);
    }
}

translate([0,0,carrier_height-board_thickness]) framecarrier();
