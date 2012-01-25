A = 20;
B = 15 - 1.25;
C = 35 - 1.25;
D = 10;
E = 10;
F = 30;
G = 13.25;
H = 25;
I = 7; // height of mounting wings
J = 55;
K = 11.5;
L = 4.2;
M = 40;
P = (J - M) / 2;
Q = 44 -  G - H;
X = 3;

echo("H + K = ", H + K);
echo("H + G = ", H + G);
echo("Q = ", Q);

M3_nut_radius = 5.6 / cos(180 / 6) / 2;
M3_washer_radius = 7.5 / 2 / cos(180 / 12);

servo_diag1 = sqrt(pow((J  - M) / 2 + E, 2) + pow(A / 2, 2));
servo_diag2 = sqrt(pow((J  - M) / 2 + F, 2) + pow(A / 2, 2));

negative_clearance = 0.25;

module arm(r = 13, w = 5, l = 40) {
	render()
	rotate([0, -90, 0]) {
		cylinder(r = r, h = w, $fn=64);
		translate([-l, -r, 0]) cube([l, r * 2, w]);
	}
}

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
	translate([0, 0, -0.1]) cylinder(r=13 / 2 + 0.25, h = 5.2);
}

module servo() {
	render() {
		translate([-E, -A / 2, 0]) cube([M, A, H + K]);
		difference() {
			translate([-E - P, A / -2, H]) cube([J, A, I]);
			translate([-B, -D / 2, H - 1]) cylinder(r=L / 2, h = I +2, $fn=8);
			translate([-B, D / 2, H - 1]) cylinder(r=L / 2, h = I + 2, $fn=8);
			translate([C, -D / 2, H - 1]) cylinder(r=L / 2, h = I + 2, $fn=8);
			translate([C, D / 2, H - 1]) cylinder(r=L / 2, h = I + 2, $fn=8);
		}
		translate([0, 0, H]) cylinder(r = A / 2.5, h=G);
		translate([0, 0, H + K]) cylinder(r = 5 / 2, h=X + (G - K), $fn=16);
	}
}

module servo_negative(mount_orientation = 0) {
	//render()
	{
		servo();
		translate([-E - negative_clearance, -A / 2 - negative_clearance, -negative_clearance]) cube([M + negative_clearance * 2, A + negative_clearance * 2, H + G + negative_clearance * 2]);
		translate([0, 0, H]) cylinder(r = A / 2.5 + negative_clearance, h=G + negative_clearance);
	
		translate([-E - P, A / -2, H]) cube([J, A, I]);
		if (mount_orientation == 0) {
			translate([-B, -D / 2, H - 10]) rotate([0, 0, 180 / 8]) cylinder(r=2.95 / 2, h = 21, $fn=8);
			translate([-B, D / 2, H - 10]) rotate([0, 0, 180 / 8]) cylinder(r=2.95 / 2, h = 21, $fn=8);
			translate([C, -D / 2, H - 10]) rotate([0, 0, 180 / 8]) cylinder(r=2.95 / 2, h = 21, $fn=8);
			translate([C, D / 2, H - 10]) rotate([0, 0, 180 / 8]) cylinder(r=2.95 / 2, h = 21, $fn=8);
	
			translate([-B, -D / 2, H]) rotate([0, 0, 180 / 12]) cylinder(r=M3_washer_radius, h = H + 5, $fn=12);
			translate([-B, D / 2, H]) rotate([0, 0, 180 / 12]) cylinder(r=M3_washer_radius, h = H + 5, $fn=12);
			translate([C, -D / 2, H]) rotate([0, 0, 180 / 12]) cylinder(r=M3_washer_radius, h = H + 5, $fn=12);
			translate([C, D / 2, H]) rotate([0, 0, 180 / 12]) cylinder(r=M3_washer_radius, h = H + 5, $fn=12);
		}
		else {
			translate([-B, -D / 2, H]) rotate([0, 0, 180 / 8]) cylinder(r=2.95 / 2, h = 21, $fn=8);
			translate([-B, D / 2, H]) rotate([0, 0, 180 / 8]) cylinder(r=2.95 / 2, h = 21, $fn=8);
			translate([C, -D / 2, H]) rotate([0, 0, 180 / 8]) cylinder(r=2.95 / 2, h = 21, $fn=8);
			translate([C, D / 2, H]) rotate([0, 0, 180 / 8]) cylinder(r=2.95 / 2, h = 21, $fn=8);

			translate([-B, -D / 2, -10]) rotate([0, 0, 180 / 12]) cylinder(r=M3_washer_radius, h = H + 15, $fn=12);
			translate([-B, D / 2, -10]) rotate([0, 0, 180 / 12]) cylinder(r=M3_washer_radius, h = H + 15, $fn=12);
			translate([C, -D / 2, -10]) rotate([0, 0, 180 / 12]) cylinder(r=M3_washer_radius, h = H + 15, $fn=12);
			translate([C, D / 2, -10]) rotate([0, 0, 180 / 12]) cylinder(r=M3_washer_radius, h = H + 15, $fn=12);
		}
	
		translate([0, 0, H]) rotate([0, 0, 180 / 6]) cylinder(r=M3_nut_radius, h = H + 5, $fn=16);
	
		translate([-E, 0, 1])rotate([0, 20, 180]) translate([-10, -4.5, 0]) cube([100, 9, 4]);
	}
}

