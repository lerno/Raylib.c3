import rl;
import std::io;

const int SCREEN_WIDTH = 800;
const int SCREEN_HEIGHT = 450;

const int GRAVITY = 400;
const float PLAYER_JUMP_SPD = 350.0f;
const float PLAYER_HOR_SPD = 200.0f;

define CameraUpdater = fn void(Camera2D*, Player*, EnvItem*, int, float, int, int);

struct Player {
    Vector2 position;
    float speed;
    bool canJump;
}

struct EnvItem {
    Rectangle rect;
    int blocking;
    Color color;
}


//------------------------------------------------------------------------------------
// Player struct method
//------------------------------------------------------------------------------------
fn void Player.update(Player* player, EnvItem* envItems, int envItemsLength, float delta)
{
    if (rl::isKeyDown(rl::keyboard::LEFT)) player.position.x -= PLAYER_HOR_SPD*delta;
    if (rl::isKeyDown(rl::keyboard::RIGHT)) player.position.x += PLAYER_HOR_SPD*delta;
    if (rl::isKeyDown(rl::keyboard::SPACE) && player.canJump)
    {
        player.speed = -PLAYER_JUMP_SPD;
        player.canJump = false;
    }

    int hitObstacle = 0;
    for (int i = 0; i < envItemsLength; i++)
    {
        EnvItem *ei = envItems + i;
        Vector2 *p = &(player.position);
        if (ei.blocking && ei.rect.x <= p.x && ei.rect.x + ei.rect.width >= p.x && ei.rect.y >= p.y && ei.rect.y <= p.y + player.speed*delta)
        {
            hitObstacle = 1;
            player.speed = 0.0f;
            p.y = ei.rect.y;
        }
    }

    if (!hitObstacle)
    {
        player.position.y += player.speed*delta;
        player.speed += GRAVITY*delta;
        player.canJump = false;
    }
    else
    {
        player.canJump = true;
    }
}

//----------------------------------------------------------------------------------
// Module functions declaration
//----------------------------------------------------------------------------------

fn void updateCameraCenter(Camera2D *camera, Player *player, EnvItem *envItems, int envItemsLength, float delta, int width, int height)
{
    camera.offset = Vector2{width/2.0f, height/2.0f};
    camera.target = player.position;
}

fn void updateCameraCenterInsideMap(Camera2D *camera, Player *player, EnvItem *envItems, int envItemsLength, float delta, int width, int height)
{
    camera.target = player.position;
    camera.offset = Vector2{ width/2.0f, height/2.0f };
    float minX = 1000;
    float minY = 1000;
    float maxX = -1000;
    float maxY = -1000;

    for (int i = 0; i < envItemsLength; i++)
    {
        EnvItem *ei = envItems + i;
        minX = $$min(ei.rect.x, minX);
        maxX = $$max(ei.rect.x + ei.rect.width, maxX);
        minY = $$min(ei.rect.y, minY);
        maxY = $$max(ei.rect.y + ei.rect.height, maxY);
    }

    Vector2 max = rl::getWorldToScreen2D(Vector2{ maxX, maxY }, *camera);
    Vector2 min = rl::getWorldToScreen2D(Vector2{ minX, minY }, *camera);

    if (max.x < width) camera.offset.x = width - (max.x - width/2);
    if (max.y < height) camera.offset.y = height - (max.y - height/2);
    if (min.x > 0) camera.offset.x = width/2 - min.x;
    if (min.y > 0) camera.offset.y = height/2 - min.y;
}

fn void updateCameraCenterSmoothFollow(Camera2D *camera, Player *player, EnvItem *envItems, int envItemsLength, float delta, int width, int height)
{
    static float minSpeed = 30;
    static float minEffectLength = 10;
    static float fractionSpeed = 0.8f;

    camera.offset = Vector2{ width/2.0f, height/2.0f };
    Vector2 diff = diff.subtract(player.position, camera.target); // Using a Vector2 math functions as methods.
    
    float length = diff.length();

    if (length > minEffectLength)
    {
        float speed = $$max(fractionSpeed*length, minSpeed);
        camera.target.add(diff.scale(speed*delta/length)); // Using a Vector2 math functions as methods.
    }
}

fn void updateCameraEvenOutOnLanding(Camera2D *camera, Player *player, EnvItem *envItems, int envItemsLength, float delta, int width, int height)
{
    static float evenOutSpeed = 700;
    static bool eveningOut = false;
    static float evenOutTarget;

    camera.offset = Vector2{ width/2.0f, height/2.0f };
    camera.target.x = player.position.x;

    if (eveningOut)
    {
        if (evenOutTarget > camera.target.y)
        {
            camera.target.y += evenOutSpeed*delta;

            if (camera.target.y > evenOutTarget)
            {
                camera.target.y = evenOutTarget;
                eveningOut = 0;
            }
        }
        else
        {
            camera.target.y -= evenOutSpeed*delta;

            if (camera.target.y < evenOutTarget)
            {
                camera.target.y = evenOutTarget;
                eveningOut = 0;
            }
        }
    }
    else
    {
        if (player.canJump && (player.speed == 0) && (player.position.y != camera.target.y))
        {
            eveningOut = 1;
            evenOutTarget = player.position.y;
        }
    }
}

