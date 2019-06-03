
precision= 200;
lowRes= 80;
sixSides = 6;
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
     [ x-thick, thick, -1 ],  // 1
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

        
        // Honeycomb Pattern
        honeyD=2.8;
        // Front HoneyComb
        translate([x/2, y/2, 0]){
     
            rotate(a=[0,0,0], v=[0, 0, 1]){
                for (xOffset=[0:1]) {
                    translate([-9.05, -(y/2), 0]){
                        translate([7.3+ xOffset*3.5, 1.9, 1]){
                            rotate([69.78,0,0]){
                                rotate([0,0,30]){
                                    cylinder(h=2, d=honeyD, $fn=sixSides);
                                }
                            }
                        }
                    }
                }
            // Mid Row
                 for (xOffset=[0:2]) {
                     translate([-9.05, -(y/2), 0]){
                        translate([5.3+ xOffset*3.5, 2.6, 3.5]){
                            rotate([69.78,0,0]){
                                rotate([0,0,30]){
                                    cylinder(h=2, d=honeyD, $fn=sixSides);
                                }
                            }
                        }
                    }
                }
                // High Row
                for (xOffset=[0:1]) {
                    translate([-9.05, -(y/2), 0]){
                        translate([7.3+ xOffset*3.5, 3.5, 6]){
                            rotate([69.78,0,0]){
                                rotate([0,0,30]){
                                    cylinder(h=2, d=honeyD, $fn=sixSides);
                                }
                            }
                        }
                    }
                }
            }
        }
        // End Front HoneyComb
        // Back HoneyComb
           
        translate([x/2, y+thick/2, 10]) {
            rotate(a=[90,0,0], v=[0, 0, 0]){
                for (xOffset=[0:1]) {
                    translate([-9.05, -9.05, 0]){
                        translate([7+ xOffset*4, .8, 0]){
                            rotate([0,0,30]){
                                cylinder(h=2, d=honeyD, $fn=sixSides);
                            }
                        }
                    }
                }
                // Mid Row
                for (xOffset=[0:2]) {
                    translate([-9.05, -9.05, 0]){
                        translate([5+ xOffset*4, 3.2, 0]){
                            rotate([0,0,30]){
                                cylinder(h=2, d=honeyD, $fn=sixSides);
                            }
                        }
                    }
                }
                // High Row
                for (xOffset=[0:1]) {
                    translate([-9.05, -9.05, 0]){
                        translate([7+ xOffset*4, 5.6, 0]){
                            rotate([0,0,30]){
                                cylinder(h=3, d=honeyD, $fn=sixSides);
                            }
                        }
                    }
                }
            }
        }   // End back HoneyComb
    
        // Top
        for (yOffset=[0:2]){
            translate([0, yFT+2 + yOffset*(y/3-yFT+.4), z-thick*2.5]) {
                for (xOffset=[0:1]) {
                    translate([7+ xOffset*4, .8, 0]){
                        rotate([0,0,30]){
                            cylinder(h=2, d=honeyD, $fn=sixSides);
                        };
                    };
                }
                // Mid Row
                for (xOffset=[0:2]) {
                translate([5+ xOffset*4, 3.8, 0]){
                    rotate([0,0,30]){cylinder(h=2, d=honeyD, $fn=sixSides);};
                    };
                }
                // High Row
                for (xOffset=[0:1]) {
                    translate([7+ xOffset*4, 6.8, 0]){
                        rotate([0,0,30]){cylinder(h=3, d=honeyD, $fn=sixSides);};
                   };
                }
            }
        } // End of Top 
        
        // Sides
        // Left Side
        for (yOffset=[0:2]){
            translate([0, yFT+2 + yOffset*(y/3-yFT+.4), -3.5]) {
                rotate([0,-70,0]){
                    for (xOffset=[0:1]) {
                        translate([6.5+ xOffset*3, .8, 0]){
                            rotate([0,0,30]){
                                cylinder(h=2, d=honeyD, $fn=sixSides);
                            }
                        }
                    }
                    // Mid Row
                    for (xOffset=[0:2]) {
                        translate([5+ xOffset*3, 3.8, 0]){
                            rotate([0,0,30]){
                                cylinder(h=2, d=honeyD, $fn=sixSides);
                            }
                        }
                    }
                    // High Row
                    for (xOffset=[0:1]) {
                        translate([6.5+ xOffset*3, 6.8, 0]){
                            rotate([0,0,30]){
                                cylinder(h=2, d=honeyD, $fn=sixSides);
                            }
                        }
                    }
                }
            }
        }

        // Right Side
        for (yOffset=[0:2]){
            translate([x-xLT*2+thick*1.5-.1, yFT+2 + yOffset*(y/3-yFT+.4), z+2.2]) {
                rotate([0,70,0]){
                    for (xOffset=[0:1]) {
                        translate([6.5+ xOffset*3, .8, 0]){
                            rotate([0,0,30]){
                                cylinder(h=2, d=honeyD, $fn=sixSides);
                            }
                        }
                    }
                    // Mid Row
                    for (xOffset=[0:2]) {
                        translate([5+ xOffset*3, 3.8, 0]){
                            rotate([0,0,30]){
                                cylinder(h=2, d=honeyD, $fn=sixSides);
                            }
                        }
                    }
                    // High Row
                    for (xOffset=[0:1]) {
                        translate([6.5+ xOffset*3, 6.8, 0]){
                            rotate([0,0,30]){
                                cylinder(h=2, d=honeyD, $fn=sixSides);
                            }
                        }
                    }
                }
            }
        }
        // End of Sides
        // End Honeycomb pattern
    }// End of difference

    sWidth=xRT-xLT;
    sDepth=yBT-yFT;
    sW=1;
    sH=2.5;
    
    // Center attachments
    for ( c =[0:numConnectors-1]) {
        translate([x/2, y/(numConnectors+1) + (y/(numConnectors+1) *c), 1]){
            difference() {
                rotate([0,0,30]){
                    cylinder( h=zI-thick+.5, d=5.54, center=false, $fn=sixSides);
                }
                cube([4.10, 1.35, 7.6], center=true);
                cube([1.35, 4.10, 7.6], center=true);
            }
        
            // Angled Supports
            for (s=[0:1]) {
                translate([0, 0, zI - sH/2-(thick/2)]){
                    rotate([0,0,60*(s+1)]){
                        // Y supports
                        color([1,0,0,1]){
                            cube([sW, 14, sH], center=true);
                        }
                    }
                }
            }
        }
    }
    
    // Central support
    translate([x/2, (y +yFT)/2  , zI - sH/2+(thick/2)]){
        rotate([0,0,0]){
            // Y supports
            color([1,0,0,1]){
                cube([sW, sDepth, sH], center=true);
            }
        }
    }
}

// Long key
generateKey(dimensions=[18.1, 37.2, 9.39], walls=[20.22, 20.22, 20.22, 3], topType=1, numConnectors=3);