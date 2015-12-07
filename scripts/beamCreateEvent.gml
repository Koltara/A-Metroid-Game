LEFT = 1
RIGHT = 2

image_speed = .25

missileDirection = oSamus.facing
missileSpeed = 25

if missileDirection = LEFT
{
    sprite_index = sPlasmaBeamLeft
    setCollisionBounds(-6, -6, 9, 5)
}
else 
{ 
    sprite_index = sPlasmaBeamRight
    setCollisionBounds(-9, -6, 6, 5)
}



makeActive()

if audio_is_playing(snd_PlasmaBeam)
{
    audio_stop_sound(snd_PlasmaBeam)
    audio_play_sound(snd_PlasmaBeam, 5, false)
} else audio_play_sound(snd_PlasmaBeam, 5, false)
