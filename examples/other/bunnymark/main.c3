import rl;
import std::io;

const int SCREEN_WIDTH = 1280;
const int SCREEN_HEIGHT = 960;

const int MAX_BUNNIES = 500000; // 50K bunnies limit

// This is the maximum amount of elements (quads) per batch
// NOTE: This value is defined in [rlgl] module and can be changed there
const int MAX_BATCH_ELEMENTS = 8192;

struct Bunny {
    Vector2 position;
    Vector2 speed;
    Color color;
}

fn void main()
{
    // Initialization
    //--------------------------------------------------------------------------------------
    rl::setConfigFlags(rl::config::VSYNC_HINT);
    rl::initWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "raylib [textures] example - bunnymark");
    defer rl::closeWindow();

    Texture2D texBunny = rl::loadTexture("resources/wabbit_alpha.png");
    defer rl::unloadTexture(texBunny);

    Bunny* bunnies = mem::malloc(MAX_BUNNIES * Bunny.sizeof);
    defer mem::free(bunnies);

    int bunniesCount = 0;

    while(!rl::windowShouldClose())
    {
        // Update
        //----------------------------------------------------------------------------------
        if (rl::isMouseButtonDown(rl::MouseButton.BUTTON_LEFT))
        {
            // Create more bunnies
            for (int i = 0; i < 100; i++)
            {
                if (bunniesCount < MAX_BUNNIES)
                {
                    bunnies[bunniesCount].position = rl::getMousePosition();
                    bunnies[bunniesCount].speed.x = (float)rl::getRandomValue(-250, 250)/60.0f;
                    bunnies[bunniesCount].speed.y = (float)rl::getRandomValue(-250, 250)/60.0f;
                    bunnies[bunniesCount].color = Color{ (char)rl::getRandomValue(50, 240), (char)rl::getRandomValue(80, 240), (char)rl::getRandomValue(100, 240), 255 };
                    bunniesCount++;
                }
            }
        }
        //----------------------------------------------------------------------------------

        // Update Bunnies
        for (int i = 0; i < bunniesCount; i++)
        {
            bunnies[i].position.x += bunnies[i].speed.x;
            bunnies[i].position.y += bunnies[i].speed.y;

            if (((bunnies[i].position.x + texBunny.width/2) > rl::getScreenWidth()) ||
                ((bunnies[i].position.x + texBunny.width/2) < 0)) bunnies[i].speed.x *= -1;
            if (((bunnies[i].position.y + texBunny.height/2) > rl::getScreenHeight()) ||
                ((bunnies[i].position.y + texBunny.height/2 - 40) < 0)) bunnies[i].speed.y *= -1;
        }

        // Update
        //----------------------------------------------------------------------------------
        rl::beginDrawing();

            rl::clearBackground(rl::RAYWHITE);
            
            for (int i = 0; i < bunniesCount; i++)
            {
                // NOTE: When internal batch buffer limit is reached (MAX_BATCH_ELEMENTS),
                // a draw call is launched and buffer starts being filled again;
                // before issuing a draw call, updated vertex data from internal CPU buffer is send to GPU...
                // Process of sending data is costly and it could happen that GPU data has not been completely
                // processed for drawing while new data is tried to be sent (updating current in-use buffers)
                // it could generates a stall and consequently a frame drop, limiting the number of drawn bunnies
                rl::drawTexture(texBunny, (int)bunnies[i].position.x, (int)bunnies[i].position.y, bunnies[i].color);
            }

            rl::drawRectangle(0, 0, SCREEN_WIDTH, 40, rl::BLACK);
            rl::drawText(rl::textFormat("bunnies: %i", bunniesCount), 120, 10, 20, rl::GREEN);
            rl::drawText(rl::textFormat("batched draw calls: %i", 1 + bunniesCount/MAX_BATCH_ELEMENTS), 320, 10, 20, rl::MAROON);

            rl::drawFPS(10, 10);

        rl::endDrawing();
        //----------------------------------------------------------------------------------

    }
}