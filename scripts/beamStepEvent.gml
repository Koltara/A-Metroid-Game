if pause exit

if missileDirection = LEFT
    xVel = -25
if missileDirection = RIGHT
    xVel = 25
    
if isCollisionLeft(1)
{
    x-= 8
    instance_create(x,y, oPlasmaBeamHit)
    instance_destroy()
} else if isCollisionRight(1)
{
    x += 8
    instance_create(x,y, oPlasmaBeamHit)
    instance_destroy()
}
moveTo(xVel, yVel)
