//f
HIGH_JUMP = 1;

upgradeID = 0;

switch (self.object_index)
{
    case oHighJump:
        if (oSamus.hasHighJump)
        {
            instance_destroy()
            break
        } else upgradeID = HIGH_JUMP
        break
}
