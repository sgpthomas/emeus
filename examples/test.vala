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

	var button1 = new Gtk.Button.with_label ("Child 1");
	layout.pack (button1, "child1");
	button1.show ();
	
	var button2 = new Gtk.Button.with_label ("Child 2");
	layout.pack (button2, "child2");
	button2.show ();
	
	var button3 = new Gtk.Button.with_label ("Child 3");
	layout.pack (button3, "child3");
	button3.show ();

	var contraints = Emeus.create_constraints_from_description (
		{
			"|-[child0]-[child1(child0)]-|",
			"[child2(child1)]-|",
			"V:|-[child0]-|",
			"V:|-[child1]-[child2(child1)]-|"
		}, 6, 6,
		{
			child1 : button1,
			child2 : button2,
			child3 : button3
		}, { });

	layout.add_constraints (constraints);

	window.show_all ();

	Gtk.main ();
	return 0;
}