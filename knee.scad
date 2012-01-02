include <servo.scad>

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
	cylinder(r=13 / 2, h = 5);
}

module arm(r = 13, h = 10, l = 100) {
	union() {
		translate([0, -r, 0]) cube([l, r * 2, h]);
		cylinder(r = r, h = h);
	}
}

min_bend_angle_1 = 150;
min_bend_angle_2 = 5;

angle = -min_bend_angle_2 + (min_bend_angle_1 + min_bend_angle_2) * $t;

echo(angle);

%translate([0, 0, 10]) rotate([0, 0, 180 + angle]) servo();
%translate([0, 0, 5]) bearing624();

render()
difference() {
	translate([-10, -12.5, 0]) cube([100, 25, 60]);
	translate([0, 0, 5]) cylinder(r=servo_diag1 + 2, h=H + G + X + 5);
	translate([0, 0, -1]) cylinder(r = 4.2 / 2, h = 62);
	difference() {
		translate([-25, -15, -1]) cube([25, 30, 100]);
		translate([0, 0, -2]) cylinder(r = 25 / 2, h = 103);
	}
	rotate([0, 0, 180 + min_bend_angle_1]) translate([0, 0, 5]) arm(26 / 2, H + G + X + 5, 100);
	rotate([0, 0, 180 - min_bend_angle_2]) translate([0, 0, 5]) arm(26 / 2, H + G + X + 5, 100);
}

rotate([0, 0, angle]) render()
difference() {
	translate([-100 + E + (J - M) / 2, -12.5, 0]) cube([100, 25, 60]);
	rotate([0, 0, -min_bend_angle_1]) translate([0, 0, -1]) arm(26 / 2, 6.1, 100);
	rotate([0, 0, min_bend_angle_2]) translate([0, 0, -1]) arm(26 / 2, 6.1, 100);
	rotate([0, 0, -min_bend_angle_1]) translate([0, 0, 10 + H + G]) arm(26 / 2, 20, 100);
	rotate([0, 0, min_bend_angle_2]) translate([0, 0, 10 + H + G]) arm(26 / 2, 20, 100);
	translate([0, -15, 10 + H + G]) cube([25, 30, 20]);
	translate([0, 0, 10]) rotate([0, 0, 180]) servo_negative();
	translate([-E, -A / 2, H + 10]) cube([J + 1, A, H +G]);
	translate([0, 0, 5]) bearing624_negative();
	translate([-E, 15, 10 + ((H + K) / 2)]) scale([1.25, 1, 1]) rotate([90, 0, 0]) cylinder(r = F / 2, h = 30);
}