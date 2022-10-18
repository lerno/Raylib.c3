import rl;

const int SCREEN_WIDTH = 800;
const int SCREEN_HEIGHT = 450;

fn void main()
{
    rl::initWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "raylib [shapes] example - easings box anim");
    defer rl::closeWindow();

    // Box variables to be animated with easings
    Rectangle rec = { rl::getScreenWidth()/2.0f, -100, 100, 100 };
    float rotation = 0.0f;
    float alpha = 1.0f;

    int state = 0;
    int framesCounter = 0;
    
    rl::setTargetFPS(60);

    while(!rl::windowShouldClose())
    {

        // Update
        //----------------------------------------------------------------------------------
        switch (state)
        {
            case 0:     // Move box down to center of screen
            {
                framesCounter++;

                // NOTE: Remember that 3rd parameter of easing function refers to
                // desired value variation, do not confuse it with expected final value!
                rec.y = rl::easings::easeElasticOut((float)framesCounter, -100, rl::getScreenHeight()/2.0f + 100, 120);

                if (framesCounter >= 120)
                {
                    framesCounter = 0;
                    state = 1;
                }
            } break;
            case 1:     // Scale box to an horizontal bar
            {
                framesCounter++;
                rec.height = rl::easings::easeBounceOut((float)framesCounter, 100, -90, 120);
                rec.width = rl::easings::easeBounceOut((float)framesCounter, 100, (float)rl::getScreenWidth(), 120);

                if (framesCounter >= 120)
                {
                    framesCounter = 0;
                    state = 2;
                }
            } break;
            case 2:     // Rotate horizontal bar rectangle
            {
                framesCounter++;
                rotation = rl::easings::easeQuadOut((float)framesCounter, 0.0f, 270.0f, 240);

                if (framesCounter >= 240)
                {
                    framesCounter = 0;
                    state = 3;
                }
            } break;
            case 3:     // Increase bar size to fill all screen
            {
                framesCounter++;
                rec.height = rl::easings::easeCircOut((float)framesCounter, 10, (float)rl::getScreenWidth(), 120);

                if (framesCounter >= 120)
                {
                    framesCounter = 0;
                    state = 4;
                }
            } break;
            case 4:     // Fade out animation
            {
                framesCounter++;
                alpha = rl::easings::easeSineOut((float)framesCounter, 1.0f, -1.0f, 160);

                if (framesCounter >= 160)
                {
                    framesCounter = 0;
                    state = 5;
                }
            } break;
            default: break;
        }

        // Reset animation at any moment
        if (rl::isKeyPressed(rl::keyboard::SPACE))
        {
            rec = Rectangle{ rl::getScreenWidth()/2.0f, -100, 100, 100 };
            rotation = 0.0f;
            alpha = 1.0f;
            state = 0;
            framesCounter = 0;
        }
        //----------------------------------------------------------------------------------

        // Draw
        //----------------------------------------------------------------------------------

        rl::beginDrawing();
            rl::clearBackground(rl::RAYWHITE);

            rl::drawRectanglePro(rec, Vector2{ rec.width/2, rec.height/2 }, rotation, rl::fade(rl::BLACK, alpha));

            rl::drawText("PRESS [SPACE] TO RESET BOX ANIMATION!", 10, rl::getScreenHeight() - 25, 20, rl::LIGHTGRAY);

        rl::endDrawing();
    }
}