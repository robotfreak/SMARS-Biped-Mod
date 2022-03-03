// SMARS Biped Mod 
// creator:
// feet, legs, body design by RobotFreak https://www.thingiverse.com/RobotFreak
// credits: 
// SMARS modular robot https://www.thingiverse.com/thing:2662828
// servo case by tristomietitoredeituit SMARS QUAD MOD https://www.thingiverse.com/thing:2755973
// matrix ultrasound case by s4snow SMARS meets OTTO DIY https://www.thingiverse.com/thing:2818380
// 9g servo by TheCase https://www.thingiverse.com/thing:29734
// roundedCube by sembiance https://www.thingiverse.com/thing:2015341
include <roundedCube.scad> 
include <Raspberry_Pi_Zero_back_cover.scad>
use <dovetail.scad>

part = "head"; // [leg:Leg,feet:Feet,body:Body,servo:Servo Cover,servo_m:Servo M Cover,head:Head Cover,power:Power Cover,cpu:CPU cover]

mode = "parts"; // [assembled:Fully Assembled view, exploded:Explosion view,parts:Parts view]

ultrasonic = "HCSR04"; // [HCSR04:China Clone HC-SR 04, SRF05:Devantech SRF-05]

matrix = "m8x8"; // [m8x8:8x8 Matrix,m16x8:16x8 Matrix,none:No Matrix]

dof = "6DOF"; // [4DOF:4 DoF, 6DOF:6 DoF]
show_non_printable_parts = "false"; // [true:yes,false:no]

module 9g_servo(){
	difference(){			
		union(){
			cube([23,12.5,22], center=true);
			translate([0,0,5]) cube([32,12,2], center=true);
			translate([5.5,0,2.75]) cylinder(r=6, h=25.75, $fn=20, center=true);
			translate([-.5,0,2.75]) cylinder(r=1, h=25.75, $fn=20, center=true);
			translate([-1,0,2.75]) cube([5,5.6,24.5], center=true);		
			translate([5.5,0,3.65]) cylinder(r=2.35, h=29.25, $fn=20, center=true);				
		}
		for ( hole = [14,-14] ){
			translate([hole,0,5]) cylinder(r=2.2, h=4, $fn=20, center=true);
		}	
	}
}
module servo_case()
{
  translate([-12.5,-17,-6.3]) {   
    difference() {
        union() {
            roundedCube([36,34,13.6], r=3);
            translate([-1,17,6.3]) rotate([0,90,0]) rotate([0,0,0]) cylinder(d=6.3, h=1, $fn=4);
            translate([36,17,6.3]) rotate([0,90,0]) rotate([0,0,0]) cylinder(d=6.3, h=1, $fn=4);
        }
        translate([6.2,3.2,1.6]) cube([23.5,24,12]);
        translate([6.2,0,1.6]) cube([15.5,3.5,12]);
        translate([0.7,8.0,1.6]) cube([34.6,3.2,12]);
        translate([0,25.4,11.8]) cube([13.5,8.6,2]);
        translate([2.4,29,1.6]) roundedCube([31.5,2.3,12], r=1);
        translate([31.7,23,1.6]) roundedCube([2.3,8.3,12], r=1);
        translate([31.7,23,1.6]) roundedCube([5.5,2.3,12], r=1);
        translate([2.4,19.6,1.6]) roundedCube([2.3,11.3,12], r=1);
        translate([2.4,19.6,1.6]) roundedCube([5.5,2.3,12], r=1);
        translate([11.5,34,7.4]) rotate([90,0,0]) cylinder(d=6.5, h=10, $fn=30);
    }
    if (show_non_printable_parts == "true") {
        if (mode == "exploded") {
            translate([18,14.5,20.5]) rotate([90,180,0]) #9g_servo();
        }
        else {
            translate([18,14.5,7.5]) rotate([90,180,0]) #9g_servo();
        }
    }
  }
}

module servo_case_m()
{
    mirror([0,1,0]) servo_case();
}

