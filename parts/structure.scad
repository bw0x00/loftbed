use <../modules/board.scad>

/* 
	Generate Scaffolding of the loftbed
*/
module scaffolding(scaffolding_dimension,post_dimension,rail_overhang,board_thick,board_medium) {

    module post() {
		translate([(post_dimension[1]-board_thick)/2,board_medium,0])
            board([board_thick,post_dimension[1]-board_medium,post_dimension[2]]);
        board([post_dimension[1],board_medium,post_dimension[2]-rail_overhang]);

    }
	for(i=[0,1])
        translate([i*(scaffolding_dimension[0]-post_dimension[1]),0,0]) post();

}

