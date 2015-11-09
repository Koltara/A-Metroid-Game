if place_meeting(x, y, oBeam)
{
    inst = instance_nearest(x, y, oBeam);
    tile = tile_layer_find(0,x,y);
    if inst.object_index = oMissile
    {
        instance_create(x,y, oBlockDestruction);
        tile_delete(tile);
        instance_destroy();  
    }
    with (inst)
    {
        instance_destroy();
    }
    
    
}
