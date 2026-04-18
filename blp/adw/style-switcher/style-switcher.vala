[GtkTemplate (ui = "/dev/vala-lang/examples/StyleSwitcher/style-switcher.ui")]
public class StyleSwitcher : Gtk.Box {

    [GtkChild] unowned Gtk.CheckButton system_selector;
    [GtkChild] unowned Gtk.CheckButton light_selector;
    [GtkChild] unowned Gtk.CheckButton dark_selector;

    private Adw.StyleManager style_manager;

    public StyleSwitcher () {
        this.style_manager = Adw.StyleManager.get_default ();

        // Sync UI with current system state on init
        var scheme = style_manager.get_color_scheme ();
        if (scheme == Adw.ColorScheme.FORCE_LIGHT) {
            light_selector.active = true;
        } else if (scheme == Adw.ColorScheme.FORCE_DARK) {
            dark_selector.active = true;
        } else {
            system_selector.active = true;
        }


    }
    [GtkCallback]
        private void theme_check_active_changed () {
            if (this.system_selector.active) {
                style_manager.set_color_scheme (Adw.ColorScheme.DEFAULT);
            } else if (this.light_selector.active) {
                style_manager.set_color_scheme (Adw.ColorScheme.FORCE_LIGHT);
            } else if (this.dark_selector.active) {
                style_manager.set_color_scheme (Adw.ColorScheme.FORCE_DARK);
            }
        }
}


[GtkTemplate (ui = "/dev/vala-lang/examples/StyleSwitcher/window.ui")]
public class MainWindow : Adw.ApplicationWindow {

        [GtkChild] private unowned Gtk.PopoverMenu popover_menu;
        public MainWindow (Adw.Application app) {
            GLib.Object (application : app);
            var style_switcher = new StyleSwitcher ();
            popover_menu.add_child (style_switcher, "style-switcher"); // Add style switcher to popover
        }
}

    void main (string[] args) {
        var app = new Adw.Application ("dev.vala-lang.examples.StyleSwitcher", GLib.ApplicationFlags.FLAGS_NONE);
            app.activate.connect (() => {
                var win = new MainWindow (app);


                win.present ();
            });
        app.run (args);
    }


