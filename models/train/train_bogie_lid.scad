/* Params
bogie_width,
bogie_length,
bogie_height,
bogie_wall_width,
square_height,
lid_height,
connector_height,
connector_radius_outer,
connector_radius_inner,
at_center
*/
module bogie_lid(bogie_width,bogie_length,bogie_height,bogie_wall_width,square_height,lid_height,
                  connector_height,connector_radius_outer,connector_radius_inner,at_center) {
  difference() {
    union() {
      cylinder(h=connector_height, r=connector_radius_outer);
      cube(size=[bogie_width-bogie_wall_width+5, bogie_length-bogie_wall_width+5, square_height], center=at_center);
      difference(){
        translate([0,0,lid_height]){ 
          cube(size=[bogie_width, bogie_length, lid_height], center=at_center);
        }
        translate([0,0,2.4]) {
          cylinder(h=5, r=9.5);
        }
      }
    }
    translate([0,0,-20]) {
      cylinder(h=40,r=connector_radius_inner);
    }
  }
}
//9 højden 19 bredte 8 hullet