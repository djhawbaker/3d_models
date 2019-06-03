
precision= 200;

function calculateTopPoint(angle, height) = tan(angle) * height;
module generateKey (dimensions=[18.1,18.1,9.39], walls=[20.22, 20.22, 20.22, 3], thick=1, topSlant=0, topType=0, numConnectors=1) {
    
    x=dimensions[0];
    y=dimensions[1];
    z=dimensions[2];
    
    xLT=calculateTopPoint(walls[1], z);
    xRT=x - calculateTopPoint(walls[2], z);
    yFT=calculateTopPoint(walls[0], z);
    yBT=y - calculateTopPoint(walls[3], z);
    
    
    KeyPoints = [
     [ 0, 0, 0 ],  // 0
     [ x, 0, 0 ],  // 1
     [ x, y, 0 ],  // 2
     [ 0, y, 0 ],  // 3
     [ xLT, yFT, z ],  // 4
     [ xRT, yFT, z ],  // 5
     [ xRT, yBT, z ],  // 6
     [ xLT, yBT, z ]  // 7
    ];
    
    zI=z-(thick*2);
    KeyInnerPoints = [
     [ thick, thick, -1 ],  // 0
     [ x-thick, thick-thick, -1 ],  // 1
     [ x-thick, y-thick, -1 ],  // 2
     [ thick, y-thick, -1 ],  // 3
     [ xLT, yFT, zI],  // 4
     [ xRT, yFT, zI ],  // 5
     [ xRT, yBT, zI ],  // 6
     [ xLT, yBT, zI ]  // 7
    ];

    KeyFaces = [
      [0,1,2,3],  // bottom
      [4,5,1,0],  // front
      [7,6,5,4],  // top
      [5,6,2,1],  // right
      [6,7,3,2],  // back
      [7,4,0,3]]; // left
      
    // Main key
    difference() {
        minkowski() {
            polyhedron( KeyPoints, KeyFaces );
            cylinder(r=.5, h=0.1, $fn=precision);
        }
        polyhedron( KeyInnerPoints, KeyFaces );
        diameter=70;
        // Sphere
        if (topType==0) {
            translate([x/2, y/2, (diameter)/2+z-thick-.2]){
            rotate([topSlant, 0, 0], v=[0,1,0]){
            rotate([90, 90, 0]){
                    sphere(d=diameter, $fn=precision, center=false);
        }}}}
        // Equal or long key slant
        else if (topType == 1) {
            if (topSlant == 0) {
                translate([x/2, y/2, (diameter)/2+z-(thick)]){
                rotate([topSlant, 0, 0], v=[0,1,0]){
                rotate([90, 90, 0]){
                    cylinder(h=50, d=diameter, $fn=precision, center=true);
                }
            }}}
            else {
                translate([x/2, -2, (diameter)/2+z]){
                rotate([topSlant, 0, 0], v=[0,1,0]){
                rotate([90, 90, 0]){
                    cylinder(h=50, d=diameter, $fn=precision, center=true);
                }
        }}}}
        // Wide key
        else if (topType == 2) {
            if (topSlant == 0) {
                translate([x/2, y/2, ((diameter)*3)/2+z-thick]){
                rotate([topSlant, 0, 0], v=[0,1,0]){
                rotate([90, 90, 0]){
                    cylinder(h=50, d=diameter*3, $fn=precision, center=true);
                }
            }}}
            else {
                translate([x/2, 0, (diameter)/2+z]){
                rotate([topSlant, 0, 0], v=[0,1,0]){
                rotate([90, 90, 0]){
                    cylinder(h=50, d=diameter, $fn=precision, center=true);
                }
        }}}}
    }
   
    sWidth=xRT-xLT;
    sDepth=yBT-yFT;
    sW=1.35;
    sH=2.5;
    
    // Center attachment
    for ( c =[0:numConnectors-1]) {
        
        translate([x/2, y/(numConnectors+1) + (y/(numConnectors+1) *c), 1]){
            difference() {
                cylinder( h=zI-thick, d=5.54, center=false);
                cube([4.10, 1.35, 7.6], center=true);
                cube([1.35, 4.10, 7.6], center=true);
            }
        
        };
        // X Support
        translate([xLT, y/(numConnectors+1) + (y/(numConnectors+1)*c)- sW/2, zI - sH]){
            cube([sWidth, sW, sH], center=false);
        }
    }
    
    // Y supports
    color([1,0,0,1]){
    translate([x/2 - sW/2, yFT, zI - sH]){
        cube([sW, sDepth, sH], center=false);
    }}

}

// Tall keys
generateKey(topSlant=-5, topType=1);
translate([22, 0, 0]){generateKey(walls=[20.22, 20.22, 20.22, 20.22]);};

translate([44, 0, 0]){generateKey(dimensions=[18.1, 37.2, 9.39], walls=[20.22, 20.22, 20.22, 3], topType=1, numConnectors=3);};

translate([66, 0, 0]){generateKey(dimensions=[27.2, 18.1, 9.39], walls=[20.22, 20.22, 20.33, 3], topType=2);};

// Short Keys
translate([100, 0, 0]){generateKey(dimensions=[18.1, 18.1, 7.39], topSlant=-5, topType=1);};
translate([122, 0, 0]){generateKey(dimensions=[18.1, 18.1, 7.39], walls=[20.22, 20.22, 20.22, 20.22]);};

translate([144, 0, 0]){generateKey(dimensions=[18.1, 37.2, 7.39], walls=[20.22, 20.22, 20.22, 3], topType=1, numConnectors=3);};

translate([166, 0, 0]){generateKey(dimensions=[27.2, 18.1, 7.39], walls=[20.22, 20.22, 20.33, 3], topType=2);};
