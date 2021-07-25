///draw_text_outline(x,y,string,border_size,border_color,text_color,angle)
var ____border = argument[3];
var ________iiiiiii;
var _____jjjjjj;
draw_set_color(argument[4]);
for(________iiiiiii=-____border;________iiiiiii<=____border;________iiiiiii+=1)
{
    if ________iiiiiii!=0
    {
        draw_text(argument[0]+________iiiiiii,argument[1],argument[2])//_transformed(... ,1,1,argument6);
    }
    for(_____jjjjjj=-____border;_____jjjjjj<=____border;_____jjjjjj+=1)
    {
        if _____jjjjjj!=0
        {
            draw_text(argument[0]+________iiiiiii,argument[1]+_____jjjjjj,argument[2])///,1,1,argument6);
        }
    }
}
draw_set_color(argument[5]);
draw_text(argument[0],argument[1],argument[2])//,1,1,argument6);

