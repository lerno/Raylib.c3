import rl;
import std::io;

const int SCREEN_WIDTH = 800;
const int SCREEN_HEIGHT = 450;

//------------------------------------------------------------------------------------
// Program main entry point
//------------------------------------------------------------------------------------
fn void main()
{
    // Initialization
    //--------------------------------------------------------------------------------------
    rl::initWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "raylib [core] example - input mouse wheel");
    defer rl::closeWindow();
    
    int boxPositionY = SCREEN_HEIGHT/2 - 40;
    int scrollSpeed = 4; // Scrolling speed in pixels

    rl::setTargetFPS(60); // Set our game to run at 60 frames-per-second
    //--------------------------------------------------------------------------------------
    
    // Main game loop
    while(!rl::windowShouldClose()) // Detect window close button or ESC key
    {

        // Update
        //----------------------------------------------------------------------------------
        boxPositionY -= (int)(rl::getMouseWheelMove()*scrollSpeed);

        rl::beginDrawing();
            rl::clearBackground(rl::RAYWHITE);

            rl::drawRectangle(SCREEN_WIDTH/2-40, boxPositionY, 80, 80, rl::MAROON);

            rl::drawText("Use mouse wheel to move the cube up and down!", 10, 10, 20, rl::GRAY);
            rl::drawText(rl::textFormat("Box position Y: %03i", boxPositionY), 10, 40, 20, rl::LIGHTGRAY);
        rl::endDrawing();
    }
}