module conn_diamant(width=4.8, height=11.5, length=8) 
{
    rotate([90,0,0]) 
    difference() { 
        union() {
            translate([0,length/2,0]) cube([height,length,width], center=true);
            translate([0,length,-width/2]) cylinder(h=width, d=height, $fn=30);
        }
        translate([0,length,-width/2]) cylinder(d=6.5, h=width, $fn=4);
    }
}

module feet(height=3)
{
    translate([-30,-23,-11]) {
        roundedCube([60,46,height], r=8);    
        translate([30,2.4,height]) conn_diamant();
        translate([30,43.6,height]) conn_diamant();
    }
}
/*
module servo_arm()
{
    import("servo-arm.stl");
}
*/
module servo_arm2()
{
    difference() {
        union() {
            cube([44,28,12], center=true);
            translate([-22,-14,0]) rotate([0,90,0]) cylinder(d=12, h=44);
        }
        translate([-17.5,-26,-6]) roundedCube([35,36,12], r=4);
        translate([17.5,-14,0]) rotate([0,90,0]) cylinder(d=7.5, h=6);
        hull() {    
            translate([20,0,0]) rotate([0,90,0]) cylinder(d=5, h=2);
            translate([20,-14,0]) rotate([0,90,0]) cylinder(d=7, h=2);
        } 
    }
    translate([-17.5,-14,0]) rotate([0,90,0]) cylinder(d=6, h=2);
}

module ultrasound_hcsr04() 
{
    difference() {
        translate([-13.5,-27,0]) roundedCube([27,54,15.6], r=8);
        translate([0,0,10.5]) cube([21,46,15], center=true);
        translate([0,13,0]) cylinder(d=17, h=6);
        translate([0,-13,0]) cylinder(d=17, h=6);
        translate([0,25.5,8]) cube([10.5,5.5,16], center=true);
        translate([0,-25.5,8]) cube([10.5,5.5,16], center=true);
    }
    translate([0,0,0])  cylinder(d=4.8, h=12);
}

module ultrasound_srf05() 
{
    difference() {
        translate([-13.5,-26,0]) roundedCube([27,52,15.6], r=8);
        translate([0,0,10.5]) cube([21,44,15], center=true);
        translate([0,11.8,0]) cylinder(d=17, h=6);
        translate([0,-11.8,0]) cylinder(d=17, h=6);
        translate([0,24,8]) cube([10.5,5.5,16], center=true);
        translate([0,-24,8]) cube([10.5,5.5,16], center=true);
    }
    translate([0,0,0])  cylinder(d=4.8, h=12);
}

    //rotate([0,0,90]) translate([-1,-44,-12]) import("ultrasonic_2a_V2.stl");

module ultrasound_clamp()
{
    difference() {
        translate([-9.25,-27,-5]) roundedCube([18.5,54,10], r=1.5);
        translate([-0.5,0,0]) cube([15.5,46.5,10], center=true);
        translate([-8,0,0]) cube([3,44.5,10], center=true);
    }
    translate([2,23.25,-5]) rotate([0,0,60]) cylinder(d=4,h=10,$fn=3);
    translate([2,-23.25,-5]) rotate([0,0,-60]) cylinder(d=4,h=10,$fn=3);
    translate([14,10,0]) rotate([0,90,0]) dovetailPlate(female(), size= [10,10,3], plate=8, center=true);
    translate([14,-10,0]) rotate([0,90,0]) dovetailPlate(female(), size= [10,10,3], plate=8, center=true);

}
  
module matrix_8x8() 
{
    translate([-23,-19,0]) rotate([90,0,90]) difference() {
        roundedCube([46, 36, 15.6], r=2);
        translate([1.75,1.75,3]) roundedCube([42.5, 32.5, 15.6], r=2);
        translate([6.75,1.75,0.4]) cube([32.5, 32.5, 15.6]);
    }
}

