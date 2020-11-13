use <../Gears.scad>
use <track-modules.scad>
pi = 3.14159;

module base(length, width, height, at_center) {
    cube([length,width,height], center=at_center);
}

module rail(modul,rail_length,rail_width,rail_height,rail_pressure_angle,rail_helix_angle) {
    translate([0,rail_width/2,rail_height/4]) {
        rotate(90,[1,0,0]) {
            rack(modul, rail_length, rail_height, rail_width, rail_pressure_angle, rail_helix_angle);
        }            
    }
}

module wheel_track(track_width, track_length, track_height, axel_width, rail_width, rail_height, modul, rail_pressure_angle, rail_helix_angle,at_center) {
    mx = modul/cos(rail_helix_angle);
    rail_tip_width = pi*mx/2-2*mx*tan(rail_pressure_angle);

    base(track_length,track_width,track_height,at_center);
    translate([0,0,(track_height/2) + rail_height-(rail_height/4)]) {
        translate([rail_tip_width-rail_tip_width-0.2,axel_width/2-(rail_width/4),0]) {
            rail(modul,track_length,rail_width,rail_height,rail_pressure_angle,rail_helix_angle);
        }
        translate([rail_tip_width-rail_tip_width-0.2,-axel_width/2+(rail_width/4),0]) {
            rail(modul,track_length,rail_width,rail_height,rail_pressure_angle,rail_helix_angle);
        }
    }
}

module male_connector(track_length,track_height,mc_width,mc_length,mc_height,from_center,at_center) {
    tolerance = 0.4;
    translate([(track_length/2)+(mc_length/2),from_center,0]) {
        cube([mc_length,mc_width-tolerance,track_height],center=at_center);
        translate([(mc_length/2),0,0]) {
            cube([5-tolerance,15-tolerance,mc_height],center=at_center);
        }
    }
}

module female_connector(track_length,track_height,mc_width,mc_length,mc_height,from_center,at_center) {
    translate([-(track_length/2)+(mc_length/2),from_center,0]) {
        cube([mc_length,mc_width,track_height],center=at_center);
        translate([(mc_length/2),0,0]) {
            cube([5,15,mc_height],center=at_center);
        }
    }
}

module track(track_width,track_length,track_height,
            wheel_axel_width,modul,rail_helix_angle,rail_pressure_angle,
            rail_width,rail_height,at_center) {
    
    rail_length = track_length;
    mc_length = 15;
    mc_width = 10;
    mc_height = track_height; 

    difference() {
        union() {
            wheel_track(track_width,track_length, track_height, 
                        wheel_axel_width, rail_width, rail_height, 
                        modul, rail_pressure_angle, rail_helix_angle,at_center);
            translate([-(track_length/2),0,track_height/2]){
                v3SignalRail(track_length,at_center);
            }
        }
        mountHoles(3, track_length, 15, 10, 5, 0);
        mountHoles(3, track_length, -15, 10, 5, 0);
        female_connector(track_length,track_height,mc_width,mc_length,mc_height,-15,at_center);
        female_connector(track_length,track_height,mc_width,mc_length,mc_height,15,at_center);
    }    
    male_connector(track_length,track_height,mc_width,mc_length,mc_height,-15,at_center);
    male_connector(track_length,track_height,mc_width,mc_length,mc_height,15,at_center);
}



