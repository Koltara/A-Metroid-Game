//f
if isCollisionLeft(1) or isCollisionRight(1)
{
    xVel *= -1;
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
        instance_destroy();
    }
}
if m_health <= 0
    instance_destroy();

moveTo(xVel, yVel);
