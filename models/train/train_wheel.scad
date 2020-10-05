use <Getriebe.scad>
$fn=50;

outer_radius = 23;
inner_radius = 17;
inner_radius_top = 16;
drive_width = 8;
tread_width = 2;

whole_size = 3;

difference() {
  union() {
    cylinder(r=inner_radius, h=drive_width, r2=inner_radius_top, center=false);
    cylinder(r=outer_radius, h=tread_width, r2=inner_radius, center=false);
  };
  translate([0, 0, -5]) {
    cylinder(r=whole_size, h=20, center=false);
  }
  translate([0, 0, 6]) {
    cylinder(r=inner_radius-5, h=10, center=false);
  }
}