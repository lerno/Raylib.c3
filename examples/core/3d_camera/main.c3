import rl;

const int SCREEN_WIDTH = 800;
const int SCREEN_HEIGHT = 450;

fn void main()
{
    rl::initWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "raylib [core] example - 3d camera mode");
    defer rl::closeWindow();
    
    // Define the camera to look into our 3d world
    Camera3D camera = { };
    camera.position = Vector3{ 0.0f, 10.0f, 10.0f };  // Camera position
    camera.target = Vector3{ 0.0f, 0.0f, 0.0f };      // Camera looking at point
    camera.up = Vector3{ 0.0f, 1.0f, 0.0f };          // Camera up vector (rotation towards target)
    camera.fovy = 45.0f;                                // Camera field-of-view Y
    camera.projection = rl::CameraProjection.PERSPECTIVE;             // Camera mode type

    Vector3 cubePosition = { 0.0f, 0.0f, 0.0f };


    rl::setTargetFPS(60);

    // Main game loop
    while (!rl::windowShouldClose())    // Detect window close button or ESC key
    {
        // Update
        //----------------------------------------------------------------------------------
        // TODO: Update your variables here
        //----------------------------------------------------------------------------------

        // Draw
        //----------------------------------------------------------------------------------
        rl::beginDrawing();

            rl::clearBackground(rl::RAYWHITE);

            rl::beginMode3D(camera);

                rl::drawCube(cubePosition, 2.0f, 2.0f, 2.0f, rl::RED);
                rl::drawCubeWires(cubePosition, 2.0f, 2.0f, 2.0f, rl::MAROON);

                rl::drawGrid(10, 1.0f);

            rl::endMode3D();

            rl::drawText("Welcome to the third dimension!", 10, 40, 20, rl::DARKGRAY);

            rl::drawFPS(10, 10);

        rl::endDrawing();
        //----------------------------------------------------------------------------------
    }
}