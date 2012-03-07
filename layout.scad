// layout.scad

// NovaRepRap part library by W. Craig Trader is dual-licensed under 
// Creative Commons Attribution-ShareAlike 3.0 Unported License and
// GNU Lesser GPL 3.0 or later.

// To flag a module to generate an STL file, add '/* OUTPUT */'
// after the module definition and before the opening brace ({).

// ----- Measurements ---------------------------------------------------------

TOM_BEDX = 100;
TOM_BEDY = 100;

// ----- Utilities ------------------------------------------------------------

/* tom_print_bed -- lay down markers for the TOM printable area */
module tom_print_bed() {
	LINE = 0.25;

	% translate( [0,0,LINE/2] )
		difference() {
			cube( [ TOM_BEDX, TOM_BEDY, LINE ], center=true );
			cube( [ TOM_BEDX-2*LINE, TOM_BEDY-2*LINE, 2*LINE ], center=true );
		}
	echo( "TOM print bed" );
}

// ----- Imported Parts -------------------------------------------------------


module bar_clamp() {
	import( "STL/bar-clamp.stl" );
}

module belt_clamp() {
	import( "STL/belt-clamp.stl" );
}

module endstop_holder() {
	import( "STL/endstop-holder.stl" );
}

module frame_vertex_with_foot() {
	import( "STL/frame-vertex-with-foot.stl" );
}

module gregs_y_axis_holder() {
	import( "STL/gregs-y-axis-holder.stl" );
}

module idler_bolzen() {
	import( "STL/Idler-bolzen.stl" );
}

module idler_hebel() {
	import( "STL/Idler-Hebel.stl" );
}

module idler() {
	import( "STL/idler.stl" );
}

module j_head_and_mg_mount() {
	import( "STL/J-Head-and-MG-mount.stl" );
}

module large_gear() {
	import( "STL/large-gear.stl" );
}

module pla_coupling() {
	import( "STL/pla_coupling.stl" );
}

module pulley() {
	import( "STL/pulley.stl" );
}

module small_gear() {
	import( "STL/small-gear.stl" );
}

module x_carriage() {
	import( "STL/x-carriage.stl" );
}

module x_end_idler() {
	import( "STL/x-end-idler.stl" );
}

module x_end_motor() {
	import( "STL/x-end-motor.stl" );
}

module y_motor_bracket() {
	import( "STL/y-motor-bracket.stl" );
}

module z_mount_frame_vertex() {
	import( "STL/z-mount-frame-vertex.stl" );
}

// ----- Part arrangements ----------------------------------------------------

module frame_vertex_with_foot_2up() /* OUTPUT */ {
	color( "blue"  ) translate( [+9,+10,0] ) rotate( [0,0,-5] ) frame_vertex_with_foot();
	color( "green" ) translate( [-9,-10,0] ) rotate( [0,0,+175] ) frame_vertex_with_foot();
}

module y_motor_bracket_2up() /* OUTPUT */ {
	color( "blue"  ) translate( [+20,+05,0] ) rotate( [0,0,+008] ) y_motor_bracket();
	color( "green" ) translate( [-20,-05,0] ) rotate( [0,0,+188] ) y_motor_bracket();
}

// ----- Doug's plates

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
plate8();
