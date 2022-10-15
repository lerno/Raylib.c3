import rl;

const int SCREEN_WIDTH = 800;
const int SCREEN_HEIGHT = 450;

fn void main()
{
    rl::initWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "raylib [core] example - basic window");
    defer rl::closeWindow();
    
    rl::setTargetFPS(60);

    while(!rl::windowShouldClose())
    {
        rl::beginDrawing();
        rl::clearBackground(rl::RAYWHITE);
        rl::drawText("Congrats! You created your first window!", 190, 200, 20, rl::LIGHTGRAY);
        rl::endDrawing();
    }
}