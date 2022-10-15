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

    Vector2 ballPosition = { -100.0f, -100.0f };
    Color ballColor = rl::DARKBLUE;

    while(!rl::windowShouldClose())
    {
        // Update
        //----------------------------------------------------------------------------------
        ballPosition = rl::getMousePosition();

        if (rl::isMouseButtonPressed(rl::MouseButton.BUTTON_LEFT)) { ballColor = rl::MAROON; }
        else if (rl::isMouseButtonPressed(rl::MouseButton.BUTTON_MIDDLE)) { ballColor = rl::LIME; }
        else if (rl::isMouseButtonPressed(rl::MouseButton.BUTTON_RIGHT)) { ballColor = rl::DARKBLUE; }
        else if (rl::isMouseButtonPressed(rl::MouseButton.BUTTON_SIDE)) { ballColor = rl::PURPLE; }
        else if (rl::isMouseButtonPressed(rl::MouseButton.BUTTON_EXTRA)) { ballColor = rl::YELLOW; } 
        else if (rl::isMouseButtonPressed(rl::MouseButton.BUTTON_FORWARD)) { ballColor = rl::ORANGE; }
        else if (rl::isMouseButtonPressed(rl::MouseButton.BUTTON_BACK)) {ballColor = rl::BEIGE; }
        //----------------------------------------------------------------------------------

        // Update
        //----------------------------------------------------------------------------------
        rl::beginDrawing();

            rl::clearBackground(rl::RAYWHITE);

            rl::drawCircleV(ballPosition, 40, ballColor);

            rl::drawText("move ball with mouse and click mouse button to change color", 10, 10, 20, rl::DARKGRAY);
        
        rl::endDrawing();
        //----------------------------------------------------------------------------------

    }
}