if pause 
{
    xVel = 0;
    yVel = 0;
    exit;
}

if m_health <= 0
    game_restart();

//Non Differential Keys
key_Up = keyboard_check(vk_up)
key_Down = keyboard_check(vk_down)
key_Shoot = keyboard_check(ord('X'))

  //Checking the left key
  key_LeftReleased=0
  if(key_Left)
  {
    key_Left=keyboard_check(vk_left);
    key_LeftPushedSteps+=1;
    key_LeftPressed=0;
    if (key_Left=0)
      key_LeftReleased=1;
  }
  else
  {
    key_Left=keyboard_check(vk_left)
    if key_Left
      key_LeftPressed=1
    key_LeftPushedSteps=0
  }
  //Checking the right key
  key_RightReleased=0
  if key_Right
  {
    key_Right=keyboard_check(vk_right)
    key_RightPushedSteps+=1
    key_RightPressed=0
    if key_Right=0
      key_RightReleased=1
  }
  else
  {
    key_Right=keyboard_check(vk_right)
    if key_Right
      key_RightPressed=1
    key_RightPushedSteps=0
  }
  
  //Checking the Jump Key
  if key_Jump
  {
    key_Jump = keyboard_check(ord('Z'))
    key_JumpPressed=0
  }
  else
  {
    key_Jump = keyboard_check(ord('Z'))
    if key_Jump
      key_JumpPressed=1
  }
  //Allow Samus to Shoot
  if canShoot=1 and key_Shoot
  {
        //Disable the gun and change the shooting state
        canShoot = 0
        gunState = SHOOTING
        
        //Decide which kind of beam shot to create
        switch state
        {
            case STANDING:
                switch facing
                {
                    case LEFT:
                        instance_create(x - 14, y-6, oPlasmaBeam)
                        instance_create(x - 14, y-6, oPlasmaBeamGunEffect)
                        break
                    case RIGHT:
                        instance_create(x + 14, y-6, oPlasmaBeam)
                        instance_create(x + 14, y-6, oPlasmaBeamGunEffect)
                        break
                }
                break
            case RUNNING:
                switch facing
                {
                    case LEFT:
                        instance_create(x - 14 + xVel, y-6, oPlasmaBeam)
                        instance_create(x - 14 + xVel, y-6, oPlasmaBeamGunEffect)
                        break
                    case RIGHT:
                        instance_create(x + 20 + xVel, y-6, oPlasmaBeam)
                        instance_create(x + 20 + xVel, y-6, oPlasmaBeamGunEffect)
                        break
                }
        }
  }
  
  //Beam Recharge Time (To Prevent Rapid Fire)
  if shotDelay>0 and canShoot=0
  {
        if key_Shoot=0
            shotDelay--;
  }
  if shotDelay<=0
  {
        canShoot = 1;
        shotDelay = 1;
  }
  
  if invulTimer>0 and invulnerable
        invulTimer--;
  if invulTimer <= 0
    {
        invulTimer = 45;
        invulnerable = false;
    }

  
  
  
  //Stops the character when from running when 
  // the movement key is released
  if key_LeftReleased and approximatelyZero(xVel)
    xAcc-=2
  if key_RightReleased and approximatelyZero(xVel)
    xAcc+=2
  //Check to see which direction the character will move
  //but only if the key has been pressed for more than 1 step
  if key_Left
  {
    if (key_LeftPushedSteps>1) and (facing=LEFT or approximatelyZero(xVel))
      xAcc-=runAcceleration
    facing=LEFT
  }
  if key_Right
  {
    if (key_RightPushedSteps>1) and (facing=RIGHT or approximatelyZero(xVel))
      xAcc+=runAcceleration
    facing=RIGHT
  }

//Allow Samus To Jump
if locationState = ON_GROUND and key_JumpPressed
{
    if hasHighJump
        yAcc -= highInitialJump
    else yAcc -= initialJump
    xAcc += xVel/2
    
    audio_play_sound(snd_SamusJump, 5, false);
    
    state = FALLING
    
    key_JumpReleased=0
    jumpTime=0
}
if yVel >= 0 
    grav = 1;
