 
buggy_width=50;
buggy_length=100;
buggy_height=40;
wall_width=10;
square_height = 5;
lid_height = 2.4;
tut_height = 10;
tut_radius = 4;
$fn = 64;

module bogie_lid() {
  difference() {
    difference() {
      cylinder(h=tut_height, r1= tut_radius, r2=tut_radius);
      cube(size=[20,2,21], center=true);
 }
  cylinder(h=tut_height+1, r1=tut_radius-2, r2=tut_radius-2);
 }
  cube(size=[buggy_width-wall_width+5, buggy_length-wall_width+5, square_height], center=true);
  translate([0,0,lid_height]){ 
     cube(size=[buggy_width, buggy_length, lid_height], center=true);
  }
}

bogie_lid();