include <helix_extrude.scad>


precision = 20;

axelRadius = 10;
height = 200;
angle = 360 * 5;

trapezoidHeight = 30;


// DNA double-helix
translate([0, 0, 0]) {
	dnaRadius = 12;

	union() {
		helix_extrude(angle=360*5, height=200, $fn=precision) {
			translate([dnaRadius, 0, 0]) {
				circle(r=3);
			}
		}
		helix_extrude(angle=360*5, height=200, $fn=precision) {
			translate([-dnaRadius, 0, 0]) {
				circle(r=3);
			}
		}

		for (i=[1:60])
			translate([0, 0, i*3.25])
				rotate([0, 90, i*29.25])
					cylinder(r=1, h=dnaRadius * 2, center=true, $fn=precision);
	}
}





// Tap handle
difference() {
    $fn = 40;
    cylinder(140, 15, 20);
    
    translate([0,0,-1]) cylinder(143, 13, 18);
    
    translate([0,0,20]) scale([3,1,1])  sphere(9);
    translate([0,0,20]) rotate([0,0,90]) scale([3,1,1])  sphere(11);
    
    translate([0,0,40]) rotate([0,0,45]) scale([3.5,1,1])  sphere(9);
    translate([0,0,40]) rotate([0,0,135]) scale([3,1,1])  sphere(11);
    
    translate([0,0,60]) rotate([0,0,90]) scale([4,1,1])  sphere(9);
    translate([0,0,60]) rotate([0,0,180]) scale([3,1,1])  sphere(11);
    
    translate([0,0,80]) rotate([0,0,135]) scale([3,1,1])  sphere(10);
    translate([0,0,80]) rotate([0,0,225]) scale([4,1,1])  sphere(12);
    
    translate([0,0,100]) rotate([0,0,180]) scale([3,1,1])  sphere(10);
    translate([0,0,100]) rotate([0,0,270]) scale([3,1,1])  sphere(12);
    
    translate([0,0,120]) rotate([0,0,225]) scale([3,1,1])  sphere(10);
    translate([0,0,120]) rotate([0,0,315]) scale([3,1,1])  sphere(12);
}


