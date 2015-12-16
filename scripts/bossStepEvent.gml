//f
if direction_switch <= 0
{
    xVel *= -1;
    direction_switch = 60
}
if firing_timer <= 0
{
    switch(next_missile_type)
    {
        case HIGH_NEXT:
            instance_create(x+32, y+12, oBossMissile)
            next_missile_type = LOW_NEXT
            break
        case LOW_NEXT:
            instance_create(x+32, y-32, oBossMissile)
            next_missile_type = HIGH_NEXT
            break
    }
    firing_timer = 30
}
if place_meeting(x,y, oBeam)
{
    inst = instance_nearest(x, y, oBeam);
    
    if inst.object_index = oPlasmaBeam
    {
        m_health -= 10
    }
    with (inst)
    {
        instance_create(x, y, oPlasmaBeamHit)
        instance_destroy();
    }
}
if m_health <= 0
{
    instance_destroy();
    oSamus.bossAlive = false;
}

moveTo(xVel, yVel);
direction_switch--;
firing_timer--;
