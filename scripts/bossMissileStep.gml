if pause exit

if isCollisionLeft(1)
{
    x-= 8
    instance_destroy()
} else if isCollisionRight(1)
{
    x += 8
    instance_destroy()
}

if place_meeting(x,y, oSamus)
    instance_destroy()
    
moveTo(xVel, yVel)
