use <../modules/board.scad>
use <../modules/pattern.scad>

module framecarrier(inner_carrierdimension,entrydimension,carrierboard_width,board_thick,board_medium,rail_overhang) {
    length                  = inner_carrierdimension[0] + 2*board_medium; 
    width                   = inner_carrierdimension[1] + 2*board_medium;
    height                  = inner_carrierdimension[2] + board_thick + rail_overhang;
    boarders                = 40;
    // pattern repetitions fitting into entry 
    entry_pattern_ratio     = 2;

    // size of cutout without boarders in between
    pattern_element_size    = (entrydimension[0]-boarders)/entry_pattern_ratio;
    pattern_n_closed_side   = floor((length-1*boarders-2*board_thick)/(pattern_element_size+boarders));
    pattern_n_entry_side    = pattern_n_closed_side-entry_pattern_ratio;

    // move carrierboards in 
    //      y to allow addition of rails
    //      z to allow overhang of rails     
    translate([0,board_medium,rail_overhang])
        carrierboards(length,inner_carrierdimension[1]-2*carrierboard_width,carrierboard_width,board_thick);
    
    // side rail with entry cutout
    entry_rail(length,height,board_medium,entrydimension,board_thick,
               boarders,pattern_n_entry_side,pattern_element_size);
    // closed side rail
    translate([0,width-board_medium,0])
        side_rail(length,height,board_medium,entrydimension[1],boarders,pattern_n_closed_side,pattern_element_size);

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

module entry_rail(length,height,board_thickness,entrydimension,board_thick,pattern_boarder,pattern_elements,pattern_element_size){
    entry_w                 = entrydimension[0];
    entry_h                 = entrydimension[1];
    entry_r                 = entrydimension[2];
    sp = 0.2;
    
    pattern_w = pattern_elements*(pattern_element_size+pattern_boarder)-pattern_boarder;
    pattern_h = entry_h - pattern_boarder;

    center_offset = (length-(pattern_w+entry_w+3*pattern_boarder))/2;
    // entryposition has pattern_boarder + board_thick distance between the end of pattern and its start
    entryposition = center_offset+2*pattern_boarder+pattern_w+board_thick;

    difference(){
        board([length,board_thickness,height]);
        rotate([-90,0,0]){
            translate([entryposition,-(height+sp),-sp]){
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
            translate([pattern_boarder+center_offset,-height+pattern_boarder,-sp/2])
                #rectangle_pattern_filled(pattern_w,pattern_h,board_thickness+sp,pattern_boarder,pattern_elements);
        }
    }
}

module side_rail(length,height,board_thickness,pattern_h,pattern_boarder,pattern_elements,pattern_element_size){
    sp = 0.2;
    
    pattern_w = pattern_elements*(pattern_element_size+pattern_boarder)-pattern_boarder;
    pattern_h = pattern_h-pattern_boarder;
    
    center_offset = (length-(pattern_w+2*pattern_boarder))/2;


     difference(){
        board([length,board_thickness,height]);
        rotate([-90,0,0]){
            translate([pattern_boarder+center_offset,-height+pattern_boarder,-sp/2])
                #rectangle_pattern_filled(pattern_w,pattern_h,board_thickness+sp,pattern_boarder,pattern_elements);
        }
    }
}

module end_rail(width,height,board_thickness){
    // rail element head and foot
    board([board_thickness,width,height]);
}

