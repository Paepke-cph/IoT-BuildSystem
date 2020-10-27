use <Gears.scad>
// Math for rack
pi = 3.14159;
modul = 1.0;
rail_helix_angle = 0;
rail_pressure_angle = 20;
mx = modul/cos(rail_helix_angle);
rail_tip_width = pi*mx/2-2*mx*tan(rail_pressure_angle);

base_length = 150;
base_width = 80;
base_height = 5;

rail_length = base_length;
rail_width = 5;
rail_height = 10;

axle_width = 75;

module base(length, width, height) {
    cube([length,width,height], center=true);
}

module rail(pos_x,pos_y,pos_z) {
    color("blue") {
        translate([0,rail_width,rail_height/4])
            rotate(90,[1,0,0])
                rack(modul, rail_length, rail_width, rail_height, rail_pressure_angle, rail_helix_angle);
    }
}

module track(length, width, height) {
    base(base_length,base_width,base_height);
    translate([0,0,base_height/2 + (rail_height/4)]) {
        translate([rail_tip_width,(axle_width/2) - (rail_height/2),0])
            rail();
        translate([rail_tip_width,-(axle_width/2) + (rail_height/2),0])
            rail();
    }
}

function sinePts(xs=[0:3750],xd=24, n=1, h=2, base=0, z=0)=
(
   [ for(x=xs) [(x-xs[0])/xd,h*sin(x/n)+base,z] ]
);
module SineEdgePlate()
{
   function to2d(pts)=[for(p=pts)[p[0],p[1]]];
   pts= concat( [ [base_length,0], [0,0]]
                , to2d(sinePts( h=1, n=2, base=5))
                 );
   polygon( pts );
}

module v3SignalRail() {
    difference() {
        color("green") {
            rotate(90,[1,0,0]) {
                linear_extrude(height=5, center=true)
                    SineEdgePlate();
            }
        }
        translate([base_length+5,0,5]) {
            cube([10,10,10],center=true);
        }
    }
}

module mountHoles(n, length, from_center, hole_height, hole_radius, z) {
    $fn = 64;
    j = [-1,0,1];
    distance_between = length / n;
    for(i = j) {
        translate([i*distance_between,from_center,z]) {
            cylinder(r=hole_radius, hole_height, center=true);
        }
    }
}

difference() {
    union() {
        track();
        translate([-(base_length/2),0,base_height/2]){
            v3SignalRail();
        }
    }
    color("purple") {
        mountHoles(3, base_length, 15, 10, 1.5, 0);
        mountHoles(3, base_length, -15, 10, 1.5, 0);
    }
}
// translate([base_length,0,0]) {
//     #track();
//     translate([-(base_length/2),0,base_height/2]){
//         #v3SignalRail();
//     }
// }
