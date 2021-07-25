if (instance_exists(obj_game_generator))
{
    if (y < 2*obj_game_generator.cell_size)
    {
        var mov = (obj_game_generator.map_height-4)*obj_game_generator.cell_size;
        y += mov;
        if (instance_exists(obj_camera))
            obj_camera.y += mov;
    }
    else if (y > (obj_game_generator.map_height-2)*obj_game_generator.cell_size)
    {
        var mov = (obj_game_generator.map_height-4)*obj_game_generator.cell_size;
        y -= mov;
        if (instance_exists(obj_camera))
            obj_camera.y -= mov;
    }
    
    if (x < 2*obj_game_generator.cell_size)
    {
        var mov = (obj_game_generator.map_width-4)*obj_game_generator.cell_size;
        x += mov;
        if (instance_exists(obj_camera))
            obj_camera.x += mov;
    }
    else if (x > (obj_game_generator.map_width-2)*obj_game_generator.cell_size)
    {
        var mov = (obj_game_generator.map_width-4)*obj_game_generator.cell_size;
        x -= mov;
        if (instance_exists(obj_camera))
            obj_camera.x -= mov;
    }
}
