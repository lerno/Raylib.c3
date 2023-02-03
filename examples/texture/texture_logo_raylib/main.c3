import rl;

const int SCREEN_WIDTH = 800;
const int SCREEN_HEIGHT = 450;

fn void main()
{
    rl::initWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "raylib [textures] example - texture loading and drawing");
    defer rl::closeWindow();
    
    rl::setTargetFPS(60);

	rl::Texture2D texture = rl::loadTexture("resources/logo.png");
	defer rl::unloadTexture(texture);

    while(!rl::windowShouldClose())
    {
        rl::@drawing() {
            rl::clearBackground(rl::RAYWHITE);
			rl::drawTexture(texture, SCREEN_WIDTH/2 - texture.width/2, SCREEN_HEIGHT/2 - texture.height/2, rl::WHITE);
            rl::drawText("this IS a texture!", 360, 370, 10, rl::GRAY);
        };
    }
}