///music_player_play(audio id, loop, alternate id)
// 0 - audio id
// 1 - loop?
// 2 - alternate id (for underwater, etc) / -1
// 3 - 

if (argument_count == 2)
{
    audio_sound_gain(settings[? "last_playing_track"], 0, 1000);
    var aud = audio_play_sound_on(global.emitter_music, argument[0], argument[1], 1);
    settings[? "last_playing_track"] = aud;
    audio_sound_gain(aud, 0, 0);
    audio_sound_gain(aud, .5, 1000);
    return aud;
}
else
    show_message("Not 2 arguments. Could be a typo.  #" + sound_get_name(argument[0]))

return 0;
