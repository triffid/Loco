A = 20;
B = 15;
C = 35;
D = 10;
E = 10;
F = 30;
G = 12;
H = 28;
J = 55;
K = 10;
L = 4.2;
M = 40;
X = 4;

M3_nut_radius = 5.5 / cos(180 / 6) / 2;

servo_diag1 = sqrt(pow((J  - M) / 2 + E, 2) + pow(A / 2, 2));
servo_diag2 = sqrt(pow((J  - M) / 2 + F, 2) + pow(A / 2, 2));

negative_clearance = 0.25;

module servo() {
	translate([-E, -A / 2, 0]) cube([M, A, H + K]);
	difference() {
		translate([-E - (J - M) / 2, A / -2, H]) cube([J, A, 2]);
		translate([-B, -D / 2, H - 1]) cylinder(r=L / 2, h = 4, $fn=8);
		translate([-B, D / 2, H - 1]) cylinder(r=L / 2, h = 4, $fn=8);
		translate([C, -D / 2, H - 1]) cylinder(r=L / 2, h = 4, $fn=8);
		translate([C, D / 2, H - 1]) cylinder(r=L / 2, h = 4, $fn=8);
	}
	translate([0, 0, H]) cylinder(r = A / 2.5, h=G);
	translate([0, 0, H + K]) cylinder(r = 5 / 2, h=X + (G - K), $fn=16);
}

module servo_negative() {
	servo();
	translate([-E - negative_clearance, -A / 2 - negative_clearance, -negative_clearance]) cube([M + negative_clearance * 2, A + negative_clearance * 2, H + G + negative_clearance * 2]);
	translate([0, 0, H]) cylinder(r = A / 2.5 + negative_clearance, h=G + negative_clearance);

	translate([-E - (J - M) / 2, A / -2, H]) cube([J, A, K]);

	translate([-B, -D / 2, H - 10]) cylinder(r=L / 2, h = 12, $fn=8);
	translate([-B, D / 2, H - 10]) cylinder(r=L / 2, h = 12, $fn=8);
	translate([C, -D / 2, H - 10]) cylinder(r=L / 2, h = 12, $fn=8);
	translate([C, D / 2, H - 10]) cylinder(r=L / 2, h = 12, $fn=8);
	translate([-B, -D / 2, -50]) rotate([0, 0, 180 / 6]) cylinder(r=M3_nut_radius, h = H + 45, $fn=6);
	translate([-B, D / 2, -50]) rotate([0, 0, 180 / 6]) cylinder(r=M3_nut_radius, h = H + 45, $fn=6);
	translate([C, -D / 2, -50]) rotate([0, 0, 180 / 6]) cylinder(r=M3_nut_radius, h = H +45, $fn=6);
	translate([C, D / 2, -50]) rotate([0, 0, 180 / 6]) cylinder(r=M3_nut_radius, h = H + 45, $fn=6);
	translate([-B, -D / 2, H]) rotate([0, 0, 180 / 6]) cylinder(r=M3_nut_radius, h = H + 5, $fn=6);
	translate([-B, D / 2, H]) rotate([0, 0, 180 / 6]) cylinder(r=M3_nut_radius, h = H + 5, $fn=6);
	translate([C, -D / 2, H]) rotate([0, 0, 180 / 6]) cylinder(r=M3_nut_radius, h = H + 5, $fn=6);
	translate([C, D / 2, H]) rotate([0, 0, 180 / 6]) cylinder(r=M3_nut_radius, h = H + 5, $fn=6);

	translate([0, 0, H]) rotate([0, 0, 180 / 6]) cylinder(r=M3_nut_radius, h = H + 5, $fn=6);
}

//servo();
//%servo_negative();
