/*
    Generate a traingle based pattern within a rectangular of size
*/
module pattern_two_triangle(size,r) {
    sp = 0.2;
    l   =   size[0];
    w   =   size[1];
    h   =   size[2] + sp;
    r = is_undef(r) ? (w+l)/40 : r;

    // distance (90°) between triangles = r
    dist = sqrt(7*r*r);

    // devide rectangle in 2 triangles
    translate([0,0,-sp/2]) {
        #linear_extrude(height=h){
            hull(){
                translate([r          ,r+dist   ,0]) circle(r);             
                translate([r          ,w-r      ,0]) circle(r);
                translate([l-r-dist   ,w-r      ,0]) circle(r);
            }
            hull(){
                translate([r+dist     ,r        ,0]) circle(r);             
                translate([l-r        ,r        ,0]) circle(r);
                translate([l-r        ,w-r-dist ,0]) circle(r);
            }
        }
    }
}

/*
	Fill a rectangle with pattern_elements repetitions of pattern_two_triange
*/
module rectangle_pattern_filled(pattern_w,pattern_h,pattern_thickness,pattern_boarder,pattern_elements){
    pattern_subelement_w = (pattern_w-(pattern_elements-1)*pattern_boarder)/pattern_elements;
	sp = 0.2;

    for(i=[0:pattern_elements-1]) {
    	translate([i*pattern_subelement_w+i%2*pattern_subelement_w+i*pattern_boarder,0,0])
        	mirror([i%2,0,0])
            	pattern_two_triangle([pattern_subelement_w,
                                      pattern_h,pattern_thickness+sp],
                	                  pattern_boarder/2);
	}
}
