import rl;

const int SCREEN_WIDTH = 800;
const int SCREEN_HEIGHT = 450;
const int MAX_BUILDING = 100;

//------------------------------------------------------------------------------------
// Program main entry point
//------------------------------------------------------------------------------------
fn void main()
{
    // Initialization
    //--------------------------------------------------------------------------------------
    rl::initWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "raylib [core] example - 2d camera");
    defer rl::closeWindow();

    Rectangle player = { 400, 280, 40, 40 };
    Rectangle[MAX_BUILDING] buildings = { };
    Color[MAX_BUILDING] buildColors = { };

    int spacing = 0;

    for (int i = 0; i < MAX_BUILDING; i++)
    {
        buildings[i].width = (float)rl::getRandomValue(50, 200);
        buildings[i].height = (float)rl::getRandomValue(100, 800);
        buildings[i].y = SCREEN_HEIGHT - 130.0f - buildings[i].height;
        buildings[i].x = -6000.0 + spacing;

        spacing += (int)buildings[i].width;
        buildColors[i] = Color{(char)rl::getRandomValue(200, 240), (char)rl::getRandomValue(200, 240), (char)rl::getRandomValue(200, 250), 255 };
    }

    Camera2D camera = { };
    camera.target = Vector2{player.x + 20.0f, player.y + 20.0f};
    camera.offset = Vector2{SCREEN_WIDTH/2.0f, SCREEN_HEIGHT/2.0f};
    camera.rotation = 0.0f;
    camera.zoom = 1.0f;
    
    rl::setTargetFPS(60); // Set our game to run at 60 frames-per-second
    //--------------------------------------------------------------------------------------
    // Main game loop
    while(!rl::windowShouldClose()) // Detect window close button or ESC key
    {
        // Update
        //----------------------------------------------------------------------------------
        // Player movement
        if (rl::isKeyDown(rl::keyboard::RIGHT)) { player.x+= 2; }
        else if (rl::isKeyDown(rl::keyboard::LEFT)) { player.x -=2; }
        
        // Camera target follows player
        camera.target = Vector2 {player.x + 20, player.y + 20};

        // Camera rotation controls
        if (rl::isKeyDown(rl::keyboard::A)) { camera.rotation--; }
        else if (rl::isKeyDown(rl::keyboard::S)) { camera.rotation++; }

        // Limit camera rotation to 80 degrees (-40 to 40)
        if (camera.rotation > 40) { camera.rotation = 40; }
        else if (camera.rotation < -40) { camera.rotation = -40; }

        // Camera zoom controls
        camera.zoom += (float)(rl::getMouseWheelMove()*0.05f);

        if (camera.zoom > 3.0f) { camera.zoom = 3.0f; }
        else if (camera.zoom < 0.1f) { camera.zoom = 0.1f; }

        // Camera reset (zoom and rotation)
        if (rl::isKeyPressed(rl::keyboard::R)) 
        {
            camera.zoom = 1.0f;
            camera.rotation = 0.0f;
        }

        //----------------------------------------------------------------------------------

        // Draw
        //----------------------------------------------------------------------------------
        rl::beginDrawing();
        
            rl::clearBackground(rl::RAYWHITE);
            
            rl::beginMode2D(camera);
                
                rl::drawRectangle(-6000, 320, 13000, 8000, rl::DARKGRAY);
                
                for (int i = 0; i < MAX_BUILDING; i++) rl::drawRectangleRec(buildings[i], buildColors[i]);

                rl::drawRectangleRec(player, rl::RED);

                rl::drawLine((int)camera.target.x, -SCREEN_HEIGHT*10, (int)camera.target.x, SCREEN_HEIGHT*10, rl::GREEN);
                rl::drawLine(-SCREEN_WIDTH*10, (int)camera.target.y, SCREEN_WIDTH*10, (int)camera.target.y, rl::GREEN);
            
            rl::endMode2D();

            rl::drawText("SCREEN AREA", 640, 10, 20, rl::RED);

            rl::drawRectangle(0, 0, SCREEN_WIDTH, 5, rl::RED);
            rl::drawRectangle(0, 5, 5, SCREEN_HEIGHT - 10, rl::RED);
            rl::drawRectangle(SCREEN_WIDTH - 5, 5, 5, SCREEN_HEIGHT - 10, rl::RED);
            rl::drawRectangle(0, SCREEN_HEIGHT - 5, SCREEN_WIDTH, 5, rl::RED);

            rl::drawRectangle( 10, 10, 250, 113, rl::fade(rl::SKYBLUE, 0.5f));
            rl::drawRectangleLines( 10, 10, 250, 113, rl::BLUE);

            rl::drawText("Free 2d camera controls:", 20, 20, 10, rl::BLACK);
            rl::drawText("- Right/Left to move Offset", 40, 40, 10, rl::DARKGRAY);
            rl::drawText("- Mouse Wheel to Zoom in-out", 40, 60, 10, rl::DARKGRAY);
            rl::drawText("- A / S to Rotate", 40, 80, 10, rl::DARKGRAY);
            rl::drawText("- R to reset Zoom and Rotation", 40, 100, 10, rl::DARKGRAY);


        rl::endDrawing();
    }
}