if yVel <= 0
    grav = 2;
//Increments the jumping timer
if jumpTime < jumpMaxTime and !hasHighJump
    jumpTime += 1
else if jumpTime < highJumpMaxTime and hasHighJump
    jumpTime += 1

//Variable jumping height
if key_Jump=0
  key_JumpReleased=1
if key_JumpReleased and !hasHighJump
  jumpTime=jumpMaxTime
else if key_JumpReleased and hasHighJump
  jumpTime=highJumpMaxTime
if !hasHighJump
    gravIntensity=(jumpTime/jumpMaxTime)*grav
else gravIntensity=(jumpTime/highJumpMaxTime)*grav

//Prevents the character from running through solid walls to the left or right
if (isCollisionLeft(1) and facing = LEFT) or (isCollisionRight(1) and facing = RIGHT)
    xVel = 0

//Apply gravity to the character mid-air
if locationState = IN_AIR
{
    yAcc += gravIntensity;
}
//Just landing on the ground
if isCollisionBottom(1) and locationState = IN_AIR and yVel >= 0
{
    yVel = 0
    yAcc = 0
    
    state = RUNNING
}
//Checking for falling status
if isCollisionBottom(1) = 0 and yVel > 0
{
    state = FALLING
}
if isCollisionBottom(1) = 0 and state = RUNNING
{
    xVel = 0;
    xAcc = 0;
    state = FALLING
}
//Checking for landing from falling
if isCollisionBottom(1) and state = FALLING
{
    yVel = 0
    state = STANDING;
}
if isCollisionTop(1) and locationState = IN_AIR
{
    yVel = 0;
}
//Changes state to standing if the velocity and acceleration are zero
//and the current state is running
if xVel = 0 and xAcc = 0 and state = RUNNING
    state = STANDING

//Changes state to running when standing and has a non zero acceleration
if xAcc !=0 and state = STANDING
    state = RUNNING
    
draw_text(view_xview[0] + 320, view_yview[0], string(m_health));
    
if place_meeting(x,y, oEnemy)
{
    if !invulnerable
    {
        invulnerable = true;
        inst = instance_nearest(x,y, oEnemy);
        m_health -= inst.player_damage;
        state = FALLING;
        xMax = 0;
        if (xVel > 0)
        {
            
            while (!place_meeting(x-1, y-1, oSolid) and xMax < 32)
            {
                x--;
                y--;
                xMax++;
            }
        }
        if (xVel < 0)
        {
            while (!place_meeting(x+1, y-1, oSolid) and xMax < 32)
            {
                x++;
                y--;
                xMax++;
            }
        }
        if (xVel = 0)
        {
            if inst.xVel > 0
            {
               while (!place_meeting(x+1, y-1, oSolid) and xMax < 32)
                 {
                   x++;
                  y--;
                  xMax++;
                     }
            }
             if inst.xVel < 0
            {
               while (!place_meeting(x-1, y-1, oSolid) and xMax < 32)
                 {
                   x--;
                  y--;
                  xMax++;
                     }
            }
            
            
        }
    }
}

//Checks to see if the jumping character should be spinning    
if yVel < 0 and locationState = IN_AIR
{
    if abs(xVel) < 2
        state = JUMPING;
    else state = JUMPING_SPINNING
}
//Checks to see if the falling character should be spinning
if yVel > 0 and locationState = IN_AIR
{
    if abs(xVel) < 2
        state = FALLING;
    else state = FALLING_SPINNING
}

//Detects if the Character is in the air
if isCollisionBottom(1) = 0 and locationState = ON_GROUND
    locationState = IN_AIR

//Detects if the Character is on the Ground
if isCollisionBottom(1) and locationState = IN_AIR
    locationState = ON_GROUND

//Decide what the friction should be
if locationState = IN_AIR //and key_Left = 0 and key_Right = 0
{
    xFric = .35
} else xFric = frictionRunningX


