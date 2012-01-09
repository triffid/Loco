include <servo.scad>

// set to 0 for display
print = 0;

module arm1(r = 13, h = 10, l = 100, a = 135) {
	union() {
		translate([0, -r, 0]) cube([l, r * 2, h]);
		cylinder(r = r, h = h);
		rotate([0, 0, a]) translate([-r, -r, 0]) cube([r, r, h]);
	}
}

module arm2(r = 13, h = 10, l = 100, a = 0) {
	union() {
		translate([0, -r, 0]) cube([l, r * 2, h]);
		cylinder(r = r, h = h);
		rotate([0, 0, -a]) translate([-r, 0, 0]) cube([r, r, h]);
	}
}

module shin_negative(angle1 = 135, angle2 = 0) {
	render() union() {
		// clear hinge area
		difference() {
			union() {
				// clear hinged area - clearance vs thigh
				translate([0, 0, 3]) cylinder(r=servo_diag1 + 3.5, h=H + G + X + 5.5);
				// clear hinge area - bent position
				rotate([0, 0, 180 + angle1]) translate([0, 0, 3]) arm1(26 / 2, H + G + X + 5.5, 100, angle1);
				// clear hinge area - straight position
				#rotate([0, 0, 180 - angle2]) translate([0, 0, 3]) arm2(26 / 2, H + G + X + 5.5, 100, angle2);
			}
			translate([0, 0, 2.5]) cylinder(r1=7.5 / 2, r2 = 6.5 / 2, h=1);
		}
		// screw hole for M4 bolt opposing horn
		translate([0, 0, -1]) rotate([0, 0, 180 / 8]) cylinder(r = 3.9 / 2, h = 62, $fn=8);
		// position limit shapes to fit arm profile
		difference() {
			translate([-25, -15, -1]) cube([25, 30, 100]);
			translate([0, 0, -2]) {
				cylinder(r = 25 / 2, h = 103);
				rotate([0, 0, -angle2]) translate([-25 / 2, 0, 0]) cube([25 / 2, 25 / 2, 100]);
				rotate([0, 0, angle1]) translate([-25 / 2, -25 / 2, 0]) cube([25 / 2, 25 / 2, 100]);
			}
		}
		// horn negative
		translate([0, 0, 8.5]) servo_horn_negative();
	}
}

module shin(angle1 = 135, angle2 = 0) {
	render()
	difference() {
		render()
		union() {
			translate([-13, -12.5, 0]) cube([J, 25, 5]);
			translate([-13, -12.5, H + G + X + 10]) cube([J, 25, 45 - H - G - X]);
			render()
			intersection() {
				translate([-13, -12.5, 0]) cube([J, 25, 55]);
				union() {
					// clear hinged area - clearance vs thigh
					translate([0, 0, 3]) cylinder(r=servo_diag1 + 3.5 + 3, h=H + G + X + 10);
					// clear hinge area - bent position
					rotate([0, 0, 180 + angle1]) translate([0, 0, 3]) arm1(26 / 2 + 3, H + G + X + 10, 100, angle1);
					// clear hinge area - straight position
					rotate([0, 0, 180 - angle2]) translate([0, 0, 3]) arm2(26 / 2 + 3, H + G + X + 10, 100, angle2);
				}
			}
		}
		shin_negative(angle1, angle2);
	}
}