module matrix_16x8() 
{
    translate([-38.5,-19,0])  rotate([90,0,90]) difference() {
        roundedCube([77, 36, 15.6], r=2);
        translate([1.75,1.75,3]) roundedCube([73.5, 32.5, 15.6], r=2);
        translate([6.25,1.75,0.4]) cube([64.5, 32.5, 15.6]);
    }
}

module matrix_ultrasound() 
{
    if (ultrasonic == "HCSR04") {
        translate([-17.5,0,48]) rotate([0,90,0]) ultrasound_hcsr04();
    } else if (ultrasonic == "SRF05") {
        translate([-17.5,0,48]) rotate([0,90,0]) ultrasound_srf05();
    }
    if (matrix == "m8x8") {
        translate([5.5,-4,0]) matrix_8x8();
    } else if (matrix == "m16x8") {
        translate([21,-19,0]) matrix_16x8();
    }
}
  
/*
module leg()
{
    translate([-7.4,6,24.3]) {
        difference() {
            rotate([90,0,0]) servo_arm();
            translate([-24,-12,4.5]) cube([50,12,15]);
            translate([-9,-12,-2]) cube([15,14,12]);
        }

        difference() {
            translate([-17,0,21.8]) rotate([0,-90,90]) servo_arm();
            translate([-37,-12,-1]) cube([15,14,50]);
        }
    }
}

module leg_o()
{
    translate([-7.4,6,24.3]) {
        difference() {
            rotate([90,0,0]) servo_arm();
            translate([-24,-12,4.5]) cube([50,12,15]);
        }

        translate([0,-11.8,4.4]) {
            difference() {
                rotate([-90,0,0]) servo_arm();
                translate([-24,0,-19]) cube([50,12,15]);
            }
        }

    }
}
*/
module leg_4dof() {
    translate([-9,0,14]) rotate([90,0,0]) servo_arm2();
    translate([-17,0,46]) rotate([0,-90,90]) servo_arm2();
    
}

module leg_upper_6dof() {
    translate([0,-12,0]) servo_arm2();
    translate([0,12,0]) mirror([0,1,0]) servo_arm2();
    
}

module leg_lower_6dof() {
    translate([0,-10,0]) servo_arm2();
    translate([20.5,4,0]) rotate([0,90,90]) conn_diamant(height=12, width=4.5);
    translate([-20.5,4,0]) rotate([0,90,90]) conn_diamant(height=12, width=4.5);
}

module body_4dof(width=45, height=12, length=105, wall=2)
{
    translate([-length/2,-width/2,-height/2]) {
        difference() {
            translate([0,0,4]) roundedCube([length,width,height], r=2);
            translate([wall,wall,4]) roundedCube([length-wall*2,width-wall*2,height], r=1.5);
        }
        translate([29.4,wall,4]) cube([wall, width-wall*2, height]);
        translate([72.6,wall,4]) cube([wall, width-wall*2, height]);

        translate([4,0,10]) rotate([0,-90,90]) conn_diamant();
        translate([45.2,0,10]) rotate([0,-90,90]) conn_diamant();
        translate([59.8,0,10]) rotate([0,-90,90]) conn_diamant();
        translate([101,0,10]) rotate([0,-90,90]) conn_diamant();
    }
}

