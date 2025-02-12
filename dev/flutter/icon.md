```bash

# Linux
# linux -> runner -> my_application.cc 

#    GTK_WINDOW(gtk_application_window_new(GTK_APPLICATION(application))); 后面加上
  GdkPixbuf* icon = gdk_pixbuf_new_from_file("./data/flutter_assets/assets/icons/app-icon.ico", NULL);
  if (icon != NULL) {
    gtk_window_set_icon(GTK_WINDOW(window), icon);
    g_object_unref(icon);
  }


```