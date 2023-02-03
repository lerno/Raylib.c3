import rl;

// Constants
//--------------------------------------------------------------------------------------
const int SCREEN_WIDTH = 800;
const int SCREEN_HEIGHT = 450;

//------------------------------------------------------------------------------------
// Program main entry point
fn void main() {
// Initialization
//--------------------------------------------------------------------------------------
    rl::initWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "raylib [core] example - 3d camera free");
    defer rl::closeWindow();

	rl::Camera3D camera = { .position = Vector3{ 10.0f, 10.0f, 10.0f }, .target = Vector3{ 0.0f, 0.0f, 0.0f }, .up = Vector3{ 0.0f, 1.0f, 0.0f }, .fovy = 45.0f, .projection = rl::CameraProjection.PERSPECTIVE }; // named parameters are optional and not required.
	rl::Vector3 cubePosition = { .x = 0f, .y = 0f, .z = 0f }; // named parameters are optional and not required.
    
	rl::setCameraMode(camera, rl::CameraMode.FREE); // Set a free camera mode
    rl::setTargetFPS(60); // Set our game to run at 60 frames-per-second
    //--------------------------------------------------------------------------------------

	// Main game loop
    while(!rl::windowShouldClose()) { // Detect window close button or ESC key 
	    
		// Update
        //----------------------------------------------------------------------------------
        rl::updateCamera(&camera);

        if (rl::isKeyDown(rl::keyboard::Z)) camera.target = Vector3{ 0.0f, 0.0f, 0.0f };
        //----------------------------------------------------------------------------------
 		
		// Draw
        //----------------------------------------------------------------------------------
        rl::@drawing() {
            rl::clearBackground(rl::RAYWHITE);

			rl::@mode3D(camera) {
				rl::drawCube(cubePosition, 2.0f, 2.0f, 2.0f, rl::RED);
                rl::drawCubeWires(cubePosition, 2.0f, 2.0f, 2.0f, rl::MAROON);

                rl::drawGrid(10, 1.0f);
			};

			rl::drawRectangle( 10, 10, 320, 133, rl::fade(rl::SKYBLUE, 0.5f));
            rl::drawRectangleLines( 10, 10, 320, 133, rl::BLUE);

            rl::drawText("Free camera default controls:", 20, 20, 10, rl::BLACK);
            rl::drawText("- Mouse Wheel to Zoom in-out", 40, 40, 10, rl::DARKGRAY);
            rl::drawText("- Mouse Wheel Pressed to Pan", 40, 60, 10, rl::DARKGRAY);
            rl::drawText("- Alt + Mouse Wheel Pressed to Rotate", 40, 80, 10, rl::DARKGRAY);
            rl::drawText("- Alt + Ctrl + Mouse Wheel Pressed for Smooth Zoom", 40, 100, 10, rl::DARKGRAY);
            rl::drawText("- Z to zoom to (0, 0, 0)", 40, 120, 10, rl::DARKGRAY);
        };
    }
}