module thigh_negative(angle1 = 135, angle2 = 0) {
	render() union() {
		rotate([0, 0, -angle1]) translate([0, 0, -1]) arm1(26 / 2, 4.5, 100, angle1);
		// clear hinge area (bottom, near bearing) - straight position
		rotate([0, 0, angle2]) translate([0, 0, -1]) arm2(26 / 2, 4.5, 100, angle2);
		// clear hinge area (bottom, near bearing)
		translate([0, -15, -1]) cube([26, 30, 4.5]);
		// clear hinge area (top, near horn) - bent position
		rotate([0, 0, -angle1]) translate([0, 0, 8.5 + H + G]) arm1(26 / 2, 20, 100, angle1);
		// clear hinge area (top, near horn) - straight position
		rotate([0, 0, angle2]) translate([0, 0, 8.5 + H + G]) arm2(26 / 2, 20, 100, angle2);
		// clear hinge area (top, near horn)
		translate([0, -15, 8.5 + H + G]) cube([25, 30, 20]);
		// servo negative
		difference() {
			translate([0, 0, 8.5]) rotate([0, 0, 180]) servo_negative_side_entry();
			translate([B, -104, 0]) cube([100, 100, 15]);
		}
		// remove coplanar faces and spurious blocks from servo negative (end)
		translate([0, -A * 3 / 2, H + 8.5]) cube([J + 1, A * 2, H +G]);
		// bearing socket
		translate([0, 0, 3.5]) bearing624_negative();
		// cooling ellipse
		translate([-E, 15, 8.5 + ((H + K) / 2)]) scale([1.25, 1, 1]) rotate([90, 0, 0]) cylinder(r = F / 2, h = 30);
		// round off front corners
		difference() {
			translate([0, 0, -1]) cylinder(r=servo_diag1 + 3.5, h = 62);
			translate([0, 0, -2]) cylinder(r=servo_diag1, h = 64, $fn=128);
			translate([-100, -50, -2]) cube([100, 100, 100]);
			rotate([0, 0, -90]) translate([-100, -50, -2]) cube([100, 100, 100]);
		}
	}
}

module thigh(angle1 = 135, angle2 = 0) {
	render()
	difference() {
		translate([E + P, 12.5, 0]) rotate([0, 0, 180]) cube([J + 1, 25, 55]);
		// clear hinge area (bottom, near bearing) - bent position
		thigh_negative(angle1, angle2);
	}
}

knee_min = 135;
knee_max = 0;

knee_angle = (knee_min + knee_max) / 2;

anklefb_min = -60;
anklefb_max = 120;

anklefb_angle = (anklefb_min + anklefb_max) * $t;

anklelr_min = 15;
anklelr_max = 15;

anklelr_angle = (anklelr_min + anklelr_max) / 2;

if (print == 0) {
	//%translate([0, 0, 8.5]) rotate([0, 0, 180]) servo();
	//%translate([0, 0, 8.5]) rotate([0, 0, 180 - angle]) servo_horn();
	//%translate([0, 0, 3.5]) bearing624();
	
	//thigh(135, 0);
	rotate([0, 0, -knee_angle]) {
		render() difference() {
			shin(135, 0);
			translate([J * 2 - 22 - E - P, 0, 0]) mirror([0, 1, 0]) thigh_negative(120, -60);
		}/**/
		translate([J * 2 - 22 - E - P, 0, 0]) {
			mirror([0, 1, 0]) thigh(120, -60);
			
			%translate([0, 0, 8.5]) rotate([0, 0, 180]) servo();
			rotate([0, 0, 60 + anklefb_angle]) {
				render() difference() {
					shin(120, -30);
					difference() {
						translate([0, -50, -0.5]) cube([100, 100, 100]);
						translate([0, 0, -1]) cylinder(r=servo_diag1 + 3.5 + 3, h=60);
					}
				}
				translate([servo_diag1 + 3.5, 0, 55 / 2]) rotate([0, 90, 0]) {
					render() difference() {
						shin(15, 15);
						difference() {
							translate([0, -50, -0.5]) cube([100, 100, 100]);
							translate([0, 0, -1]) cylinder(r=servo_diag1 + 3.5 + 3, h=60);
						}
					}
					rotate([0, 0, -15 + anklelr_angle]) mirror([0, 1, 0]) thigh(15, 15);
				}
			}
			/**/
		}
	}
}
else {
//	translate([-50, -10, -1]) %cube([150, 150, 1]);
//	translate([0, 0, 12.5]) rotate([-90, 0, 0]) shin();
//	translate([30, 70, 12.5]) rotate([-90, 0, 0]) thigh();
//			thigh(105, 90);
}
