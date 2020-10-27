motor_diameter = 24.4;
motor_height = 30.8;
motor_shaft_d = 6.4;
motor_shaft_length = 12;

bogie_width=50;
bogie_height=40;

motor_mount_thickness=motor_height/2;


motor_mount();

module motor_mount() {
  $fn = 64;
  difference() {
    cube(size=[bogie_height, bogie_width, motor_mount_thickness], center=false);
    translate([bogie_height/2, bogie_width/2, 0]) {
      translate([0, 0, 5]) {
        cylinder(d=motor_diameter, h=motor_height+2, center=false);
      }
      translate([0, 0, -1]) {
        cylinder(d=motor_shaft_d, h=motor_shaft_length, center=false);
      }
      translate([0, 8.5, -1]) {
        cylinder(d=2.5, h=20, center=false);
      }
      translate([0, -8.5, -1]) {
        cylinder(d=2.5, h=20, center=false);
      }
      translate([0, 18, motor_mount_thickness/2]) {
        rotate([0, 90, 0]) {
          cylinder(d=3, h=50, center=true);
        }
      }
      translate([0, -18, motor_mount_thickness/2]) {
        rotate([0, 90, 0]) {
          cylinder(d=3, h=50, center=true);
        }
      }
    }
  }
}
