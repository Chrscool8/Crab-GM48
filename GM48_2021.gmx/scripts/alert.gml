///alert(text)

var h = instance_create(0, 0, obj_alert_text);
h.str = argument[0];
if (argument_count == 2)
    h.persist = 0;