module body_6dof(width=45, height=18, length=105, wall=2)
{
    translate([-length/2,-width/2,-height/2]) {
        difference() {
            translate([0,0,0]) roundedCube([length,width,height], r=2);
            translate([wall,wall,0]) roundedCube([length-wall*2,width-wall*2,height], r=1.5);
        }
        translate([26,2.5,0]) rotate([180,0,0]) conn_diamant(width=3);
        translate([26,2.5,height/2]) cube([11.5,3,height], center=true);
        translate([78,2.5,0]) rotate([180,0,0]) conn_diamant(width=3);
        translate([78,2.5,height/2]) cube([11.5,3,height], center=true);
        translate([26,42.5,0]) rotate([180,0,0]) conn_diamant(width=3);
        translate([26,42.5,height/2]) cube([11.5,3,height], center=true);
        translate([78,42.5,0]) rotate([180,0,0]) conn_diamant(width=3);
        translate([78,42.5,height/2]) cube([11.5,3,height], center=true);
        translate([length-wall-1,width/2-12, 8]) rotate([0,90,0]) cylinder(d=6.5, h=1, $fn=4);
        translate([length-wall-1,width/2+12, 8]) rotate([0,90,0]) cylinder(d=6.5, h=1, $fn=4);
        translate([wall,width/2-12, 8]) rotate([0,90,0]) cylinder(d=6.5, h=1, $fn=4);
        translate([wall,width/2+12, 8]) rotate([0,90,0]) cylinder(d=6.5, h=1, $fn=4);
        difference() {
            union() {
                translate([length/2+28,width/2,height-1]) cube([8,width,2], center=true);
                translate([length/2+28,width/2+9.5,height-4]) cylinder(d=5,h=2);
                translate([length/2+28,width/2-9.5,height-4]) cylinder(d=5,h=2);
            }
            translate([length/2+28,width/2+9.5,height-5]) cylinder(d=3,h=8);
            translate([length/2+28,width/2-9.5,height-5]) cylinder(d=3,h=8);
        }
        difference() {
            union() {
                translate([length/2-28,width/2,height-1]) cube([8,width,2], center=true);
                translate([length/2-28,width/2+9.5,height-4]) cylinder(d=5,h=2);
                translate([length/2-28,width/2-9.5,height-4]) cylinder(d=5,h=2);
            }
            translate([length/2-28,width/2+9.5,height-5]) cylinder(d=3,h=8);
            translate([length/2-28,width/2-9.5,height-5]) cylinder(d=3,h=8);
        }
    }
}

module battery_case(width=45, height=22, length=105, wall=2)
{
    translate([-length/2,-width/2,-height/2]) {
        difference() {
            translate([0,0,wall]) roundedCube([length,width,height], r=2);
            translate([wall,wall,0]) roundedCube([length-wall*2,width-wall*2,height], r=2);
            translate([length/2+27.25+5,width/2,height]) cylinder(d=3, h=8);
            translate([length/2-27.25+5,width/2,height]) cylinder(d=3, h=8);
            translate([-2, 12, height/2]) rotate([0,90,0]) cylinder(d=12, h=8);
            translate([-2, 34, height/2]) rotate([0,90,0]) cylinder(d=7, h=8);
            translate([-2, 40.5, height/2]) rotate([0,90,0]) cylinder(d=2, h=6);
        }
            //translate([lentgh, width/2, height/2]) rotate([0,90,0]) cylinder(d=12, h=8);
        translate([wall+1.5,width/2,0]) cube([3,11.5,6], center=true);
        translate([wall+1.5,width/2,0]) rotate([180,0,90]) conn_diamant(width=3);
        difference() {
            translate([wall+1.5,width/2,height/2]) cube([3,11.5,height], center=true);
            translate([-2, 12, height/2]) rotate([0,90,0]) cylinder(d=16.4, h=8, $fn=6);
        }
        difference() {
            translate([length/2+27.25+5,width/2,height-wall]) cylinder(d=5, h=2);
            translate([length/2+27.25+5,width/2,height-wall]) cylinder(d=3, h=8);
        }
        difference() {
            translate([length/2-27.25+5,width/2,height-wall]) cylinder(d=5, h=2);
            translate([length/2-27.25+5,width/2,height-wall]) cylinder(d=3, h=8);
        }
        translate([length/2+10+5,width/4,height-wall]) cylinder(d=5, h=2);
        translate([length/2-10+5,width*3/4,height-wall]) cylinder(d=5, h=2);
        translate([length-wall-1.5,width/2,0]) rotate([180,0,90]) conn_diamant(width=3);
        translate([length-wall-1.5,width/2,height/2]) cube([3,11.5,height], center=true);
        translate([length/2+10,width+wall/2+0.5,height/2+8]) rotate([90,90,180]) dovetail(male(), size= [10,10,3], plate=8, center=true);
        translate([length/2-10,width+wall/2+0.5,height/2+8]) rotate([90,90,180]) dovetail(male(), size= [10,10,3], plate=8, center=true);

    }
    if (show_non_printable_parts == "true") {
    // battery pack 
        difference() {
            #cube([77,39,15], center=true);
            #translate([0,0,1]) cube([75,37,14], center=true);
        }
        #translate([-34,10,1]) rotate([0,90,0]) cylinder(d=18.6, h=68);
        #translate([-34,-10,1]) rotate([0,90,0]) cylinder(d=18.6, h=68);
    }
}

