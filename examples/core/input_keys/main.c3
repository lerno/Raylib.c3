import rl;

const int SCREEN_WIDTH = 800;
const int SCREEN_HEIGHT = 450;

fn void main()
{
    // Initialization
    //--------------------------------------------------------------------------------------
    rl::setConfigFlags(rl::config::VSYNC_HINT);
    rl::initWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "raylib [core] example - keyboard input");
    defer rl::closeWindow();

    Vector2 ballPosition = { (float)(SCREEN_WIDTH/2), (float)(SCREEN_HEIGHT/2) };

    while(!rl::windowShouldClose())
    {
        // Update
        //----------------------------------------------------------------------------------
        if (rl::isKeyDown(rl::keyboard::RIGHT)) ballPosition.x += 2.0f;
        if (rl::isKeyDown(rl::keyboard::LEFT)) ballPosition.x -= 2.0f;
        if (rl::isKeyDown(rl::keyboard::UP)) ballPosition.y -= 2.0f;
        if (rl::isKeyDown(rl::keyboard::DOWN)) ballPosition.y += 2.0f;
        //----------------------------------------------------------------------------------

        // Update
        //----------------------------------------------------------------------------------
        rl::beginDrawing();

            rl::clearBackground(rl::RAYWHITE);

            rl::drawText("move the ballwith arrow keys", 10, 10, 20, rl::DARKGRAY);

            rl::drawCircleV(ballPosition, 50, rl::MAROON);
        
        rl::endDrawing();
        //----------------------------------------------------------------------------------

    }
}