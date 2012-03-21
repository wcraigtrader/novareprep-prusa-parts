// layout.scad

// NovaRepRap part library by W. Craig Trader is dual-licensed under 
// Creative Commons Attribution-ShareAlike 3.0 Unported License and
// GNU Lesser GPL 3.0 or later.

// To flag a module to generate an STL file, add '/* OUTPUT */'
// after the module definition and before the opening brace ({).

// ----- Measurements ---------------------------------------------------------

TOM_BEDX = 105;
TOM_BEDY = 105;

// ----- Utilities ------------------------------------------------------------

/* tom_print_bed -- lay down markers for the TOM printable area */
module tom_print_bed() {
	LINE = 0.25;

	% translate( [0,0,LINE/2] )
		difference() {
			cube( [ TOM_BEDX, TOM_BEDY, LINE ], center=true );
			cube( [ TOM_BEDX-2*LINE, TOM_BEDY-2*LINE, 2*LINE ], center=true );
		}
}

/* n_up -- copy a child multiple times */
module n_up( x_qty=1, y_qty=1, xkern=0, ykern=0 ) {
	x_max = TOM_BEDX - xkern;
	y_max = TOM_BEDY - ykern;
	x_size = x_max / x_qty;
	y_size = y_max / y_qty;
	x_start = x_size/2 - x_max/2;
	y_start = y_size/2 - y_max/2;

	for (x = [0 : x_qty-1] ) {
		for (y = [0 : y_qty-1] ) {
			for (i = [0 : $children-1]) {
				translate( [x_start+x*x_size, y_start+y*y_size,0] )
					child(i);
			}
		}
	}
}

module place( translation=[0,0,0], angle=0, hue="gold" ) {
	for (i = [0 : $children-1]) {
		color( hue ) 
			translate( translation ) 
				rotate( a=angle ) 
					child(i);
	}
}

// ----- Imported Parts -------------------------------------------------------


module bar_clamp() /* OUTPUT */ {
	import( "jason-models/bar-clamp.stl" );
}

module belt_clamp() /* OUTPUT */ {
	import( "jason-models/belt-clamp.stl" );
}

module endstop() /* OUTPUT */ {
	import( "jason-models/endstop-holder.stl" );
}

module frame_vertex_with_foot() /* OUTPUT */ {
	import( "jason-models/frame-vertex-with-foot.stl" );
}

module idler() /* OUTPUT */ {
	import( "jason-models/idler-fixed.stl" );
}

module idler_bolzen() /* OUTPUT */ {
	import( "jason-models/Idler-bolzen.stl" );
}

module idler_hebel() /* OUTPUT */ {
	import( "jason-models/Idler-Hebel.stl" );
}

module j_head_and_mg_mount() {
	import( "jason-models/J-Head-and-MG-mount-fixed.stl" );
}

module large_gear() /* OUTPUT */ {
	import( "jason-models/large-gear.stl" );
}

module pla_coupling() /* OUTPUT */ {
	import( "jason-models/pla_coupling.stl" );
}

module pulley() /* OUTPUT */ {
	import( "jason-models/pulley.stl" );
}

module small_gear() /* OUTPUT */ {
	import( "jason-models/small-gear-fixed.stl" );
}

module x_carriage() {
	import( "jason-models/x-carriage-fixed.stl" );
}

module x_end_idler() /* OUTPUT */ {
	import( "jason-models/x-end-idler-fixed.stl" );
}

module x_end_motor() {
	import( "jason-models/x-end-motor-fixed.stl" );
}

module y_axis_holder() /* OUTPUT */ {
	import( "jason-models/gregs-y-axis-holder.stl" );
}

module y_motor_bracket() /* OUTPUT */ {
	import( "jason-models/y-motor-bracket.stl" );
}

module z_mount_frame_vertex() /* OUTPUT */ {
	import( "jason-models/z-mount-frame-vertex-fixed.stl" );
}

// ----- Part arrangements ----------------------------------------------------

// ----- Frame parts ----------------------------------------------------------

module bar_clamp_8up() /* OUTPUT */ {
	n_up( 4, 2 ) bar_clamp();
}

module frame_vertex_with_foot_2up() /* OUTPUT */ {
	place( [+9,+10,0], -5,   "blue" ) frame_vertex_with_foot();
	place( [-9,-10,0], +175, "plum" ) frame_vertex_with_foot();
}

