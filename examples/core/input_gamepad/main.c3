import rl;

const int SCREEN_WIDTH = 800;
const int SCREEN_HEIGHT = 450;

const char[] XBOX360_LEGACY_NAME_ID = "Xbox Controller";
const char[] XBOX360_NAME_ID = "Microsoft 360 Controller";
const char[] PS3_NAME_ID = "PLAYSTATION(R)3 Controller";

//------------------------------------------------------------------------------------
// Program main entry point
//------------------------------------------------------------------------------------
fn void main()
{
    // Initialization
    //--------------------------------------------------------------------------------------
    rl::setConfigFlags(rl::config::MSAA_4X_HINT);
    rl::initWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "raylib [core] example - input mouse wheel");
    defer rl::closeWindow();

    Texture2D texPs3Pad = rl::loadTexture("resources/ps3.png");
    defer rl::unloadTexture(texPs3Pad);
    
    Texture2D texXboxPad = rl::loadTexture("resources/xbox.png");
    defer rl::unloadTexture(texXboxPad);

    rl::setTargetFPS(60); // Set our game to run at 60 frames-per-second
    //--------------------------------------------------------------------------------------
    
    // Main game loop
    while(!rl::windowShouldClose()) // Detect window close button or ESC key
    {

        // Update
        //----------------------------------------------------------------------------------
        rl::beginDrawing();
            rl::clearBackground(rl::RAYWHITE);

            if (rl::isGamepadAvailable(0))
            {
                rl::drawText(rl::textFormat("GP1: %s", rl::getGamepadName(0)), 10, 10, 10, rl::BLACK);

                if (rl::textIsEqual(rl::getGamepadName(0), XBOX360_NAME_ID) || rl::textIsEqual(rl::getGamepadName(0), XBOX360_LEGACY_NAME_ID))
                {
                    rl::drawTexture(texXboxPad, 0, 0, rl::DARKGRAY);

                    // Draw buttons: xbox home
                    if (rl::isGamepadButtonDown(0, rl::GamepadButton.MIDDLE)) rl::drawCircle(394, 89, 19, rl::RED);

                    // Draw buttons: basic
                    if (rl::isGamepadButtonDown(0, rl::GamepadButton.MIDDLE_RIGHT)) rl::drawCircle(436, 150, 9, rl::RED);
                    if (rl::isGamepadButtonDown(0, rl::GamepadButton.MIDDLE_LEFT)) rl::drawCircle(352, 150, 9, rl::RED);
                    if (rl::isGamepadButtonDown(0, rl::GamepadButton.RIGHT_FACE_LEFT)) rl::drawCircle(501, 151, 15, rl::BLUE);
                    if (rl::isGamepadButtonDown(0, rl::GamepadButton.RIGHT_FACE_DOWN)) rl::drawCircle(536, 187, 15, rl::LIME);
                    if (rl::isGamepadButtonDown(0, rl::GamepadButton.RIGHT_FACE_RIGHT)) rl::drawCircle(572, 151, 15, rl::MAROON);
                    if (rl::isGamepadButtonDown(0, rl::GamepadButton.RIGHT_FACE_UP)) rl::drawCircle(536, 115, 15, rl::GOLD);

                    // Draw buttons: d-pad
                    rl::drawRectangle(317, 202, 19, 71, rl::BLACK);
                    rl::drawRectangle(293, 228, 69, 19, rl::BLACK);
                    if (rl::isGamepadButtonDown(0, rl::GamepadButton.LEFT_FACE_UP)) rl::drawRectangle(317, 202, 19, 26, rl::RED);
                    if (rl::isGamepadButtonDown(0, rl::GamepadButton.LEFT_FACE_DOWN)) rl::drawRectangle(317, 202 + 45, 19, 26, rl::RED);
                    if (rl::isGamepadButtonDown(0, rl::GamepadButton.LEFT_FACE_LEFT)) rl::drawRectangle(292, 228, 25, 19, rl::RED);
                    if (rl::isGamepadButtonDown(0, rl::GamepadButton.LEFT_FACE_RIGHT)) rl::drawRectangle(292 + 44, 228, 26, 19, rl::RED);

                    // Draw buttons: left-right back
                    if (rl::isGamepadButtonDown(0, rl::GamepadButton.LEFT_TRIGGER_1)) rl::drawCircle(259, 61, 20, rl::RED);
                    if (rl::isGamepadButtonDown(0, rl::GamepadButton.RIGHT_TRIGGER_1)) rl::drawCircle(536, 61, 20, rl::RED);

                    // Draw axis: left joystick
                    rl::drawCircle(259, 152, 39, rl::BLACK);
                    rl::drawCircle(259, 152, 34, rl::LIGHTGRAY);
                    rl::drawCircle(259 + (int)(rl::getGamepadAxisMovement(0, rl::GamepadAxis.LEFT_X)*20),
                               152 + (int)(rl::getGamepadAxisMovement(0, rl::GamepadAxis.LEFT_Y)*20), 25, rl::BLACK);

                    // Draw axis: right joystick
                    rl::drawCircle(461, 237, 38, rl::BLACK);
                    rl::drawCircle(461, 237, 33, rl::LIGHTGRAY);
                    rl::drawCircle(461 + (int)(rl::getGamepadAxisMovement(0, rl::GamepadAxis.RIGHT_X)*20),
                               237 + (int)(rl::getGamepadAxisMovement(0, rl::GamepadAxis.RIGHT_Y)*20), 25, rl::BLACK);

                    // Draw axis: left-right triggers
                    rl::drawRectangle(170, 30, 15, 70, rl::GRAY);
                    rl::drawRectangle(604, 30, 15, 70, rl::GRAY);
                    rl::drawRectangle(170, 30, 15, (int)(((1 + rl::getGamepadAxisMovement(0, rl::GamepadAxis.LEFT_TRIGGER))/2)*70), rl::RED);
                    rl::drawRectangle(604, 30, 15, (int)(((1 + rl::getGamepadAxisMovement(0, rl::GamepadAxis.RIGHT_TRIGGER))/2)*70), rl::RED);

                    //DrawText(TextFormat("Xbox axis LT: %02.02f", GetGamepadAxisMovement(0, GAMEPAD_AXIS_LEFT_TRIGGER)), 10, 40, 10, BLACK);
                    //DrawText(TextFormat("Xbox axis RT: %02.02f", GetGamepadAxisMovement(0, GAMEPAD_AXIS_RIGHT_TRIGGER)), 10, 60, 10, BLACK);
                }
                else if (rl::textIsEqual(rl::getGamepadName(0), PS3_NAME_ID))
                {
                    rl::drawTexture(texPs3Pad, 0, 0, rl::DARKGRAY);

                    // Draw buttons: ps
                    if (rl::isGamepadButtonDown(0, rl::GamepadButton.MIDDLE)) rl::drawCircle(396, 222, 13, rl::RED);

                    // Draw buttons: basic
                    if (rl::isGamepadButtonDown(0, rl::GamepadButton.MIDDLE_LEFT)) rl::drawRectangle(328, 170, 32, 13, rl::RED);
                    if (rl::isGamepadButtonDown(0, rl::GamepadButton.MIDDLE_RIGHT)) rl::drawTriangle(Vector2{ 436, 168 }, Vector2{ 436, 185 }, Vector2{ 464, 177 }, rl::RED);
                    if (rl::isGamepadButtonDown(0, rl::GamepadButton.RIGHT_FACE_UP)) rl::drawCircle(557, 144, 13, rl::LIME);
                    if (rl::isGamepadButtonDown(0, rl::GamepadButton.RIGHT_FACE_RIGHT)) rl::drawCircle(586, 173, 13, rl::RED);
                    if (rl::isGamepadButtonDown(0, rl::GamepadButton.RIGHT_FACE_DOWN)) rl::drawCircle(557, 203, 13, rl::VIOLET);
                    if (rl::isGamepadButtonDown(0, rl::GamepadButton.RIGHT_FACE_LEFT)) rl::drawCircle(527, 173, 13, rl::PINK);

                    // Draw buttons: d-pad
                    rl::drawRectangle(225, 132, 24, 84, rl::BLACK);
                    rl::drawRectangle(195, 161, 84, 25, rl::BLACK);
                    if (rl::isGamepadButtonDown(0, rl::GamepadButton.LEFT_FACE_UP)) rl::drawRectangle(225, 132, 24, 29, rl::RED);
                    if (rl::isGamepadButtonDown(0, rl::GamepadButton.LEFT_FACE_DOWN)) rl::drawRectangle(225, 132 + 54, 24, 30, rl::RED);
                    if (rl::isGamepadButtonDown(0, rl::GamepadButton.LEFT_FACE_LEFT)) rl::drawRectangle(195, 161, 30, 25, rl::RED);
                    if (rl::isGamepadButtonDown(0, rl::GamepadButton.LEFT_FACE_RIGHT)) rl::drawRectangle(195 + 54, 161, 30, 25, rl::RED);

                    // Draw buttons: left-right back buttons
                    if (rl::isGamepadButtonDown(0, rl::GamepadButton.LEFT_TRIGGER_1)) rl::drawCircle(239, 82, 20, rl::RED);
                    if (rl::isGamepadButtonDown(0, rl::GamepadButton.RIGHT_TRIGGER_1)) rl::drawCircle(557, 82, 20, rl::RED);

                    // Draw axis: left joystick
                    rl::drawCircle(319, 255, 35, rl::BLACK);
                    rl::drawCircle(319, 255, 31, rl::LIGHTGRAY);
                    rl::drawCircle(319 + (int)(rl::getGamepadAxisMovement(0, rl::GamepadAxis.LEFT_X) * 20),
                               255 + (int)(rl::getGamepadAxisMovement(0, rl::GamepadAxis.LEFT_Y) * 20), 25, rl::BLACK);

                    // Draw axis: right joystick
                    rl::drawCircle(475, 255, 35, rl::BLACK);
                    rl::drawCircle(475, 255, 31, rl::LIGHTGRAY);
                    rl::drawCircle(475 + (int)(rl::getGamepadAxisMovement(0, rl::GamepadAxis.RIGHT_X) * 20),
                               255 + (int)(rl::getGamepadAxisMovement(0, rl::GamepadAxis.RIGHT_Y) * 20), 25, rl::BLACK);

                    // Draw axis: left-right triggers
                    rl::drawRectangle(169, 48, 15, 70, rl::GRAY);
                    rl::drawRectangle(611, 48, 15, 70, rl::GRAY);
                    rl::drawRectangle(169, 48, 15, (int)(((1 - rl::getGamepadAxisMovement(0, rl::GamepadAxis.LEFT_TRIGGER)) / 2) * 70), rl::RED);
                    rl::drawRectangle(611, 48, 15, (int)(((1 - rl::getGamepadAxisMovement(0, rl::GamepadAxis.RIGHT_TRIGGER)) / 2) * 70), rl::RED);
                }
                else
                {
                    rl::drawText("- GENERIC GAMEPAD -", 280, 180, 20, rl::GRAY);

                    // TODO: Draw generic gamepad
                }

                rl::drawText(rl::textFormat("DETECTED AXIS [%i]:", rl::getGamepadAxisCount(0)), 10, 50, 10, rl::MAROON);

                for (int i = 0; i < rl::getGamepadAxisCount(0); i++)
                {
                    rl::drawText(rl::textFormat("AXIS %i: %.02f", i, rl::getGamepadAxisMovement(0, i)), 20, 70 + 20*i, 10, rl::DARKGRAY);
                }

                if (rl::getGamepadButtonPressed() != -1) { rl::drawText(rl::textFormat("DETECTED BUTTON: %i", rl::getGamepadButtonPressed()), 10, 430, 10, rl::RED); }
                else { rl::drawText("DETECTED BUTTON: NONE", 10, 430, 10, rl::GRAY); }
            }
            else
            {
                rl::drawText("GP1: NOT DETECTED", 10, 10, 10, rl::GRAY);

                rl::drawTexture(texXboxPad, 0, 0, rl::LIGHTGRAY);
            }
        rl::endDrawing();
    }

}