//Restrict Horizontal Acceleration
if xAcc>xAccMax
  xAcc=xAccMax
else if xAcc<-1*xAccMax
  xAcc=-1*xAccMax
  
//Restrict Vertical Acceleration
if yAcc>yAccMax
  yAcc=yAccMax
else if yAcc<-1*yAccMax and !hasHighJump
  yAcc=-1*yAccMax
else if yAcc<-1*highJumpAccMax and hasHighJump
    yAcc=-1*highJumpAccMax

//Apply acceleration to the velocities
xVel+=xAcc
yVel+=yAcc

//Zero the Acceleration for the next step
xAcc=0
yAcc=0

//Apply friction to the velocities
xVel *= xFric
yVel *= yFric

//Restrict Horizontal Velocity to the Maximum set in the Create Event

if xVel>xVelMax
  xVel=xVelMax
else if xVel<-1*xVelMax
  xVel=-1*xVelMax

//Restrict Vertical Velocity to the Maximum set in the Create Event
if yVel>yVelMax
  yVel=yVelMax
else if yVel<-1*yVelMax and !hasHighJump
  yVel=-1*yVelMax
else if yVel<-1*highJumpVelMax and hasHighJump
    yVel=-1*highJumpVelMax
  
if approximatelyZero(xVel)
  xVel=0
if approximatelyZero(yVel)
  yVel=0
if approximatelyZero(xAcc)
  xAcc=0
if approximatelyZero(yAcc)
  yAcc=0

moveTo(xVel, yVel)

    
stateprevprev = stateprev;
stateprev = state;

if facing = LEFT
{
    if state = STANDING
    {
        sprite_index = sCharacterLeftIdle

    }
    if state = RUNNING
    {
        sprite_index = sCharacterLeftRun

    }
    if state = JUMPING
    {
        sprite_index = sSamusLeftJump
        if image_index >= 2
        {
            image_index = 2
            image_speed = 0
        }
        else image_speed = .5
    }
    if state = FALLING
    {
        image_speed = 1;
        if image_index >= 4
        {
            image_speed = 0
            image_index = 4
        }
    }
    if state = JUMPING_SPINNING
    {
        sprite_index = sSamusLeftSpin
        image_speed = .8
        
        if !audio_is_playing(snd_FlipSpin)
            audio_play_sound(snd_FlipSpin, 6, true)
    } else if state = FALLING_SPINNING
    {
        sprite_index = sSamusLeftSpin
        image_speed = .8
        
        if !audio_is_playing(snd_FlipSpin)
            audio_play_sound(snd_FlipSpin, 6, true)
    } else audio_stop_sound(snd_FlipSpin)
}
if facing = RIGHT
{
    if state = STANDING
    {
        sprite_index = sCharacterRightIdle
    }
    if state = RUNNING
    {
        sprite_index = sCharacterRightRun
    }
    if state = JUMPING
    {
        sprite_index = sSamusRightJump
        if image_index >= 2
        {
            image_speed = 0
            image_index = 2;
        }
        else image_speed = .5
        
    }
    if state = FALLING
    {
        image_speed = 1;
        if image_index >= 4
        {
            image_speed = 0
            image_index = 4
        }
    }
    if state = FALLING and stateprev = JUMPING_SPINNING
    {
        sprite_index = sSamusRightSpin
    }
    if state = JUMPING_SPINNING
    {
        sprite_index = sSamusRightSpin
        image_speed = .8
        
        if !audio_is_playing(snd_FlipSpin)
            audio_play_sound(snd_FlipSpin, 6, true)
    } else if state = FALLING_SPINNING
    {
        sprite_index = sSamusRightSpin
        image_speed = .8
        
        if !audio_is_playing(snd_FlipSpin)
            audio_play_sound(snd_FlipSpin, 6, true)
    } else audio_stop_sound(snd_FlipSpin)
}

//Sounds

if !audio_is_playing(oGameController.zoneBGM)
{
    audio_stop_all();
    audio_play_sound(oGameController.zoneBGM, 5, true);
}
