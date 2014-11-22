module springTrigger(minRadius, maxRadius, vertexCount, startPoint, height) {
	function vertexAt(vertexIndex) = 
		let(fraction = vertexIndex / vertexCount)
		let(angle = fraction * 360) 
		let(lengthFraction = vertexIndex > startPoint ? fraction : startPoint / vertexCount)
		let(length = minRadius + lengthFraction * (maxRadius - minRadius)) 
		[cos(angle) * length, sin(angle) * length];
	
	range = [0:(vertexCount-1)];
	path = [for (i = range) i];
	vertices = [for (i = range) vertexAt(i)];

	linear_extrude(height = height) polygon(points=vertices, paths=[path]);
}

module drawSpring() {
	springTrigger(5,17, 500, 50, 8);
}

module drawTireScrewHole() {
	cylinder(h = 4, r=1.5, center=true, $fn = 20);
}

module drawSimpleTireCylinder() {
	difference() {
		cylinder(h = 3, r=30, center=true);
		translate([15, 15, 0]) drawTireScrewHole();
		translate([15, -15, 0]) drawTireScrewHole();
		translate([-15, 15, 0]) drawTireScrewHole();
		translate([-15, -15, 0]) drawTireScrewHole();
	}
}

module drawInnerTireCylinder() {
	difference() {
		drawSimpleTireCylinder();	
		translate([0, 0, 2]) cube([4.2,5.9,5], center = true);
		drawTireScrewHole();
	}

	
	difference() {
		translate ([0, 0, 2])cylinder(h = 6, r=10, center=true);
		cube([4.2,5.9,15], center = true);
	}
}

module drawOuterTireCylinder() {
	drawSimpleTireCylinder();
}

module drawTire() {
	tireWidth = 40;
	
	cylinder(h = tireWidth, r=51, center=true);
	color([1,0,0]) translate([0, 0, tireWidth / 2]) drawInnerTireCylinder();
	color([1,0,0]) translate([0, 0, -tireWidth / 2]) drawOuterTireCylinder();
}

//drawTire();

module drawAllParts() {
	color([1,1,1]) translate([0,27,0]) rotate([90,90,0]) drawSpring();
	
	tireDistance = 120;
	translate([0,-tireDistance,0]) rotate([90,90,0]) mirror([0,0,1]) drawTire();
	translate([0,tireDistance,0]) rotate([90,90,0]) drawTire();
	
	drawTheRest();
}

drawAllParts();

// Moottorin kotelon leveä sivu: 22,5mm
// Moottorin kotelon pituus: 64,27mm

// Akselin etäisyys kotelon reunasta: 8,5mm
// Kotelo alkaa levenemään 36,75mm kohdalla

// Moottorin akselin kapea sivu: 3,7mm, leveä sivu: 5,4mm (leveä sivu on kaareva)
// (36,9mm - 18,6mm) / 2 - 2mm = 7,15mm

// Servon akselin kapea sivu: 2,4mm, leveä sivu: 3,0mm 

// 3.05 1.778

module drawTheRest() {
	axisWidth = 23;
	axisDistance = tireDistance - tireWidth / 2 - axisWidth / 2;
	
	color([0,1,0]) {

		//Read axises
		translate([0,-axisDistance,0]) rotate([90,90,0]) cylinder(h = axisWidth, r=3, center=true);
		translate([0,axisDistance,0]) rotate([90,90,0]) cylinder(h = axisWidth, r=3, center=true);

		//Servo axis
		translate([0,20,0]) rotate([90,90,0]) cylinder(h = 10, r=3, center=true);

		translate([0,0,-7]) {
			difference() {
				cube(size = [80,150,2], center = true);
				translate([0,23,0]) cube([35,12,4], center = true);
			}
			
			// Teensy motors 
			translate([5,-45,6]) cube(size = [64.27,22.5,18.6], center = true); 
			translate([5,45,6]) cube(size = [64.27,22.5,18.6], center = true);
			
			// Teensy
			translate([0,-20,2]) cube(size = [30.5,17.8,3], center = true);
			
			// Battery
			translate([10,-20,-6]) cube(size = [31,60,16], center = true);
			
			// Spring servo
			translate([0,5,6]) cube(size = [20,20,10], center = true);
		}		
	}
}