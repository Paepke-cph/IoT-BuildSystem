use <dc_motor.scad>
use <Gears.scad>

$fn=50;

buggy_width=50;
buggy_length=100;
buggy_height=40;
wall_width=10;

translate([0, 0, -10]) {
 dc_enginge_mount();
}

translate([-100, 0, 0]) {
  gear_axle();
}

module dc_enginge_mount() {
  difference() {
    cube(size=[buggy_width, 20, 15], center=true);
    translate([0, -15, 5]) {
      rotate([0, 0, 90]) {
        hobby_dc_motor();
      }
    }
    translate([15, 0, 0]) {
      cylinder(r=3, h=20, center=true);
    }
    translate([-15, 0, 0]) {
      cylinder(r=3, h=20, center=true);
    }
  }
  }