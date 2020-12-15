use <track-modules.scad>
pi = 3.14159;

signal_length = pi*4.765;
signal_width = 5;
singal_height = 3;
signal_offset = pi*1.225;

module data_signal(length,connector_d,connector_height,input,at_center)
{
    
    difference() {
        v3SignalRail(length,at_center);
        union() {
            create_removal(input);
        }
    }
    translate([length/2,0,-4])
    mountHoles(3, length, 0, 9, connector_d, 0);
}


module create_removal(test)
{
    for(i = [1:1:9]) {
        if(test[i-1])
        translate([(i*signal_length)-signal_offset,-signal_width/2,4]) {
            cube([signal_length,signal_width,singal_height]);
        }
    }
}