module y_motor_bracket_2up() /* OUTPUT */ {
	place( [+20,+5,0], +008, "plum" ) y_motor_bracket();
	place( [-20,-5,0], +188, "teal" ) y_motor_bracket();
}

// ----- Z-Axis parts ---------------------------------------------------------

module z_axis_coupler_12up() /* OUTPUT */ {
	n_up( 4, 3, 0, 0 ) rotate( a=90 ) pla_coupling();
}

// ----- Y-Axis parts ---------------------------------------------------------

module belt_clamp_18up() /* OUTPUT */ {
	n_up( 3, 6 ) belt_clamp();
}

module y_axis_holder_6up() /* OUTPUT */ {
	n_up( 3, 2 ) y_axis_holder();
}

module y_axis_pulley_12up() /* OUTPUT */ {
	n_up( 3, 4 ) pulley();
}

// ----- X-Axis parts ---------------------------------------------------------

// ----- Extruder parts -------------------------------------------------------

module idler_6up() /* OUTPUT */ {
	n_up( 3,2, 5 ) idler();
}

// This was a thought experiment, don't need that many of this part.
module idler_hebel_12up() /* OUTPUT */ {
	n_up( 3, 2, xkern=10, ykern=4 ) 
	rotate( [0,0,30] ) {
		place( [+6,+10,0], 045, "plum" ) idler_hebel();
		place( [-6,-10,0], 225, "teal" ) idler_hebel();
	}
}

// This doesn't work because the idler and the mount models have problems.
module extruder() {
	place( [+30,+40,0], 00, "blue" ) idler_bolzen();
	place( [+05,-35,0], 90, "cyan" ) idler_hebel();
	place( [+10,+00,0], 00, "teal" ) j_head_and_mg_mount();
	place( [+05,+35,0], 00, "plum" ) small_gear();
	place( [-31,+00,0], 00, "gray" ) idler();
}

// ----- Electronics parts ----------------------------------------------------

module endstop_8up() /* OUTPUT */ {
	n_up( 4,1 ) { 
		place( [0,+15,0], +90, "plum" ) endstop();
		place( [0,-15,0], -90, "teal" ) endstop();
	}
}

// ----- Doug's plates --------------------------------------------------------

module plate8 () {
	translate ([13,2,0]) rotate ([0,0,8]) y_motor_bracket();
	translate ([-13,-2,0]) rotate ([0,0,188]) y_motor_bracket();
}

module plate7() {
	translate ([-12,33,0]) x_end_idler();
	translate ([8,-22,0]) rotate ([0,0,90]) x_end_motor();
}

module plate6 () {
	translate ([0,20,0]) {
		translate ([0,-7,0]) belt_clamp();
		translate ([0,7,0]) belt_clamp();
		translate ([0,-21,0]) belt_clamp();
		translate ([0,21,0]) belt_clamp();

		//translate ([0,-35,0]) rotate ([0,0,90]) rodclamp ();
		//translate ([0,35,0]) rotate ([0,0,90]) rodclamp ();
	}

	translate ([28,37,0]) pulley ();
	translate ([28,15,0]) pulley ();
}

module plate4 () {
	translate([0,0,0]) rotate([0,0,0]) vertex();
}

module plate2_3 () {
	#translate([-8,-12,0]) rotate([0,0,178]) frame_vertex_with_foot();
	translate([8,12,0]) rotate([0,0,-2]) frame_vertex_with_foot();
}

module plate1 () {
	translate ([0,0,0]) {
		translate([-30,0,0]) rotate([0,0,0]) bar_clamp ();
		translate([-30,19,0]) rotate([0,0,0]) bar_clamp ();
		translate([-30,-19,0]) rotate([0,0,0]) bar_clamp ();
		translate([-30,38,0]) rotate([0,0,0]) bar_clamp ();
		translate([0,0,0]) rotate([0,0,0]) bar_clamp ();
		translate([0,19,0]) rotate([0,0,0]) bar_clamp ();
		translate([0,-19,0]) rotate([0,0,0]) bar_clamp ();
		translate([0,38,0]) rotate([0,0,0]) bar_clamp ();
	}

	translate([-15, -38, 0]) endstop ();
	translate([30, 20, 0]) rotate ([0,0,90]) endstop ();
	translate([30, -20, 0]) rotate ([0,0,-90]) endstop ();
}

// ----- Working set ----------------------------------------------------------

tom_print_bed();
n_up( 4, 3, 0, 0 ) rotate( a=90 ) pla_coupling();
