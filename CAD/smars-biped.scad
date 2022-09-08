// SMARS Biped Mod 
// creator:
// feet, legs, body design by RobotFreak https://www.thingiverse.com/RobotFreak
// credits: 
// SMARS modular robot https://www.thingiverse.com/thing:2662828
// servo case by tristomietitoredeituit SMARS QUAD MOD https://www.thingiverse.com/thing:2755973
// matrix ultrasound case by s4snow SMARS meets OTTO DIY https://www.thingiverse.com/thing:2818380
// 9g servo by TheCase https://www.thingiverse.com/thing:29734
// roundedCube by sembiance https://www.thingiverse.com/thing:2015341
// dovetail by jag https://www.thingiverse.com/thing:10269
include <roundedCube.scad> 
include <Raspberry_Pi_Zero_back_cover.scad>
use <PiZero.scad>
use <dovetail.scad>

/* [global] */
mode = "assembled"; // [assembled:Fully Assembled view, exploded:Explosion view,parts:Parts view, units:Units view]
part = "head"; // [leg:Leg,feet:Feet,body:Body,servo:Servo Cover,servo_m:Servo M Cover,head:Head Cover,power:Power Cover,cpu:CPU cover]
unit = "leg_l"; // [leg_l:Leg Left,leg_r:Leg Right,body:Body,head:Head] 
dof = "6DOF"; // [4DOF:4 DoF Biped, 6DOF:6 DoF Biped, 2WD:2 Wheel drive]
show_non_printable_parts = "true"; // [true:yes,false:no]

/* [head] */
headtype = "ultrasonic"; // [ultrasonic:Ultrasonic, stl: STL File]
headmount = "vertical"; // [vertical:Vertical, horizontal:Horizontal]
head_offset = [0,0,0];
head_rotate = [0,0,0];

ultrasonic = "HCSR04"; // [HCSR04:China Clone HC-SR 04, SRF05:Devantech SRF-05]
matrix = "m8x8"; // [m8x8:8x8 Matrix,m16x8:16x8 Matrix,none:No Matrix]
stlhead_file = "dwayne_head_v2.stl";
stlhead_scale = 0.2;
stlhead_offset = [0,0,0];
stlhead_rotate = [0,0,0];

/* [body] */
bodytype = "dual"; //  [dual:Dual, triple:Triple]
body_offset = [0,0,60];
body_rotate = [0,0,90];
body_u_offset = [0,0,0];
body_u_rotate = [0,0,0];
body_m_offset = [0,0,0];
body_m_rotate = [0,0,0];
body_l_offset = [0,0,0];
body_l_rotate = [0,0,0];

power_pack_offset = [0,0,0];
power_pack_rotate = [0,0,0];

/* [arms] */
armtype = "simple"; // [simple:Simple, scorpio:Scorpio]
armpairs = 0; // [0,1,2]
arm_l_offset =[0,0,0];
arm_l_rotate = [0,0,0];
arm_r_offset = [0,0,0];
arm_r_rotate = [0,0,0];

/* [legs] */
legtype = "2dof"; // [2dof:2DoF, 3dof:3DoF, wheeled:Wheeled, insect:Insect]
legpairs = 1; // [1,2,3]
leg_l_offset = [0,0,0];
leg_l_rotate = [0,0,0];
leg_r_offset = [0,0,0];
leg_r_rotate = [0,0,0];

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

module conn_diamant(width=4.8, height=10.5, length=8) 
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

module servo_horn()
{
        cylinder(d=7.5, h=6);
        hull() {    
            translate([0,0,0]) cylinder(d=7, h=2);
            translate([0,16,0]) cylinder(d=5, h=2);
        } 
 
}