fn void updateCameraPlayerBoundsPush(Camera2D *camera, Player *player, EnvItem *envItems, int envItemsLength, float delta, int width, int height)
{
    static Vector2 bbox = { 0.2f, 0.2f };

    Vector2 bboxWorldMin = rl::getScreenToWorld2D(Vector2{ (1 - bbox.x)*0.5f*width, (1 - bbox.y)*0.5f*height }, *camera);
    Vector2 bboxWorldMax = rl::getScreenToWorld2D(Vector2{ (1 + bbox.x)*0.5f*width, (1 + bbox.y)*0.5f*height }, *camera);
    camera.offset = Vector2{ (1 - bbox.x)*0.5f * width, (1 - bbox.y)*0.5f*height };

    if (player.position.x < bboxWorldMin.x) camera.target.x = player.position.x;
    if (player.position.y < bboxWorldMin.y) camera.target.y = player.position.y;
    if (player.position.x > bboxWorldMax.x) camera.target.x = bboxWorldMin.x + (player.position.x - bboxWorldMax.x);
    if (player.position.y > bboxWorldMax.y) camera.target.y = bboxWorldMin.y + (player.position.y - bboxWorldMax.y);
}


fn void main()
{
    // Initialization
    //--------------------------------------------------------------------------------------
    rl::initWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "raylib [core] example - 2d camera");
    defer rl::closeWindow();

    float deltaTime = 0.0f;

    Player player;
    player.position = Vector2{ 400, 280 };
    player.speed = 0;
    player.canJump = false;

    EnvItem[] envItems = {
        {{ 0, 0, 1000, 400 }, 0, rl::LIGHTGRAY },
        {{ 0, 400, 1000, 200 }, 1, rl::GRAY },
        {{ 300, 200, 400, 10 }, 1, rl::GRAY },
        {{ 250, 300, 100, 10 }, 1, rl::GRAY },
        {{ 650, 300, 100, 10 }, 1, rl::GRAY }
    };

    int envItemsLength = envItems.len;

    Camera2D camera;
    camera.target = player.position;
    camera.offset = player.position;
    camera.rotation = 0.0f;
    camera.zoom = 1.0f;

    CameraUpdater[*] cameraUpdaters = {
        &updateCameraCenter,
        &updateCameraCenterInsideMap,
        &updateCameraCenterSmoothFollow,
        &updateCameraEvenOutOnLanding,
        &updateCameraPlayerBoundsPush
    };

    int cameraOption = 0;
    int cameraUpdatersLength = cameraUpdaters.len;

    char*[] cameraDescriptions = {
        "Follow player center",
        "Follow player center, but clamp to map edges",
        "Follow player center; smoothed",
        "Follow player center horizontally; updateplayer center vertically after landing",
        "Player push camera on getting too close to screen edge"
    };

    rl::setTargetFPS(60);
    //--------------------------------------------------------------------------------------

    // Main game loop
    while(!rl::windowShouldClose())
    {
        // Update
        //----------------------------------------------------------------------------------
        deltaTime = rl::getFrameTime();
        player.update(envItems, envItemsLength, deltaTime);

        camera.zoom += ((float)rl::getMouseWheelMove()*0.05f);
        if (camera.zoom > 3.0f) { camera.zoom = 3.0f; }
        else if (camera.zoom < 0.25f) { camera.zoom = 0.25f; }

        if (rl::isKeyPressed(rl::keyboard::R))
        {
            camera.zoom = 1.0f;
            player.position = Vector2{ 400, 280 };
        }

        if (rl::isKeyPressed(rl::keyboard::C))
        {
            cameraOption = (cameraOption +1)%cameraUpdatersLength;
        }

        // Call update camera function by its pointer
        cameraUpdaters[cameraOption](&camera, &player, envItems, envItemsLength, deltaTime, SCREEN_WIDTH, SCREEN_HEIGHT);
        //----------------------------------------------------------------------------------

        // Draw
        //----------------------------------------------------------------------------------
        rl::beginDrawing();
            rl::clearBackground(rl::LIGHTGRAY);
            rl::beginMode2D(camera);
            
            for (int i = 0; i < envItemsLength; i++) rl::drawRectangleRec(envItems[i].rect, envItems[i].color);
            Rectangle playerRect = { player.position.x - 20, player.position.y - 40, 40, 40 };
            rl::drawRectangleRec(playerRect, rl::RED);

            rl::endMode2D();

            rl::drawText("Controls:", 20, 20, 10, rl::BLACK);
            rl::drawText("- Right/Left to move", 40, 40, 10, rl::DARKGRAY);
            rl::drawText("- Space to jump", 40, 60, 10, rl::DARKGRAY);
            rl::drawText("- Mouse Wheel to Zoom in-out, R to reset zoom", 40, 80, 10, rl::DARKGRAY);
            rl::drawText("- C to change camera mode", 40, 100, 10, rl::DARKGRAY);
            rl::drawText("Current camera mode:", 20, 120, 10, rl::BLACK);
            rl::drawText(cameraDescriptions[cameraOption], 40, 140, 10, rl::DARKGRAY);

        rl::endDrawing();
        //----------------------------------------------------------------------------------
    }
}