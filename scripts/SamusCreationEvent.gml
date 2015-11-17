//Global Variables
makeActive()

key_Left = 0;
key_Right = 0;
key_Up = 0;
key_Down = 0;
key_Jump = 0;
key_Missile = 0;
key_Shoot = 0;
key_JumpPressed = 0
key_JumpReleased = 0
key_LeftReleased = 0
key_LeftPushedSteps = 0
key_LeftPressed = 0
key_RightReleased = 0
key_RightPushedSteps = 0
key_RightPressed = 0

globalvar playerX;
globalvar playerY;

playerX = 384;
playerY = 168;

m_health = 99;


initialJump = 12;
highInitialJump = 16;
jumpTime = 0;
grav = 1;
jumpMaxTime = 14;
highJumpMaxTime = 14;
runAcceleration = 12;
xVelMax = 15;
yVelMax = 16;
xAccMax = 9;
yAccMax = 14;
highJumpAccMax = 14;
highJumpVelMax = 20;
frictionRunningX=.4
xFric = .5
yFric = 1

canShoot = 1;
shotDelay = .3;
gravIntensity = grav;

//Facing Variables
LEFT = 1;
RIGHT = 2;

//Gun State Variables
MISSILES_READY = 2;
MISSILES_NOT_READY = 3;
SHOOTING = 4;
NOT_SHOOTING = 5;

//Location State Variables
ON_GROUND = 2;
IN_AIR = 3;
IN_WATER = 4;

//Player States
//These are variables used to identify what Samus is currently doing
STANDING = 2;
RUNNING = 3;
JUMPING = 4;
FALLING = 5;
JUMPING_SPINNING = 6;
FALLING_SPINNING = 7;

//Upgrade Status
hasHighJump = false;

locationState = IN_AIR;
gunState = NOT_SHOOTING;

facing = RIGHT;

state = FALLING;
stateprev = FALLING;
stateprevprev = FALLING;

setCollisionBounds(- 7.5, -18, 7.5, 21)