module servo_arm2()
{
    difference() {
        union() {
            cube([44,28,12], center=true);
            translate([-22,-14,0]) rotate([0,90,0]) cylinder(d=12, h=44);
        }
        translate([-17.5,-26,-6]) roundedCube([35,36,12], r=4);
        translate([20.5,-14,0]) rotate([0,90,0]) {
            servo_horn();
        }
         translate([20.5,-14,0]) rotate([0,90,0])cylinder(d=7.5, h=6, center = true);
        //hull() {    
        //    translate([20,0,0]) rotate([0,90,0]) cylinder(d=5, h=2);
        //    translate([20,-14,0]) rotate([0,90,0]) cylinder(d=7, h=2);
        //} 
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
    translate([14,10,0]) rotate([0,0,0]) dovetailPlate(female(), size= [10,10,3], plate=8, center=true);
    translate([14,-10,0]) rotate([0,0,0]) dovetailPlate(female(), size= [10,10,3], plate=8, center=true);

}

module ultrasound_clamp_long()
{
    difference() {
        translate([-9.25,-27,-5]) roundedCube([18.5,54,10], r=1.5);
        translate([-0.5,0,0]) cube([15.5,46.5,10], center=true);
        translate([-8,0,0]) cube([3,44.5,10], center=true);
    }
    // snapin
    translate([2,23.25,-5]) rotate([0,0,60]) cylinder(d=4,h=10,$fn=3);
    translate([2,-23.25,-5]) rotate([0,0,-60]) cylinder(d=4,h=10,$fn=3);
    // Body connector 
    translate([24,0,0]) cube([30,30,10], center=true);
    translate([34,10,-6.5]) rotate([0,180,0]) dovetail(female(), size= [10,10,3], plate=8, center=true);
    translate([34,0,-6.5]) rotate([0,180,0]) dovetail(female(), size= [10,10,3], plate=8, center=true);
    translate([34,-10,-6.5]) rotate([0,180,0]) dovetail(female(), size= [10,10,3], plate=8, center=true);

}

module ultrasound_clamp_vert()
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

module ultrasound_head_adapter() {
  difference() {
    cube([30,30,10], center=true); 
    translate([14,0,0]) cube([2,10,12], center=true);
  }
    /* head connector */
    translate([10,10,2.5]) rotate([0,0,180]) dovetailPlate(male(), size= [10,10,3], plate=8, center=true);
    translate([10,-10,2.5]) rotate([0,0,180]) dovetailPlate(male(), size= [10,10,3], plate=8, center=true);
    /* Body connector */
    translate([-10,10,-6.5]) rotate([0,180,180]) dovetail(female(), size= [10,10,3], plate=8, center=true);
    translate([-10,0,-6.5]) rotate([0,180,180]) dovetail(female(), size= [10,10,3], plate=8, center=true);
    translate([-10,-10,-6.5]) rotate([0,180,180]) dovetail(female(), size= [10,10,3], plate=8, center=true);
 
}
  
module leg_4dof() {
        translate([-9,0,14]) rotate([90,0,0]) 
        difference() 
        {
            servo_arm2();
            translate([5,10,0]) rotate([0,90,90]) servo_horn();
            translate([5,14,0]) rotate([90,0,0]) cylinder(d=7.5, h=6);
            //translate([3,10,0]) rotate([0,0,90]) servo_horn();
            //hull() {    
            //    translate([0,14,0]) rotate([0,90,0]) cylinder(d=5, h=2);
            //    translate([0,0,0]) rotate([0,90,0]) cylinder(d=7, h=2);
            //}
        } 
 
//    translate([-17,0,46]) rotate([0,-90,90]) servo_arm2();
    
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


module arm_left_4dof() {
    mirror([0,0,1]) arm_right_4dof();
} 

module arm_right_4dof() {
    difference() {
        hull() {
            translate([20,0,0]) cylinder(d=12,h=4, center=true);
            translate([-20,0,0]) cylinder(d=12,h=4, center=true);
        }
        #translate([18,0,0]) rotate([0,0,90]) servo_horn();
        translate([18,0,0]) rotate([0,0,0])cylinder(d=7.5, h=6, center = true);

    }
    hull() {
        translate([-20,0,0]) cylinder(d=12,h=4, center=true);
        translate([-30,-30,0]) cylinder(d=12,h=4, center=true);
    }
}


module scorpio_arm_left() {
 mirror([0,0,0]) scorpio_arm_right();
}

module scorpio_arm_right() {
 translate([-70,-38,-14]) rotate([90,0,0]) {
 translate([0,-4,20]) import("right_claw.STL");
 import("new_claw_right4.STL");
 translate([5.5,8.5,-41]) import("new_claw1_right.STL");
 }
}

//arm_right_4dof();
//scorpio_arm_right();

module arm_right() {
 if (armtype == "simple") {
    arm_right_4dof();
 }
 else if (armtype == "scorpio") {
   scorpio_arm_right();
 }
}

module arm_left() {
 if (armtype == "simple") {
    arm_left_4dof();
 }
 else if (armtype == "scorpio") {
   scorpio_arm_left();
 }
}

module battery() {
    hull() {
        cylinder(h=50,d=14, center=true);
        translate([14,0,0]) cylinder(h=50,d=14, center=true);
        translate([-14,0,0]) cylinder(h=50,d=14, center=true);
        translate([7,12,0]) cylinder(h=50,d=14, center=true);
        translate([-7,12,0]) cylinder(h=50,d=14, center=true);
    }
}

module ultrasonic_head() {
    matrix_ultrasound();
    if (headmount == "horizontal") {
        translate([-8,0,48]) rotate([0,0,0]) ultrasound_clamp_long();
    }
    else if (headmount == "vertical") {
        translate([-8,0,48]) rotate([0,0,0]) ultrasound_clamp_vert();
    }
}

module stl_head() {
    difference() {
        translate([0,0,0]) rotate([0,-20,0]) scale([stlhead_scale, stlhead_scale, stlhead_scale]) import(stlhead_file, convexity=3);
        translate([0,0,-3]) cube([40,40,6], center=true);
    }
    translate([-1,0,-0.5]) cylinder(d=22, h=4, $fn=50);
    translate([-11,0,-2]) stl_head_adapter();
 //translate([0,0,2]) rotate([180,0,0]) dovetailPlate(female(), size= [10,10,3], plate=8, center=true);
    //}

}


module stl_head_adapter() {
    difference() {
        union() {
            cube([20,30,4],center=true);
            translate([10,0,0]) cylinder(d=22, h=4, center=true, $fn=50);
        }
        translate([10,5,0]) cylinder(d=2, h=4, center=true, $fn=50);
        translate([10,-5,0]) cylinder(d=2, h=4, center=true, $fn=50);
    }
    translate([-5,10,-3.5]) rotate([0,180,0]) dovetail(female(), size= [10,10,3], plate=8, center=true);
    translate([-5,0,-3.5]) rotate([0,180,0]) dovetail(female(), size= [10,10,3], plate=8, center=true);
    translate([-5,-10,-3.5]) rotate([0,180,0]) dovetail(female(), size= [10,10,3], plate=8, center=true);
    translate([15,0,-3.5]) cylinder(d=5, h=3,center=true);
}

module head() {
    if (headtype == "ultrasonic") {
        ultrasonic_head();
    }
    else if (headtype == "stl") {
         stl_head();
    }
}

//!left_leg_4dof();
module left_leg_4dof() {
        translate([0,-28,0]) feet();
        translate([0,-22.5,0]) rotate([0,180,90]) servo_case();
        translate([7.4,-22.5,0]) leg_4dof();
        //translate([7.4,-22.5,46]) rotate([-90,0,-90]) servo_case();
}

//!left_leg_6dof();
module left_leg_6dof() {
        translate([0,-30.5,0]) feet();
        translate([0,-25,0]) rotate([0,180,90]) servo_case();
        translate([0,-25,23]) rotate([90,0,0]) leg_lower_6dof();
        translate([-5,-25,35]) rotate([0,180,180]) servo_case_m();
        translate([-5,-25,58]) rotate([-90,0,-90]) leg_upper_6dof();
//        translate([7.4,-25,86]) rotate([0,180,0]) servo_case();

}

//!right_leg_4dof();

module right_leg_4dof() {
        translate([0,28,0]) feet();
        translate([0,22.5,0]) rotate([0,180,-90]) servo_case_m();
        translate([7.4,22.5,0]) leg_4dof();
        //translate([7.4,22.5,46]) rotate([90,0,90]) servo_case_m();

}

//right_leg_6dof();

module right_leg_6dof() {
        translate([0,30.5,0]) feet();
        translate([0,25,0]) rotate([0,180,-90]) servo_case_m();
        translate([0,25,23]) rotate([90,0,0]) leg_lower_6dof();
        translate([-5,25,35]) rotate([0,180,180]) servo_case();
        translate([-5,25,58]) rotate([90,0,90]) leg_upper_6dof();
//        translate([7.4,25,86]) rotate([0,180,0]) servo_case_m();

}


module left_leg_wheeled() {
    mirror([0,1,0]) right_leg_wheeled(); 
}

//right_leg_wheeled();

module right_leg_wheeled() {
  translate([-6,40,20]) roundedCube([12,12,80], r=3);
  translate([0,42,20]) cube([10,20,10], true);
  translate([0,58,20]) rotate([90,0,0]) cylinder(d=40,h=5);
}

//left_leg_insect();

module left_leg_insect() {
mirror([0,1,0]) right_leg_insect();
}

//right_leg_insect();

module right_leg_insect() {
 translate([1,90,35]) rotate([0,180,0]) import("foot.stl");
        translate([0,70,30]) rotate([90,-90,0]) servo_case_m();
        translate([-2,55,36]) rotate([0,90,0]) leg_lower_6dof();

}

module body_case_dual() {
  translate([0,0,0]) rotate([90,0,0]) body_case();
  if (show_non_printable_parts == "true") {
     if (dof == "2WD") {
      translate([34,12,0]) rotate([0,90,0]) #9g_servo();
      translate([-34,12,0]) rotate([180,90,0]) #9g_servo();
     }
     else {
         translate([23,2,-18]) rotate([180,0,-90]) #9g_servo();
         translate([-23,2,-18]) rotate([180,0,-90]) #9g_servo();
     }
     translate([0,-8,5]) rotate([-90,0,0]) #battery(); 
  }

