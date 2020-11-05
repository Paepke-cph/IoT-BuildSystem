 
buggy_width=50;
buggy_length=100;
buggy_height=40;
wall_width=10;
square_height = 5;
lid_height = 2.4;
tut_height = 10;
tut_radius = 4;
hole_depth = 15;
$fn = 64;

module bogie_lid() {
  difference() {
  difference() {
  cube(size=[buggy_width-wall_width+5, buggy_length-wall_width+5, hole_depth], center=true);
      cylinder(h=tut_height+1, r1=tut_radius+1, r2=tut_radius+1);
  }
  translate([0,0,7]) 
  cylinder(h=2, r1=9.5, r2=9.5, center = true);
}
}
bogie_lid();