public class Customer : GLib.Object {
    public string first_name { get; set; }
    public string last_name { get; set; }
    public string id { get; set; }

    public Customer (string first_name, string last_name, string id) {
        Object (
            first_name: first_name,
            last_name: last_name,
            id: id
        );
    }
}

public class ListViewSample : Gtk.Application {
    public ListViewSample () {
        Object (application_id: "com.example.ListViewSample");
    }

    public override void activate () {
        var window = new Gtk.ApplicationWindow (this) {
            title = "ListView Sample",
            default_width = 240,
            default_height = 400
        };

        var customers = new GLib.ListStore(typeof (Customer));
        var selection_model = new Gtk.SingleSelection (customers) {
            autoselect = true
        };

        customers.append (new Customer ("Linus", "Legend", "1991"));
        customers.append (new Customer ("John", "Smith", "1992"));
        customers.append (new Customer ("Alice", "Key", "1993"));
        customers.append (new Customer ("Bob", "Key", "1994"));
        customers.append (new Customer ("Jane", "Doe", "1995"));
        customers.append (new Customer ("Gabe", "Goode", "1996"));

        var list_view_factory = new Gtk.SignalListItemFactory ();
        list_view_factory.setup.connect (on_list_view_setup);
        list_view_factory.bind.connect (on_list_view_bind);

        var list_view_header_factory = new Gtk.SignalListItemFactory ();
        list_view_header_factory.setup.connect (on_list_view_header_setup);
        list_view_header_factory.bind.connect (on_list_view_header_bind);

        var list_view = new Gtk.ListView (selection_model, list_view_factory);
        list_view.header_factory = list_view_header_factory;

        window.child = list_view;
        window.present ();
    }

    private void on_list_view_setup (Gtk.SignalListItemFactory factory, GLib.Object list_item_obj) {
        var vbox = new Gtk.Box (Gtk.Orientation.VERTICAL, 4);
        var name_label = new Gtk.Label ("");
        name_label.halign = Gtk.Align.START;

        var id_label = new Gtk.Label ("");
        id_label.halign = Gtk.Align.START;

        vbox.append (name_label);
        vbox.append (id_label);
        (list_item_obj as Gtk.ListItem).child = vbox;
    }

    private void on_list_view_bind (Gtk.SignalListItemFactory factory, GLib.Object list_item_obj) {
        var list_item = list_item_obj as Gtk.ListItem;
        var item_data = list_item.item as Customer;
        var vbox = list_item.child as Gtk.Box;
        var name_label = vbox.get_first_child () as Gtk.Label;
        var id_label = name_label.get_next_sibling () as Gtk.Label;

        name_label.label = @"$(item_data.first_name) $(item_data.last_name)";
        id_label.label = @"ID: $(item_data.id)";
    }

    private void on_list_view_header_setup (Gtk.SignalListItemFactory factory, GLib.Object list_header_obj) {
        var header_label = new Gtk.Label ("");
        header_label.halign = Gtk.Align.START;
        (list_header_obj as Gtk.ListHeader).child = header_label;
    }

    private void on_list_view_header_bind (Gtk.SignalListItemFactory factory, GLib.Object list_header_obj) {
        var list_header = list_header_obj as Gtk.ListHeader;
        var header_label = list_header.child as Gtk.Label;
        header_label.label = "Customers";
    }

    public static int main (string[] args) {
        var app = new ListViewSample ();
        return app.run (args);
    }
}

