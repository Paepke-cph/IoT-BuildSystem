module mountHoles(n, length, from_center, hole_height, hole_diameter, z) {
    color("purple") {
        $fn = 64;
        j = [-1,0,1];
        distance_between = length / n;
        for(i = j) {
            translate([i*distance_between,from_center,z]) {
                cylinder(d=hole_diameter, hole_height, center=true);
            }
        }
    }
}

function sinePts(xs=[0:7500],xd=48.25, n=1, h=2, base=0, z=0)=
(
   [ for(x=xs) [(x-xs[0])/xd,h*sin(x/n)+base,z] ]
);
module SineEdgePlate(base_length)
{
   function to2d(pts)=[for(p=pts)[p[0],p[1]]];
   pts= concat( [ [base_length,0], [0,0]]
                , to2d(sinePts( h=1, n=2, base=5))
                 );
   polygon( pts );
}

module v3SignalRail(base_length) {
    difference() {
        color("green") {
            rotate(90,[1,0,0]) {
                linear_extrude(height=5, center=true)
                    SineEdgePlate(base_length);
            }
        }
        translate([base_length+5,0,5]) {
            cube([10,10,10],center=true);
        }
    }
}