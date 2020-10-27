 
buggy_width=50;
buggy_length=100;
buggy_height=40;
wall_width=10;
square_height = 5;
lid_height = 2.4;


  //  cube(size=[buggy_width-wall_width+5, buggy_length-wall_width+5, square_height], center=true);
  //   cube(size=[buggy_width, buggy_length, lidt_height], center=true);


// translate(cube(size=[buggy_width-wall_width+5, buggy_length-wall_width+5, square_height], center=true)) 
//   cube(size=[buggy_width, buggy_length, lidt_height], center=true);
  cube(size=[buggy_width-wall_width+5, buggy_length-wall_width+5, square_height], center=true);
  translate([0,0,square_height]){ 
     cube(size=[buggy_width, buggy_length, lid_height], center=true);
  }

