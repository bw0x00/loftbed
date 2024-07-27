// Render Precision
$fn=50;


module lying_surface(frame=[2000,1200,80],frame_color="yellow",mattress=[2000,1200,20],mattress_color="orange"){
    // module to draw a dummy frame
    module slattedframe(){
        framebeam_width = 30;
        slat_height     = 10;
        slat_width      = 50;
        slat_number     = 10;
        slat_distance   = (frame[0]-(slat_number+1)*slat_width)/slat_number;

        cube([frame[0],framebeam_width,frame[2]-slat_height]);
        translate([0,frame[1]-framebeam_width,0]){
            cube([frame[0],framebeam_width,frame[2]-slat_height]);
        };
        for(i=[0:1:slat_number])
            translate([i*slat_width+i*slat_distance,0,frame[2]-slat_height]){
                cube([slat_width,frame[1],slat_height]);
            };
    }

    // module to draw a dummy mattress
    module mattress(){
        cube([mattress[0],mattress[1],mattress[2]]);
    }

    color(frame_color) slattedframe();
    color(mattress_color) translate([0,0,frame[2]]){mattress();}
}

