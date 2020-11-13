// motor_diameter = 25;
// motor_height = 30.8;
// motor_shaft_d = 7;
// motor_shaft_length = 12;

// bogie_width=50-10;
// bogie_height=40-10;

// motor_mount_thickness=motor_height/2;

module motor_mount(motor_diameter,motor_height,motor_shaft_d,motor_shaft_length,bogie_width,bogie_height,motor_mount_thickness,at_center) {
  $fn = 64;
  difference() {
    cube(size=[bogie_height, bogie_width, motor_mount_thickness], center=at_center);
    translate([bogie_height/2, bogie_width/2, 0]) {
      translate([0, 0, 5]) {
        cylinder(d=motor_diameter, h=motor_height+2, center=at_center);
      }
      translate([0, 0, -1]) {
        cylinder(d=motor_shaft_d, h=motor_shaft_length, center=at_center);
      }
      translate([0, 8.5, -1]) {
        cylinder(d=2.5, h=20, center=at_center);
      }
      translate([0, -8.5, -1]) {
        cylinder(d=2.5, h=20, center=at_center);
      }
      translate([0, 18, motor_mount_thickness/2]) {
        rotate([0, 90, 0]) {
          cylinder(d=3, h=50, center=!at_center);
        }
      }
      translate([0, -18, motor_mount_thickness/2]) {
        rotate([0, 90, 0]) {
          cylinder(d=3, h=50, center=!at_center);
        }
      }
    }
  }
}
