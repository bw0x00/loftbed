use <../modules/board.scad>
use <../modules/pattern.scad>

module framecarrier(inner_carrierdimension,entrydimension,carrierboard_width,board_thick,board_medium,rail_overhang) {
    length          = inner_carrierdimension[0] + 2*board_medium; 
    width           = inner_carrierdimension[1] + 2*board_medium;
    height          = inner_carrierdimension[2] + board_thick + rail_overhang;
    boarders        = 40;

    // move carrierboards in 
    //      y to allow addition of rails
    //      z to allow overhang of rails     
    translate([0,board_medium,rail_overhang])
        carrierboards(length,inner_carrierdimension[1]-2*carrierboard_width,carrierboard_width,board_thick);
    
    // side rail with entry cutout
    entry_rail(length,height,board_medium,entrydimension,
                [length-(boarders+entrydimension[0]),height-entrydimension[1]],boarders,5);
    // closed side rail
    translate([0,width-board_medium,0])
        side_rail(length,height,board_medium);

    // head and foot rail
    translate([0,board_medium,rail_overhang+board_thick]) {
        end_rail(width-2*board_medium,height-rail_overhang-board_thick,board_medium);
        translate([length-board_medium,0,0])
            end_rail(width-2*board_medium,height-rail_overhang-board_thick,board_medium);
    }
}

module carrierboards(length,distance,board_width,board_thickness){
    for (i=[0,1]){
        // carrier element
        translate([0,i*(board_width+distance),0])
            board([length,board_width,board_thickness]);
    }
    
}

module entry_rail(length,height,board_thickness,entrydimension,entryposition,pattern_boarder,pattern_elements){
    entry_w = entrydimension[0];
    entry_h = entrydimension[1];
    entry_r = entrydimension[2];
    sp = 0.2;
    
    pattern_w =length-entrydimension[0]-3*pattern_boarder;
    pattern_h = entry_h - pattern_boarder;

    difference(){
        board([length,board_thickness,height]);
        rotate([-90,0,0]){
            translate([entryposition[0],-(height+sp),-sp]){
                color("red")
                #union(){
                    cube([entry_w,entry_h+sp-entry_r,board_thickness+2*sp]);
                    translate([entry_r,entry_h-entry_r,0]) 
                        cube([  entry_w-2*entry_r,
                                entry_r+sp,board_thickness+2*sp]);
                    translate([entry_w-entry_r,entry_h-entry_r+sp,0])
                        cylinder(board_thickness+2*sp,r=entry_r);
                    translate([entry_r,entry_h-entry_r+sp,0])
                        cylinder(board_thickness+2*sp,r=entry_r);
                }
            }
            translate([pattern_boarder,-height+pattern_boarder,0])
                rectangle_pattern_filled(pattern_w,pattern_h,board_thickness,pattern_boarder,pattern_elements);
        }
    }
}

module side_rail(length,height,board_thickness){
    board([length,board_thickness,height]);
}

module end_rail(width,height,board_thickness){
    // rail element head and foot
    board([board_thickness,width,height]);
}

