//f
if place_meeting(x, y, oSamus)
{
    switch (upgradeID)
    {
        case HIGH_JUMP:
            pause = true;
            audio_stop_all();
            audio_play_sound(snd_FindUpgrade, 10, false);
            while audio_is_playing(snd_FindUpgrade)
            {
                
            }
            
            if !audio_is_playing(snd_FindUpgrade)
            {
                oSamus.hasHighJump = true;
                pause = false;
                instance_destroy()
       
            }
            break
    }
}
