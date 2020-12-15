
// bogie_width=50;
// bogie_length=100;
// bogie_height=40;
// bogie_wall_width=10;
// lid_square_height = 5;
// lid_height = 2.4;
// lid_connector_height = 10;
// lid_connector_radius_outer = 4;
// lid_connector_depth = 15;
// $fn = 64;

// train_length = 250;
// train_width = 120;
// train_height = 120;
// train_wall_thickness = 10;
// train_bottom_thickness = train_wall_thickness*2;


module train(
              bogie_width,
              bogie_length,
              bogie_height,
              bogie_wall_width,
              lid_square_height,
              lid_height,
              lid_connector_height,
              lid_connector_radius_outer,
              lid_connector_depth,
              train_width,
              train_length,
              train_height,
              train_wall_thickness,
              train_bottom_thickness,
              at_center,
              with_sides
              ) {
  adjust = train_wall_thickness / 2; 
  // Creating bottom of train, and 2 x "lady-parts" ;-)
  difference() {
    cube(size=[train_length,train_width,train_bottom_thickness], center=at_center);
    translate([(train_length/2)-(bogie_length/3)+5,0,0]){
      cylinder(h=train_bottom_thickness+1, r = lid_connector_radius_outer, center=at_center);
    }
    translate([(-train_length/2)-(-bogie_length/3)-5,0,0]){
      cylinder(h=train_bottom_thickness+1, r = lid_connector_radius_outer, center=at_center);
    }
    translate([(train_length/2)-(bogie_length/3-5),0,-9]){
      rotate([180,0,0]) {
        cylinder(h=lid_connector_depth, r=lid_connector_radius_outer+1,center=at_center);
      }
    }
    translate([(-train_length/2)-(-bogie_length/3+5),0,-9]){
      rotate([180,0,0]) {
        cylinder(h=lid_connector_depth, r=lid_connector_radius_outer+1,center=at_center);
      }
    }
  }    

  if(with_sides) {
  // Side 1
    translate([0, ((train_width/2)-adjust),(train_height/2)]) {
      rotate([90,0,0]) {
        cube([train_length,train_height,train_wall_thickness], center=at_center);
      }
    }
    // Side 2
    translate([0, -((train_width/2)-adjust),(train_height/2)]) {
      rotate([90,0,0]) {
        cube([train_length,train_height,train_wall_thickness], center=at_center);
      }
    }
    // Front
    translate([-(train_length/2)+adjust,0,train_height/2]) {  
      rotate([0, 0, 90]) {
        cube([train_width,train_wall_thickness,train_height], center=at_center);
      }
    }

    // translate([(train_length/2)-adjust, 0, train_height/2]) {
    //   difference() {   
    //     rotate([0, 0, 90]) {
    //       cube([train_width,train_wall_thickness,train_height], center=at_center);
    //     }
    //     // translate([-10, -5, ((train_height/2)-12)-(train_height/2)-5]) {
    //     //   #cube([20,12,12]);
    //     // }
    //     // translate([-10, -35, ((train_height/2)-13)-(train_height/2)-5]) {
    //     //   #cube([20,13,13]);
    //     // }
    //   }
    // }
  }
}


train();