module cpu_case(width=45, height=22, length=105, wall=2)
{
    translate([-length/2,-width/2,-height/2]) {
        difference() {
            translate([0,0,0]) roundedCube([length,width,height], r=2);
            translate([wall,wall,0]) roundedCube([length-wall*2,width-wall*2,height], r=2);
            translate([length/2+32.5-12.4,0,height-7]) cube([14,4,6], center=true); //hdmi
            translate([length/2+32.5-41.4,0,height-7]) cube([10,4,4], center=true); //usb
            translate([length/2+32.5-54,0,height-7]) cube([10,4,4], center=true);   //usb
        }
        translate([wall+1.5,width/2+12,0]) rotate([180,0,90]) conn_diamant(width=3);
        translate([wall+1.5,width/2+12,height/2]) cube([3,11.5,height], center=true);
        translate([wall+1.5,width/2-12,0]) rotate([180,0,90]) conn_diamant(width=3);
        translate([wall+1.5,width/2-12,height/2]) cube([3,11.5,height], center=true);
        translate([wall,width/2, height-8]) rotate([0,90,0]) cylinder(d=6.5, h=1, $fn=4);
        translate([length-wall-1.5,width/2-12,0]) rotate([180,0,90]) conn_diamant(width=3);
        translate([length-wall-1.5,width/2-12,height/2]) cube([3,11.5,height], center=true);
        translate([length-wall-1.5,width/2+12,0]) rotate([180,0,90]) conn_diamant(width=3);
        translate([length-wall-1.5,width/2+12,height/2]) cube([3,11.5,height], center=true);
        translate([length-wall-1,width/2, height-8]) rotate([0,90,0]) cylinder(d=6.5, h=1, $fn=4);
        difference() {
            union() {
                translate([length/2+29,width/2,height-1]) cube([8,width,2], center=true);
                translate([length/2+29,width/2-5+11.5,height-4]) cylinder(d=5,h=2);
                translate([length/2+29,width/2-5-11.5,height-4]) cylinder(d=5,h=2);
            }
            translate([length/2+29,width/2-5+11.5,height-5]) cylinder(d=3,h=8);
            translate([length/2+29,width/2-5-11.5,height-5]) cylinder(d=3,h=8);
        }
        difference() {
            union() {
                translate([length/2-29,width/2,height-1]) cube([8,width,2], center=true);
                translate([length/2-29,width/2-5+11.5,height-4]) cylinder(d=5,h=2);
                translate([length/2-29,width/2-5-11.5,height-4]) cylinder(d=5,h=2);
            }
            translate([length/2-29,width/2-5+11.5,height-5]) cylinder(d=3,h=8);
            translate([length/2-29,width/2-5-11.5,height-5]) cylinder(d=3,h=8);
        }
        if (show_non_printable_parts == "true") {
            #translate([length/2,width/2,height/2]) raspi_zero_cover();
        }
    }
}

