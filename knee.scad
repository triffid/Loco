include <servo.scad>

// set to 0 for display
print = 0;

min_bend_angle_1 = 135;
min_bend_angle_2 = 0;

angle = -min_bend_angle_2 + (min_bend_angle_1 + min_bend_angle_2) * sin($t * 180);

echo(angle);

module bearing624() {
	difference() {
		cylinder(r=13 / 2, h = 5);
		translate([0, 0, -1]) cylinder(r = 4 / 2, h = 7);
		difference() {
			translate([0, 0, 4.5]) cylinder(r1 = 10 / 2, r2 = 12 / 2, h = 1);
			translate([0, 0, 4.25]) cylinder(r1 = 8 / 2, r2 = 6 / 2, h = 1);
		}
		difference() {
			translate([0, 0, -0.5]) cylinder(r1 = 12 / 2, r2 = 10 / 2, h = 1);
			translate([0, 0, -0.25]) cylinder(r1 = 6 / 2, r2 = 8 / 2, h = 1);
		}
	}
}

module bearing624_negative() {
	cylinder(r=13 / 2 + 0.25, h = 5);
}

module arm1(r = 13, h = 10, l = 100) {
	union() {
		translate([0, -r, 0]) cube([l, r * 2, h]);
		cylinder(r = r, h = h);
		rotate([0, 0, min_bend_angle_1]) translate([-r, -r, 0]) cube([r, r, h]);
	}
}

module arm2(r = 13, h = 10, l = 100) {
	union() {
		translate([0, -r, 0]) cube([l, r * 2, h]);
		cylinder(r = r, h = h);
		rotate([0, 0, -min_bend_angle_2]) translate([-r, 0, 0]) cube([r, r, h]);
	}
}

module shin() {
	difference() {
		translate([-13, -12.5, 0]) cube([J, 25, 60]);
		translate([0, 0, 5]) cylinder(r=servo_diag1 + 3, h=H + G + X + 5);
		translate([0, 0, -1]) cylinder(r = 3.9 / 2, h = 62);
		difference() {
			translate([-25, -15, -1]) cube([25, 30, 100]);
			translate([0, 0, -2]) {
				cylinder(r = 25 / 2, h = 103);
				rotate([0, 0, -min_bend_angle_2]) translate([-25 / 2, 0, 0]) cube([25 / 2, 25 / 2, 100]);
				rotate([0, 0, min_bend_angle_1]) translate([-25 / 2, -25 / 2, 0]) cube([25 / 2, 25 / 2, 100]);
			}
		}
		rotate([0, 0, 180 + min_bend_angle_1]) translate([0, 0, 5]) arm1(26 / 2, H + G + X + 5, 100);
		rotate([0, 0, 180 - min_bend_angle_2]) translate([0, 0, 5]) arm2(26 / 2, H + G + X + 5, 100);
		translate([0, 0, 10]) servo_horn_negative();
	}
}

module thigh() {
	difference() {
		translate([E + (J - M) / 2, 12.5, 0]) rotate([0, 0, 180]) cube([J + (J - M) / 2, 25, 60]);
		rotate([0, 0, -min_bend_angle_1]) translate([0, 0, -1]) arm1(26 / 2, 6.1, 100);
		rotate([0, 0, min_bend_angle_2]) translate([0, 0, -1]) arm2(26 / 2, 6.1, 100);
		translate([0, -15, -1]) cube([26, 30, 6.1]);
		rotate([0, 0, -min_bend_angle_1]) translate([0, 0, 10 + H + G]) arm1(26 / 2, 20, 100);
		rotate([0, 0, min_bend_angle_2]) translate([0, 0, 10 + H + G]) arm2(26 / 2, 20, 100);
		translate([0, -15, 10 + H + G]) cube([25, 30, 20]);
		translate([0, 0, 10]) rotate([0, 0, 180]) servo_negative();
		translate([0, -A / 2, H + 10]) cube([J + 1, A, H +G]);
		translate([-F - (J - M) / 2, -A / 2 - 10, H + 10]) cube([J + 1, A, G + 0.02]);
		translate([-F, -A / 2 - 10, 10]) cube([M, A, H+ 0.02]);
		translate([E, 0, 11]) rotate([0, 20, 0]) translate([-10, -4.5 - 21, 0]) cube([100, 30, 4]);
		translate([0, 0, 5]) bearing624_negative();
		translate([-E, 15, 10 + ((H + K) / 2)]) scale([1.25, 1, 1]) rotate([90, 0, 0]) cylinder(r = F / 2, h = 30);
	}
}

if (print == 0) {
	%#translate([0, 0, 10]) rotate([0, 0, 180]) servo();
	%#translate([0, 0, 10]) rotate([0, 0, 180 - angle]) servo_horn();
	%#translate([0, 0, 5]) bearing624();
	
	rotate([0, 0, -angle]) shin();
	thigh();
}
else {
	translate([-50, -10, -1]) %cube([150, 150, 1]);
	translate([0, 0, 12.5]) rotate([-90, 0, 0]) shin();
	translate([30, 70, 12.5]) rotate([-90, 0, 0]) thigh();
}
