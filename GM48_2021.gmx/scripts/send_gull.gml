var closest = -1;
var close_dist = -1;

with(obj_camera)
{
    with(obj_pedestal)
    {
        if (letter != -1)
        {
            var d = point_distance(other.x, other.y, x, y);
            if (closest == -1)
            {
                closest = id;
                close_dist = d;
            }
            else
            {                
                if (d < close_dist)
                {                    
                    closest = id;
                    close_dist = d;
                }
            }
        }    
    }
    
    if (closest != -1)
    {
        var h = instance_create(x, y, obj_gulls);
        var dir = point_direction(x, y, closest.x, closest.y);
        h.dir = dir;
    }
    else if instance_exists(obj_altar)
    {
        var h = instance_create(x, y, obj_altar);
        var dir = point_direction(x, y, obj_altar.x, obj_altar.y);
        h.dir = dir;    
    }
}