module assembled() 
{
    // right 
    if (dof == "4DOF") {
        translate([0,28,0]) feet();
        translate([0,22.5,0]) rotate([0,180,-90]) servo_case_m();
        translate([7.4,22.5,0]) leg_4dof();
        translate([7.4,22.5,46]) rotate([90,0,90]) servo_case_m();
    }
    else if (dof == "6DOF") {
        translate([0,30.5,0]) feet();
        translate([0,25,0]) rotate([0,180,-90]) servo_case_m();
        translate([0,25,23]) rotate([90,0,0]) leg_lower_6dof();
        translate([6,25,35]) rotate([0,180,0]) servo_case_m();
        translate([6,25,58]) rotate([90,0,90]) leg_upper_6dof();
        translate([7.4,25,86]) rotate([0,180,0]) servo_case_m();
    }
    
    // left
    if (dof == "4DOF") {
        translate([0,-28,0]) feet();
        translate([0,-22.5,0]) rotate([0,180,90]) servo_case();
        translate([7.4,-22.5,0]) leg_4dof();
        translate([7.4,-22.5,46]) rotate([-90,0,-90]) servo_case();
    }
    else if (dof == "6DOF") {
        translate([0,-30.5,0]) feet();
        translate([0,-25,0]) rotate([0,180,90]) servo_case();
        translate([0,-25,23]) rotate([90,0,0]) leg_lower_6dof();
        translate([6,-25,35]) rotate([0,180,0]) servo_case();
        translate([6,-25,58]) rotate([-90,0,90]) leg_upper_6dof();
        translate([7.4,-25,86]) rotate([0,180,0]) servo_case();
    }
    
    // body
    if (dof == "4DOF") {
        translate([37,0,42]) rotate([0,0,-90]) body_4dof(height=18);
        translate([37,0,68]) rotate([0,0,90]) cpu_case();
        translate([37,0,89]) rotate([0,0,90]) battery_case();
        translate([0,0,90]) matrix_ultrasound();
    }
    else if (dof == "6DOF") {
        translate([2,0,100]) rotate([0,0,-90]) body_6dof();
        translate([2,0,121]) rotate([0,0,90]) cpu_case();
        translate([2,0,142]) rotate([0,0,90]) battery_case();
        translate([-26,0,100]) matrix_ultrasound();
    }
}

module exploded() 
{
    // right 
    translate([0,34,0]) feet();
    translate([46,39,30]) rotate([0,0,90]) servo_case();
    translate([28,57,80]) leg();
    translate([65,21,120]) rotate([90,180,90]) servo_case();
    
    // left
    translate([0,-50,0]) feet();
    translate([46,-9,30]) rotate([0,0,-90]) servo_case_m();
    translate([28,-16,80]) leg();
    translate([65,6,120]) rotate([-90,180,90]) servo_case_m();

    translate([-10,0,90])  matrix_ultrasound();
}

//biped();
//servo_case();
//servo_case_m();
//translate([0,0,10]) servo_arm();
//leg_4dof(); 
//servo_arm2();
//feet();
//conn_diamant();
//9g_servo();
//body_6dof(height=18);
//battery_case();
//leg_o();
cpu_case();
//raspi_zero_cover();
//ultrasound_clamp();
//translate([50,0,0]) rotate([0,0,90]) battery_case(height=12);

//print_part();


module print_part() {
    if (mode == "parts") {
        if (part == "leg") {
            if (dof == "4DOF") {
                leg();
            } else if (dof == "6DOF") {
                leg_o();
            }
        } else if (part == "leg_o") {
            leg_o();
        } else if (part == "feet") {
            feet();
        } else if (part == "body") {
            if (dof == "4DOF") {
                body_4dof();
            } else if (dof == "6DOF") {
                body_6dof();
            }
        } else if (part == "servo") {
            servo_case();
        } else if (part == "servo_m") {
            servo_case_m();
        } else if (part == "head") {
            matrix_ultrasound();
            ultrasound_clamp();
        } else if (part == "power") {
            battery_case();
        } else if (part == "cpu") {
            cpu_case();
        }
    }
    else if (mode == "assembled") {
		    assembled();
        }
    else if (mode == "exploded") {
            exploded();
        }
} 
