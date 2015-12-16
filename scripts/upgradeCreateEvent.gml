//f
HIGH_JUMP = 1;
KEY_ONE = 2;
KEY_TWO = 3;
KEY_THREE = 4;

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
    case oFirstKey:
        if (oSamus.hasFirstKey)
        {
            instance_destroy()
            break
        } else upgradeID = KEY_ONE
        break
    case oSecondKey:
        if (oSamus.hasSecondKey)
        {
            instance_destroy()
            break
        } else upgradeID = KEY_TWO
        break
    case oThirdKey:
        if (oSamus.hasThirdKey)
        {
            instance_destroy()
            break
        } else upgradeID = KEY_THREE
        break
}
