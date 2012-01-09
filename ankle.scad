include <servo.scad>

print = 1;

a1 = sin(360 * $t) * 15;
a2 = sin(360 * $t + 90) * 65 - 30;


function dist(a, b) = sqrt(pow(a,2) + pow(b,2));

module peen(r = 20, h = 50) {
	rotate([0, -90, 0]) sphere(r = r, $fn=32);
	mirror([0, 0, 1]) cylinder(r = r, h = h, $fn=32);
}

module foot() {
	render()
	difference() {
		intersection() {
			union() {
				translate([-25, -25, 0]) cube([50, 73, 1]);
				translate([-25, 48, 1]) rotate([0, 90, 0]) cylinder(r=2, h=50, $fn=16);
				translate([-13, -2.5, 0]) cube([26, 5, 21 + 26 / 2]);

				translate([0, 22.5, 20]) rotate([0, 0, -90]) arm(9, 4.5, 19.5);

			}
			translate([0, 15, 0]) scale([1, 1.4, 1]) cylinder(r=30, h=100);
		}

		intersection() {
			translate([0, -44, 21])
			rotate([0, -90, -90])
			servo_horn_negative();
	
			translate([-25, -5, 0]) cube([50, 10, 50]);
		}

		difference() {
			translate([-50, -50, 21]) cube([100, 100, 100]);
			translate([0, -44, 21]) rotate([-90, 0, 0]) cylinder(r=26 / 2, h = 100, $fn=64);
		}

		translate([0, 22.25, 20]) rotate([-90, 0, 0]) bearing624_negative();
	}
}

module ankle() {
	render()
	difference() {
		union() {
			translate([-9 - 5 - 5, 31.98, -E - P + 0.02]) mirror([0, 1, 0]) cube([H + K + 4, 50, J - 0.05]);
		}
		//#translate([-25, -7.5, -20]) cube([50, 10.5, 21 + 13]);
		translate([0, -7.5, 0]) rotate([0, 60, 0]) rotate([0, 0, -90]) arm(14, 10.5, 40);
		translate([0, -7.5, 0]) rotate([0, -15, 0]) rotate([0, 0, -90]) arm(14, 10.5, 40);


		translate([-29, 2, -20]) cube([20, A, 21 + J]);

		rotate([0,  15, 0]) translate([0, 21.95, 0]) rotate([0, 0, -90]) arm(10, 5.5, 30);
		rotate([0, -15, 0]) translate([0, 21.95, 0]) rotate([0, 0, -90]) arm(10, 5.5, 30);
		rotate([0,  60, 0]) translate([0, 21.95, 0]) rotate([0, 0, -90]) arm(10, 5.5, 30);

		translate([16.5, 12, 0])
		rotate([0, -90, 0])
			servo_negative();
		translate([21.52, 12, 0])
			rotate([0, -90, 0]) bearing624_negative();
		translate([15, 8, -20])
			cube([50, 8, 10]);

		translate([0, -44, 0]) 
		rotate([0, -90, -90])
			servo_negative(1);

		translate([0, 22, 0])
			rotate([-90, 0, 0]) bearing624_negative();
		translate([0, 22, 0])
			rotate([-90, 0, 0]) rotate([0, 0, 180 / 8]) cylinder(r=1.9 / cos(180 / 8), h = 30, $fn=8);

		difference() {
			translate([-50, -50, -100 - dist(E + P, A / 2) * 0.6]) cube([100, 100, 100]);
			translate([0, -50, 0]) rotate([0,  90 + 15, 0]) rotate([0, 0, -90]) arm(dist(E + P - 1, A / 2), 100, 50);
			translate([0, -50, 0]) rotate([0, -90 - 15, 0]) rotate([0, 0, -90]) arm(dist(E + P - 1, A / 2), 100, 50);
		}
	}
}

module shin() {
	render()
	difference() {
		union() {
			mirror([0, 0, 0]) translate([30, -13, -13]) mirror([1, 0, 0]) cube([8, 26, 73]);
			mirror([1, 0, 0]) translate([30, -13, -13]) mirror([1, 0, 0]) cube([8, 26, 73]);
			translate([ 22.5, 0, 0]) rotate([0, -90, 0]) rotate([0, 0, 180 / 16]) cylinder(r1=6.5 / 2, r2=5.5 / 2, h=1, $fn=16);
			difference() {
				translate([-26, -13, 0]) cube([52, 26, 60]);
				rotate([0, -90, 0]) cylinder(r=50, h=54, center=true, $fn=64);
			}
		}
		translate([16.5, 0, 0]) rotate([0, -90, 0]) servo_horn_negative();
		rotate([0, -90, 0]) rotate([0, 0, 180 / 8]) cylinder(r=1.9, h=100, center=true, $fn=8);


		render() difference() {
			translate([20, -50, -20]) cube([100, 100, 150]);
			translate([30 - 0.4 * 15 + 0.5, 0, 0]) scale([0.4, 1, 1]) mirror([0, 0, 1]) {
				peen(15, 100);
				render() intersection() {
					cylinder(r = 15, h=50, $fn=32);
					rotate([90 + 35, 0, 0]) cylinder(r=15, h=50, $fn=32);
				}
				translate([-43, 0, 0]) rotate([90 + 35, 0, 0]) cube([43, 15, 15]);/**/
				rotate([0, -90, 0]) cylinder(r = 15, h=50, $fn=32);
				translate([-100, -15, -100]) cube([100, 30, 100]);
			}
		}
		mirror([1, 0, 0]) render() difference() {
			translate([20, -50, -20]) cube([100, 100, 150]);
			translate([30 - 0.4 * 15 + 0.5, 0, 0]) scale([0.4, 1, 1]) mirror([0, 0, 1]) {
				peen(15, 100);
				render() intersection() {
					cylinder(r = 15, h=50, $fn=32);
					rotate([90 + 35, 0, 0]) cylinder(r=15, h=50, $fn=32);
				}
				translate([-43, 0, 0]) rotate([90 + 35, 0, 0]) cube([43, 15, 15]);/**/
				rotate([0, -90, 0]) cylinder(r = 15, h=50, $fn=32);
				translate([-100, -15, -100]) cube([100, 30, 100]);
			}
		}
	}
}

if (print == 0)
{
	foot();
	translate([0, 0, 21]) rotate([0, a1, 0]) ankle();
	translate([0, 12, 21]) rotate([0, a1, 0]) rotate([a2, 0, 0]) shin();

	%translate([0, -44, 21])
	rotate([0, a1 * 1, 0])
	rotate([0, -90, -90])
	union() { servo(); rotate([0, 0, -a1]) servo_horn(); }
	
	%translate([0, 0, 21])
	rotate([0, a1 * 1, 0])
	translate([17, 12, 0]) 
	rotate([0, -90, 0])
	union() { servo(); servo_horn(); }
	
	%translate([0, 22, 21])
	rotate([-90, 0, 0]) bearing624();
}
else {
	%translate([-50, -30, -1]) cube([150, 150, 1]);
	foot();
	translate([62, 0, 21.5]) rotate([0, 0, 90]) rotate([0, 90, 0]) ankle();
	translate([50, 84, 13]) rotate([0, 0, -90]) rotate([90, 0, 0]) shin();
}

/**/

cube([1, 1, 1]);
