if pause return
//Left Collision
if place_meeting(x-1, y, oBeam)
{
    inst = instance_nearest(x, y, oBeam);
    with (inst)
        instance_destroy();
    instance_destroy();
}
if place_meeting(x+1, y, oBeam)
{
    inst = instance_nearest(x, y, oBeam);
    with (inst)
        instance_destroy();
    instance_destroy();
}
