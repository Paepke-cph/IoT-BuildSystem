use <Gears.scad>
use <track-modules.scad>
// Math for rack
pi = 3.14159;
modul = 1.0;
rail_helix_angle = 0;
rail_pressure_angle = 20;
mx = modul/cos(rail_helix_angle);
rail_tip_width = pi*mx/2-2*mx*tan(rail_pressure_angle);

base_length = 149;
base_width = 75;
base_height = 5;

rail_length = base_length;
rail_width = 5;
rail_height = 10;

axle_width = 75;

mc_length = 15;
mc_width = 10;
mc_height = base_height;

module base(length, width, height) {
    cube([length,width,height], center=true);
}

module rail() {
    color("blue") {
            translate([0,rail_width,rail_height/4])
                rotate(90,[1,0,0])
                    rack(modul, rail_length, rail_width, rail_height, rail_pressure_angle, rail_helix_angle);
            
    }
}

module track(length, width, height) {
    base(base_length,base_width,base_height);
    translate([0,0,base_height/2 + (rail_height/4)]) {
        translate([rail_tip_width-rail_tip_width-0.2,(axle_width/2) - (rail_height/2),0])
            rail();
        translate([rail_tip_width-rail_tip_width-0.2,-(axle_width/2) + (rail_height/2),0])
            rail();
    }
}

tolerance = 0.4;
module male_connector(from_center) {
    color("red") {
        translate([(base_length/2)+(mc_length/2),from_center,0]) {
            cube([mc_length,mc_width-tolerance,base_height],center=true);
            translate([(mc_length/2),0,0]) {
                cube([5-tolerance,15-tolerance,mc_height],center=true);
            }
        }
    }
}

module female_connector(from_center) {
    color("green") {
        translate([-(base_length/2)+(mc_length/2),from_center,0]) {
            cube([mc_length,mc_width,base_height],center=true);
            translate([(mc_length/2),0,0]) {
                cube([5,15,mc_height],center=true);
            }
        }
    }
}

module all() {
    difference() {
        union() {
            track();
            translate([-(base_length/2),0,base_height/2]){
                v3SignalRail(base_length);
            }
        }
        mountHoles(3, base_length, 15, 10, 5, 0);
        mountHoles(3, base_length, -15, 10, 5, 0);
        female_connector(-15);
        female_connector(15);
    }    
    male_connector(-15);
    male_connector(15);
}

all();
translate([base_length,0,0]) {
    #all();
}
