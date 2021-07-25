var closest = -1;
var close_dist = -1;
var id1 = 0;
var id2 = 0;

with(obj_camera)
{
    id1 = id;
    with(obj_pedestal)
    {
        id2 = id;
        if (letter != -1)
        {
            var d = point_distance(id2.x, id2.y, id1.x, id1.y);
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
        with (obj_boat)
        {
            var forwardxx = lengthdir_x(spd*100, id.dir);
            var forwardyy = lengthdir_y(spd*100, id.dir);

            var pointdir = point_direction(x, y, closest.x, closest.y);

            var xx = x + lengthdir_x(-mean(view_wview, view_hview)/2, pointdir)+forwardxx;
            var yy = y + lengthdir_y(-mean(view_wview, view_hview)/2, pointdir)+forwardyy;
            
            var h = instance_create(xx, yy, obj_gull);
            h.dir = pointdir;
            h = instance_create(xx+lengthdir_x(120, pointdir+180-45), yy+lengthdir_y(120, pointdir+180-45), obj_gull);
            h.dir = pointdir;
            if(random(1)<.75)
            {
                h = instance_create(xx+lengthdir_x(240, pointdir+180-45), yy+lengthdir_y(240, pointdir+180-45), obj_gull);
                h.dir = pointdir;
            }
            h = instance_create(xx+lengthdir_x(120, pointdir+180+45), yy+lengthdir_y(120, pointdir+180+45), obj_gull);
            h.dir = pointdir;
            if(random(1)<.75)
            {
                h = instance_create(xx+lengthdir_x(240, pointdir+180+45), yy+lengthdir_y(240, pointdir+180+45), obj_gull);
                h.dir = pointdir;
            }
        }
    }
    else if instance_exists(obj_altar)
    {
        var h = instance_create(x, y, obj_gull);
        var dir = point_direction(x, y, obj_altar.x, obj_altar.y);
        h.dir = dir;    
    }
}