module servo_negative_side_entry() {
	servo_negative();
	// side entry: mounting tabs
	translate([-E - P, A / -2, H]) cube([J, A * 2, I]);
	// side entry: body
	translate([-E - negative_clearance, -A / 2 - negative_clearance, -negative_clearance]) cube([M + negative_clearance * 2, A * 2 + negative_clearance * 2, H + G + negative_clearance * 2]);
	// side entry: cable
	translate([-E, negative_clearance, 1]) rotate([0, -20, 0]) translate([-90, 0, 0]) cube([100, A * 1.5, 4]);
}

module horn_pin() {
	render() {
		cylinder(r=1.5 / 2, h=Q * 5, $fn=8);
		//translate([0, 0, Q + 3]) cylinder(r=1.2, h=Q * 2, $fn=8);
	}
}

module servo_horn() {
	render()
	translate([0, 0, H + G]) difference() {
		cylinder(r = 24 / 2 + negative_clearance, h=Q);
		cylinder(r = 7 / 2 + negative_clearance, h=30);
		for (n=[0:2]) {
			rotate([0, 0, -20 + n * 20]) translate([8.5, 0, 0]) horn_pin();
			rotate([0, 0, -20 + n * 20]) translate([-8.5, 0, 0]) horn_pin();
			rotate([0, 0, 90 -20 + n * 20]) translate([7, 0, 0]) horn_pin();
			rotate([0, 0, 90 -20 + n * 20]) translate([-7, 0, 0]) horn_pin();
			rotate([0, 0, 90 -20 + n * 20]) translate([10, 0, 0]) horn_pin();
			rotate([0, 0, 90 -20 + n * 20]) translate([-10, 0, 0]) horn_pin();
		}
		difference() {
			cylinder(r=50, h=Q - 2);
			cylinder(r=9 / 2, h = Q);
		}
	}
}

module servo_horn_negative() {
	//render()
	translate([0, 0, H + G]) {
		cylinder(r = 24 / 2 + negative_clearance, h=Q);
		cylinder(r = 7 / 2 + negative_clearance, h=30);
		for (n=[0:2]) {
			if (n != 1) {
				rotate([0, 0, -20 + n * 20]) translate([8.5, 0, 0]) horn_pin();
				rotate([0, 0, -20 + n * 20]) translate([-8.5, 0, 0]) horn_pin();
				//rotate([0, 0, 90 -20 + n * 20]) translate([7, 0, 0]) horn_pin();
				//rotate([0, 0, 90 -20 + n * 20]) translate([-7, 0, 0]) horn_pin();
				rotate([0, 0, 90 -20 + n * 20]) translate([10, 0, 0]) horn_pin();
				rotate([0, 0, 90 -20 + n * 20]) translate([-10, 0, 0]) horn_pin();
			}
		}
	}
}

//servo();
//servo_horn_negative();
//%servo_negative(1);

//servo_negative_side_entry();

