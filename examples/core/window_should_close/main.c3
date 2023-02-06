import rl;

const int SCREEN_WIDTH = 900;
const int SCREEN_HEIGHT = 450;


//------------------------------------------------------------------------------------
// Program main entry point
//------------------------------------------------------------------------------------
fn void main() {

    // Initialization
    //--------------------------------------------------------------------------------------
    rl::initWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "raylib [core] example - window should close");
    defer rl::closeWindow();
    
    rl::setExitKey(rl::keyboard::NULL); // Disable KEY_ESCAPE to close window, X-button still works

    bool exitWindowRequested = false; // Flag to request window to exit
    bool exitWindow = false; // Flag to set window to exit

    rl::setTargetFPS(60); // Set our game to run at 60 frames-per-second
    //--------------------------------------------------------------------------------------

    // Main game loop
    while(!exitWindow) {

        // Update
        //----------------------------------------------------------------------------------
        // Detect if X-button or KEY_ESCAPE have been pressed to close window
        if (rl::windowShouldClose() || rl::isKeyPressed(rl::keyboard::ESCAPE)) exitWindowRequested = true;

        if (exitWindowRequested) {
            // A request for close window has been issued, we can save data before closing
            // or just show a message asking for confirmation

            if (rl::isKeyPressed(rl::keyboard::Y))  { exitWindow = true; }
            else if (rl::isKeyPressed(rl::keyboard::N)) { exitWindowRequested = false; }
        }
        //----------------------------------------------------------------------------------

        // Draw
        //----------------------------------------------------------------------------------
        rl::@drawing() {
            rl::clearBackground(rl::RAYWHITE);

            if (exitWindowRequested) {
                rl::drawRectangle(0, 90, SCREEN_WIDTH, 200, rl::BLACK);
                rl::drawText("Are you sure you want to exit the program? [Y/N]", 70, 180, 30, rl::WHITE);
            } else {
                rl::drawText("Try to close the window to get confirmation message!", 180, 200, 20, rl::LIGHTGRAY);
            }
        };
    }
}