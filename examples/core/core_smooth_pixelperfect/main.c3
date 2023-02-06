import rl;
import std::math;

const int SCREEN_WIDTH = 800;
const int SCREEN_HEIGHT = 450;

const int VIRTUAL_SCREEN_WIDTH = 160;
const int VIRTUAL_SCREEN_HEIGHT = 90;
const float VIRTUAL_RATIO = (float)SCREEN_WIDTH / (float) VIRTUAL_SCREEN_WIDTH;

//------------------------------------------------------------------------------------
// Program main entry point
//------------------------------------------------------------------------------------
fn void main() {
    // Initialization
    //--------------------------------------------------------------------------------------
    rl::initWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "raylib [core] example - smooth pixel-perfect camera");
    defer rl::closeWindow();

    rl::Camera2D worldSpaceCamera = {}; // Game world camera
    worldSpaceCamera.zoom = 1.0f;

    rl::Camera2D screenSpaceCamera = {};  // Smoothing camera
    screenSpaceCamera.zoom = 1.0f;

    rl::RenderTexture2D target = rl::loadRenderTexture(VIRTUAL_SCREEN_WIDTH, VIRTUAL_SCREEN_HEIGHT);
    defer rl::unloadRenderTexture(target); // Unload render texture

    rl::Rectangle rect01 = { 70.0f, 35.0f, 20.0f, 20.0f };
    rl::Rectangle rect02 = { 90.0f, 55.0f, 30.0f, 10.0f };
    rl::Rectangle rect03 = { 80.0f, 65.0f, 15.0f, 25.0f };

    // The target's height is flipped (in the source Rectangle), due to OpenGL reasons
    rl::Rectangle sourceRec = { 0.0f, 0.0f, (float)target.texture.width, -(float)target.texture.height };
    rl::Rectangle destRect = { -VIRTUAL_RATIO, -VIRTUAL_RATIO, SCREEN_WIDTH + (VIRTUAL_RATIO*2), SCREEN_HEIGHT + (VIRTUAL_RATIO*2) };

    rl::Vector2 origin = { 0.0f, 0.0f };
    
    float rotation = 0.0f;

    float cameraX = 0.0f;
    float cameraY = 0.0f;

    rl::setTargetFPS(60);
    //--------------------------------------------------------------------------------------
    
    // Main game loop
    while(!rl::windowShouldClose()) { // Detect window close button or ESC key

        // Update
        //----------------------------------------------------------------------------------
        rotation += 60.0f * rl::getFrameTime(); // Rotate the rectangles, 60 degrees per second

        // Make the camera move to demonstrate the effect
        cameraX = (float)(math::sin(rl::getTime()) * 50.0f) - 10.0f;
        cameraY = (float)math::cos(rl::getTime()) * 30.0f;

        // Set the camera's target to the values computed above
        screenSpaceCamera.target = rl::Vector2{ cameraX, cameraY };
        
        // Round worldSpace coordinates, keep decimals into screenSpace coordinates
        worldSpaceCamera.target.x = (int)screenSpaceCamera.target.x;
        screenSpaceCamera.target.x -= worldSpaceCamera.target.x;
        screenSpaceCamera.target.x *= VIRTUAL_RATIO;

        worldSpaceCamera.target.y = (int)screenSpaceCamera.target.y;
        screenSpaceCamera.target.y -= worldSpaceCamera.target.y;
        screenSpaceCamera.target.y *= VIRTUAL_RATIO;
        //----------------------------------------------------------------------------------

        // Drawing
        //----------------------------------------------------------------------------------
        rl::@textureMode(target) {
            rl::clearBackground(rl::RAYWHITE);

            rl::@mode2D(worldSpaceCamera) {
                rl::drawRectanglePro(rect01, origin, rotation, rl::BLACK);
                rl::drawRectanglePro(rect02, origin, -rotation, rl::RED);
                rl::drawRectanglePro(rect03, origin, rotation + 45.0f, rl::BLUE);
            };
        };

        rl::@drawing() {
            rl::clearBackground(rl::RED);

            rl::@mode2D(screenSpaceCamera) {
                rl::drawTexturePro(target.texture, sourceRec, destRect, origin, 0.0f, rl::WHITE);
            };

            rl::drawText(rl::textFormat("Screen resolution: %ix%i", SCREEN_WIDTH, SCREEN_HEIGHT), 10, 10, 20, rl::DARKBLUE);
            rl::drawText(rl::textFormat("World resolution: %ix%i", VIRTUAL_SCREEN_WIDTH, VIRTUAL_SCREEN_HEIGHT), 10, 40, 20, rl::DARKGREEN);
            rl::drawFPS(rl::getScreenWidth() - 95, 10);
        };
    }
}