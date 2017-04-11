using Gtk;
using Emeus;

int main (string[] args) {
	Gtk.init (ref args);

	var window = new Gtk.Window ();
	window.title = "Hello World!";
	window.set_border_width (12);
	window.set_position (Gtk.WindowPosition.CENTER);
	window.set_default_size (350, 70);
	window.destroy.connect (Gtk.main_quit);

	var box = new Gtk.Box (Gtk.Orientation.VERTICAL, 6);
	window.add (box);
	box.show ();

	var layout = new Emeus.ConstraintLayout ();
	box.add (layout);
	layout.show ();

	var button0 = new Gtk.Button.with_label ("Child 0");
	layout.pack (button0, "view0");
	button0.set_name ("view0");
	button0.show ();
	
	var button1 = new Gtk.Button.with_label ("Child 1");
	layout.pack (button1, "view1");
	button1.set_name ("view1");
	button1.show ();
	
	var button2 = new Gtk.Button.with_label ("Child 2");
	layout.pack (button2, "view2");
	button2.set_name ("view2");
	button2.show ();

	const string[] layout_string = {
		"H:|-[view0]-[view1(view0)]-|",
		"[view2(view1)]-|",
		"V:|-[view0]-|",
		"V:|-[view1]-[view2(view1)]-|"
	};
	
	var widgets = new HashTable<string,Gtk.Widget> (str_hash, str_equal);
	widgets.insert ("view0", button0);
	widgets.insert ("view1", button1);
	widgets.insert ("view2", button2);

	var metrics = new HashTable<string,double?> (str_hash, str_equal);
	metrics.insert ("test", 5);

	var constraints = Emeus.create_constraints_from_description (layout_string, 6, 6, widgets, metrics);

	foreach (var c in constraints) {
		if (c != null)
			layout.add_constraint (c);
	}

	// layout.add_constraints (c);

	box.add (new Gtk.Label ("hi"));
	window.show_all ();

	Gtk.main ();
	return 0;
}