  translate([0,0,46]) rotate([90,0,0]) body_case();
  if (show_non_printable_parts == "true") {
      translate([34,12,44]) rotate([180,-90,0]) #9g_servo();
      translate([-34,12,44]) rotate([0,-90,0]) #9g_servo();
      translate([0,-10,28]) #PiZeroBody();
  }
}

module body_case_triple() {
  translate([0,0,0]) rotate([90,0,0]) body_case();
  if (show_non_printable_parts == "true") {
     if (dof == "2WD") {
      translate([34,12,0]) rotate([0,90,0]) #9g_servo();
      translate([-34,12,0]) rotate([180,90,0]) #9g_servo();
     }
     else {
         translate([23,2,-18]) rotate([180,0,-90]) #9g_servo();
         translate([-23,2,-18]) rotate([180,0,-90]) #9g_servo();
     }
     translate([0,-8,5]) rotate([-90,0,0]) #battery(); 
  }

  translate([0,0,46]) rotate([90,0,0]) body_case();
  if (show_non_printable_parts == "true") {
      translate([34,12,44]) rotate([180,-90,0]) #9g_servo();
      translate([-34,12,44]) rotate([0,-90,0]) #9g_servo();
      translate([0,-10,28]) #PiZeroBody();
  }

  translate([0,0,92]) rotate([90,0,0]) body_case();
  if (show_non_printable_parts == "true") {
      translate([34,12,88]) rotate([180,-90,0]) #9g_servo();
      translate([-34,12,88]) rotate([0,-90,0]) #9g_servo();
  }
}

module servo_mount() {
    cube([8,24,13], center=true);
    translate([0,14,0]) rotate([0,90,0]) cylinder(h=8, d=3, center=true);
    translate([0,-14,0]) rotate([0,90,0]) cylinder(h=8, d=3, center=true);
}

module power_pack(width=60, height=12, length=92) {
  translate([-length/2, -width/2, -height/2]) roundedCube([length,width,height], r=5);
}

module body_case(width=44, height=42, length=75, wall=1.5) {
    difference() {
        union() {
            translate([-length/2, -width/2, -height/2]) 
            difference() {
                translate([0,0,0]) roundedCube([length,width, height], r=2);
                translate([wall,wall,wall]) roundedCube([length-wall*2,width-wall*2,height], r=2);
            }   
            translate([0,width/2+1.5,-(height/2-5)]) rotate([0,-90,-90]) dovetail(male(), size= [10,10,3], plate=8, center=true);
            translate([-10,width/2+1.5,-(height/2-5)]) rotate([0,-90,-90]) dovetail(male(), size= [10,10,3], plate=8, center=true);
            translate([10,width/2+1.5,-(height/2-5)]) rotate([0,-90,-90]) dovetail(male(), size= [10,10,3], plate=8, center=true);
            translate([0,-(width/2+1.5),-(height/2-5)]) rotate([0,-90,90]) dovetail(female(), size= [10,10,3], plate=8, center=true);
            translate([-10,-(width/2+1.5),-(height/2-5)]) rotate([0,-90,90]) dovetail(female(), size= [10,10,3], plate=8, center=true);
            translate([10,-(width/2+1.5),-(height/2-5)]) rotate([0,-90,90]) dovetail(female(), size= [10,10,3], plate=8, center=true);
        }
        // servo cutoffs
        translate([length/2,0,-(height/2-wall-7)]) servo_mount();  
        translate([-length/2,0,-(height/2-wall-7)]) servo_mount();  
        translate([23,-width/2,0]) rotate([90,0,90]) servo_mount();  
        translate([-23,-width/2,0]) rotate([90,0,90]) servo_mount();  
        translate([23,width/2,0]) rotate([90,0,90]) servo_mount();  
        translate([-23,width/2,0]) rotate([90,0,90]) servo_mount();  
        // snapin cutoffs
        translate([length/2,-10,(height/2-4)]) cube([4,10,2.5], center=true);  
        translate([length/2,10,(height/2-4)]) cube([4,10,2.5], center=true);  
        translate([-length/2,-10,(height/2-4)]) cube([4,10,2.5], center=true);  
        translate([-length/2,10,(height/2-4)]) cube([4,10,2.5], center=true);  
    }
        //translate([20,-(width/2+1.5),-(height/2-5)]) cube([10,3,10], center=true);
        //translate([-20,-(width/2+1.5),-(height/2-5)]) cube([10,3,10], center=true);
} 

module assembled() 
{
  for(i = [0:1:legpairs-1]) {  
    // right leg
    if (legtype == "2dof") {
        translate([i*50,0,0]) right_leg_4dof();
    }
    else if (legtype == "3dof") {
        translate([i*50,0,0]) right_leg_6dof();
    }
    else if (legtype == "wheeled") {
        translate([i*50,0,0]) right_leg_wheeled();
    }
    else if (legtype == "insect") {
        translate([i*50,0,0]) right_leg_insect();
    }
    
    // left leg
    if (legtype == "2dof") {
        translate([i*50,0,0]) left_leg_4dof();
    }
    else if (legtype == "3dof") {
        translate([i*50,0,0]) left_leg_6dof();
    }
    else if (legtype == "wheeled") {
        translate([i*50,0,0]) left_leg_wheeled();
    }
    else if (legtype == "insect") {
        translate([i*50,0,0]) left_leg_insect();
    }
  }
    
