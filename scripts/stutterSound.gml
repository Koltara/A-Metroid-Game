sound = argument0;
priority = argument1;
loop = false;
if audio_is_playing(sound)
    {
        audio_stop_sound(sound);
        audio_play_sound(sound, priority, loop);
    } else audio_play_sound(sound, priority, loop);
