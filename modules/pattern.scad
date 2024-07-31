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
                translate([2*r          ,2*r+dist   ,0]) circle(r);             
                translate([2*r          ,w-2*r      ,0]) circle(r);
                translate([l-2*r-dist   ,w-2*r      ,0]) circle(r);
            }
            hull(){
                translate([2*r+dist     ,2*r        ,0]) circle(r);             
                translate([l-2*r        ,2*r        ,0]) circle(r);
                translate([l-2*r        ,w-2*r-dist ,0]) circle(r);
            }
        }
    }


}