    // body
    if (bodytype == "dual") {
        translate(body_offset) rotate(body_rotate) body_case_dual(); 
    }
    else if (bodytype == "triple") {
        translate(body_offset) rotate(body_rotate) body_case_triple();
    }    
    
    if (show_non_printable_parts == "true") {
        #translate(power_pack_offset) rotate(power_pack_rotate)power_pack();
   }
    
    // arms
    if (armpairs > 0) {
        translate(arm_r_offset) rotate(arm_r_rotate) arm_right(); 
        translate(arm_l_offset) rotate(arm_l_rotate) arm_left();
    } 

    // head
    translate(head_offset) head(); 
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

module units() 
{
    if (unit == "leg_l") {
        if (legtype == "2dof") {
            left_leg_4dof();
        } else if (legtype == "3dof") {
            left_leg_6dof();
        }
    } else if (unit == "leg_r") {
        if (legtype == "2dof") {
            right_leg_4dof();
        } else if (legtype == "3dof") {
            right_leg_6dof();
        }
    } else if (unit == "body") {
        if (bodytype == "dual") {
            body_case_dual();
        }
        else if (bodytype == "triple") {
            body_case_triple();
        }

    } else if (unit == "head") {
        head();
    }
} 

module parts() {
    if (part == "leg") {
        if (legtype == "2dof") {
           leg_4dof();
        } else if (legtype == "3dof") {
           leg_upper_6dof();
           translate([50,0,0]) leg_lower_6dof();
        }
    } else if (part == "feet") {
        feet();
    } else if (part == "body") {
        body_case();
    } else if (part == "servo") {
        servo_case();
    } else if (part == "servo_m") {
        servo_case_m();
    } else if (part == "head") {
        head();
    } else if (part == "power") {
        battery_case();
    } else if (part == "cpu") {
        cpu_case();
    }
} 

//battery();    
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
//cpu_case();
//raspi_zero_cover();
//ultrasound_clamp_long();
//stl_head();
//stl_head_adapter();
//translate([50,0,0]) rotate([0,0,90]) battery_case(height=12);
//body_case();
//ultrasound_head_adapter();
//power_pack();
    
print();


module print() {
    if (mode == "units") {
        units();
    }
    if (mode == "parts") {
        parts();
    }
    else if (mode == "assembled") {
		assembled();
    }
    else if (mode == "exploded") {
        exploded();
    }
} 
