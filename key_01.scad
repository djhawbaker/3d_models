
precision = 200;

KeyPoints = [
 [    0,    0, 0 ],  // 0
 [ 18.1,    0, 0 ],  // 1
 [ 18.1, 18.1, 0 ],  // 2
 [    0, 18.1, 0 ],  // 3
 [ 2.865, 3.46, 9.39 ],  // 4
 [ 15.235, 3.46, 9.39 ],  // 5
 [ 15.235, 18.1, 9.39 ],  // 6
 [ 2.865, 18.1, 9.39 ]  // 7
];

KeyInnerPoints = [
 [    1,    1, -1 ],  // 0
 [ 17.1,    1, -1 ],  // 1
 [ 17.1, 17.1, -1 ],  // 2
 [    1, 17.1, -1 ],  // 3
 [ 2.865, 3.46, 7.39 ],  // 4
 [ 15.235, 3.46, 7.39 ],  // 5
 [ 15.235, 17.1, 7.39 ],  // 6
 [ 2.865, 17.1, 7.39 ]  // 7
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
        cylinder(r=1, h=0.1, $fn=precision);
    }
    polyhedron( KeyInnerPoints, KeyFaces );
    translate([9.05, 22, 33.5]){
        rotate([90, 90, 0]){
            cylinder(h=25, d=50, $fn=precision, center=false);
    }}
}

// Center attachment
translate([9.05, 9.05, 1]){
    difference() {
        cylinder( h=7.5, d=5.54, center=false);
        cube([4.10, 1.35, 7.6], center=true);
        cube([1.35, 4.10, 7.6], center=true);
    }

};

// Center supports
translate([9.05, 9.05, 7.25]){
    cube([12.8, 1.35, 2.5], center=true);
}
translate([9.05, 10.55, 7.25]){
    cube([1.35, 14.8, 2.5], center=true);
}
