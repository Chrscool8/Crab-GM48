///alert(text)

/*with(obj_alert_text)
{
    persist = 0;
    spd = max(spd, 4);
}*/

var lowest = view_hport;
with(obj_alert_text)
{
    if yy < lowest
        lowest = yy//-40
}

var num = instance_number(obj_alert_text);
var h = instance_create(0, 0, obj_alert_text);
h.str = argument[0];
if (argument_count == 2)
    h.persist = argument[1];
else
    h.persist = room_speed;
h.yy = lowest-40;
//h.yy -= num * 35;
