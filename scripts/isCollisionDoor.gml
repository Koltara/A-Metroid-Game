/*
Returns whether the object invoking this script is colliding with a solid.
return
0:no collision
1:collision
*/
calculateCollisionBounds()
return collision_rectangle(lb,tb,rb,bb,oDoor,1,1)>0
