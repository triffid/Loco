include <servo.scad>

module peen(r = 20, h = 50) {
	rotate([0, -90, 0]) sphere(r = r, $fn=32);
	mirror([0, 0, 1]) cylinder(r = r, h = h, $fn=32);
}

module shin() {
	render()
	difference() {
		union() {
			mirror([0, 0, 0]) translate([32, -13, -13]) mirror([1, 0, 0]) cube([8, 26, 73]);
			mirror([1, 0, 0]) translate([32, -13, -13]) mirror([1, 0, 0]) cube([8, 26, 73]);
			translate([ 24.5, 0, 0]) rotate([0, -90, 0]) rotate([0, 0, 180 / 16]) cylinder(r1=6.5 / 2, r2=5.5 / 2, h=1, $fn=16);
			difference() {
				translate([-26, -13, 0]) cube([52, 26, 60]);
				rotate([0, -90, 0]) cylinder(r=50, h=54, center=true, $fn=64);
			}
		}
		translate([18.5, 0, 0]) rotate([0, -90, 0]) { servo_horn_negative(); %servo_horn(); }
		rotate([0, -90, 0]) rotate([0, 0, 180 / 8]) cylinder(r=1.9, h=100, center=true, $fn=8);


		render() difference() {
			translate([20, -50, -20]) cube([100, 100, 150]);
			translate([33 - 0.4 * 14, 0, 0]) scale([0.4, 1, 1]) mirror([0, 0, 1]) {
				peen(14, 100);
				render() intersection() {
					cylinder(r = 14, h=50, $fn=32);
					rotate([90 + 35, 0, 0]) cylinder(r=14, h=50, $fn=32);
				}
				translate([-43, 0, 0]) rotate([90 + 35, 0, 0]) cube([43, 14, 14]);/**/
				rotate([0, -90, 0]) cylinder(r = 14, h=50, $fn=32);
				translate([-100, -14, -100]) cube([100, 14 * 2, 100]);
			}
		}
		mirror([1, 0, 0]) render() difference() {
			translate([20, -50, -20]) cube([100, 100, 150]);
			translate([33 - 0.4 * 14, 0, 0]) scale([0.4, 1, 1]) mirror([0, 0, 1]) {
				peen(14, 100);
				render() intersection() {
					cylinder(r = 14, h=50, $fn=32);
					rotate([90 + 35, 0, 0]) cylinder(r=14, h=50, $fn=32);
				}
				translate([-43, 0, 0]) rotate([90 + 35, 0, 0]) cube([43, 14, 14]);/**/
				rotate([0, -90, 0]) cylinder(r = 14, h=50, $fn=32);
				translate([-100, -14, -100]) cube([100, 14 * 2, 100]);
			}
		}
	}
}

module torso(lh1r = 0, lh2r = 0, ltr = 0, rh1r = 0, rh2r = 0, rtr = 0) {
	difference() {
		translate([-60, -30, 0]) cube([120, 60, 10]);
		
		translate([40, -10, 40]) {
			rotate([0, 180, 270]) { %servo(); servo_negative(1); servo_horn_negative(); }
		}
		translate([-40, -10, 40]) {
			rotate([0, 180, 270]) { %servo(); servo_negative(1); servo_horn_negative(); }
		}
	}
	translate([40, -10, 40]) rotate([0, 0, lh1r]) {
		hip1();
		/*translate([0, 57, -80]) rotate([0, lh2r, 0]) {
			hip2();
			translate([-18, -57, 0]) {
				rotate([ltr, 0, 0])
				rotate([0, 90, 0]) {
					//thigh();
				}
			}
		}/**/
	}
	mirror([1, 0, 0])
	translate([40, -10, 40]) rotate([0, 0, rh1r]) {
		hip1();
		translate([0, 57, -80]) rotate([0, rh2r, 0]) {
			hip2();
			translate([-18, -57, 0]) {
				rotate([rtr, 0, 0])
				rotate([0, 90, 0]) {
					//thigh();
				}
			}
		}
	}
}

module hip1() {
	difference() {
		union() {
			translate([-15, -20, -42]) mirror([0, 0, 1]) cube([30, 51.98, 10]);
			translate([-15, -20, -42]) mirror([0, 0, 1]) mirror([0, 1, 0]) cube([30, 5, 60]);
			translate([-15, 17, -42]) mirror([0, 0, 1]) cube([30, 14.98, 56]);
		}

		difference() {
			translate([-25, -40, -130]) cube([50, 40, 50]);
			translate([0, 0, -80]) rotate([90, 0, 0]) cylinder(r=15.1, h=102, center=true);
		}
		difference() {
			translate([-25, 10, -130]) cube([50, 40, 50]);
			translate([0, 0, -80]) rotate([90, 0, 0]) cylinder(r=20, h=102, center=true);
		}

		translate([0, 0, 0]) rotate([0, 180, 270]) { %servo_horn(); servo_horn_negative(); translate([0, 0, 49]) cylinder(r=13, h=4); }

		translate([0, -16, -80]) rotate([-90, 0, 0]) {
			difference() {
				cylinder(r=28, h=32, $fn=64);
				translate([0, 0, -1]) cylinder(r1=7, r2=3, h=2);
			}
			translate([0, 0, -6]) rotate([0, 0, 180 / 8]) cylinder(r=1.95, h=10, $fn=8);
		}

		translate([0, 57, -80])
			rotate([90, 270, 0]) {
				%servo(); servo_negative(1); servo_horn_negative();
			}
	}
}

module hip2() {
	translate([-0.5, 0, 0])
	difference() {
		union() {
			translate([-23, -47, 10]) mirror([0, 0, 1]) cube([43, 5, 40]);
			translate([-23, -41.98, 17.5]) mirror([0, 1, 0]) mirror([0, 0, 1]) cube([36.98, 30, 54.98]);
		}
		translate([-17.5, -60, 10]) cube([100, 6, 3]);
		rotate([90, 270, 0]) translate([0, 0, 67]) { %bearing624(); bearing624_negative(); }
		rotate([90, 90, 0]) { %servo_horn(); servo_horn_negative(); translate([0, 0, 46]) cylinder(r=13, h=1); }
		translate([-18, -57, 0]) {
			rotate([0, 90, 0]) {
				servo_negative(); %servo();
				translate([0, 0, -5]) { %bearing624(); bearing624_negative(); }
			}
		}
		difference() {
			translate([-30, -100, 0]) cube([60, 100, 50]);
			translate([0.5, -57, 0]) rotate([90, 0, 0]) cylinder(r=26, h=100, center=true, $fn=64);
		}
		difference() {
			translate([-30, -100, -67]) cube([60, 100, 50]);
			translate([0.5, -57, -17]) rotate([90, 0, 0]) cylinder(r=26, h=100, center=true, $fn=64);
		}
	}
}

module thigh() {
	translate([0, 0, 18]) rotate([0, 90, 0]) shin();
}

torso(10, 10, 10, 10, 10, 10);
