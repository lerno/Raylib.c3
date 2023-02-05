import rl;

// Initialization
//--------------------------------------------------------------------------------------
const int SCREEN_WIDTH = 800;
const int SCREEN_HEIGHT = 450;
const int MAX_COLUMNS = 20;

//------------------------------------------------------------------------------------
// Program main entry point
//------------------------------------------------------------------------------------
fn void main() {
    rl::initWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "raylib [core] example - 3d camera first person");
    defer rl::closeWindow();

    // Define the camera to look into our 3d world (position, target, up vector)
    rl::Camera camera = { 
        .position = rl::Vector3{ 4.0f, 2.0f, 4.0f }, 
        .target = rl::Vector3{ 0.0f, 1.8f, 0.0f }, 
        .up = rl::Vector3{ 0.0f, 1.0f, 0.0f }, 
        .fovy = 60.0f, 
        .projection = rl::CameraProjection.PERSPECTIVE 
        };

    // Generates some random columns
    float[MAX_COLUMNS] heights = {};
    rl::Vector3[MAX_COLUMNS] positions = {};
    rl::Color[MAX_COLUMNS] colors = {};

    for (int i = 0; i < MAX_COLUMNS; i++) {
        heights[i] = (float)rl::getRandomValue(1, 12);
        positions[i] = rl::Vector3{ (float)rl::getRandomValue(-15, 15), heights[i]/2.0f, (float)rl::getRandomValue(-15, 15) };
        colors[i] = rl::Color{ (char)rl::getRandomValue(20, 255), (char)rl::getRandomValue(10, 55), 30, 255 };
    }

    rl::setCameraMode(camera, rl::CameraMode.FIRST_PERSON); // Set a first person camera mode

    rl::setTargetFPS(60); // Set our game to run at 60 frames-per-second
    //--------------------------------------------------------------------------------------
    
    // Main game loop
    while(!rl::windowShouldClose()) { // Detect window close button or ESC key

        // Update
        //----------------------------------------------------------------------------------
        rl::updateCamera(&camera);
        //----------------------------------------------------------------------------------
        
        // Draw
        //----------------------------------------------------------------------------------
        rl::@drawing() {
            rl::clearBackground(rl::RAYWHITE);
            
            rl::@mode3D(camera) {

                rl::drawPlane(rl::Vector3{ 0.0f, 0.0f, 0.0f }, rl::Vector2{ 32.0f, 32.0f }, rl::LIGHTGRAY); // Draw ground
                rl::drawCube(rl::Vector3{ -16.0f, 2.5f, 0.0f }, 1.0f, 5.0f, 32.0f, rl::BLUE);     // Draw a blue wall
                rl::drawCube(rl::Vector3{ 16.0f, 2.5f, 0.0f }, 1.0f, 5.0f, 32.0f, rl::LIME);      // Draw a green wall
                rl::drawCube(rl::Vector3{ 0.0f, 2.5f, 16.0f }, 32.0f, 5.0f, 1.0f, rl::GOLD);      // Draw a yellow wall

                // Draw some cubes around
                for (int i = 0; i < MAX_COLUMNS; i++) {
                    rl::drawCube(positions[i], 2.0f, heights[i], 2.0f, colors[i]);
                    rl::drawCubeWires(positions[i], 2.0f, heights[i], 2.0f, rl::MAROON);
                }
            };

            rl::drawRectangle( 10, 10, 220, 70, rl::fade(rl::SKYBLUE, 0.5f));
            rl::drawRectangleLines( 10, 10, 220, 70, rl::BLUE);

            rl::drawText("First person camera default controls:", 20, 20, 10, rl::BLACK);
            rl::drawText("- Move with keys: W, A, S, D", 40, 40, 10, rl::DARKGRAY);
            rl::drawText("- Mouse move to look around", 40, 60, 10, rl::DARKGRAY);
        };
    }
}


