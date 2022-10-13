<a href="http://www.c3-lang.org/"><img style="vertical-align:middle" src=https://i.imgur.com/jtVwIgz.png></a>
# Raylib C3

[C3](http://www.c3-lang.org/) binding for [Raylib](http://www.raylib.com/) a simple and easy-to-use library to learn videogames programming.

*Using Raylib Version 4.5-dev*

## Supported Platforms
- Windows
- MacOS
- Linux

## Covered APIs
- [X] raylib.h
- [X] raymath.h
- [ ] easings.h - Planned
- [ ] raygui.h - Planned

## Installation - Using C3s build system
**1.** Create a C3 project. (instructions without project.c3p below)

**2.** Clone the Raylib C3 repository.
```bash
https://github.com/Its-Kenta/Raylib-C3.git
```

**3.** Move the *raylib.c3l* folder to your projects *lib*.

**4.** Add (or use provided pre-compiled library version 4.5-dev) the compiled static library or use your system shared (make sure its added to path!) to the desired target inside the *raylib.c3l* folder.

**4.** Edit your *project.c3p* file to include the library and the library directory as followed:
```
    // library directory
  "libdir": ["lib"],
    // libraries to use for all targets
  "libs": [ "raylib" ],
```

**5.** Add the example code to your main.c3 in *src/YOURPROJECTNAME/main.c3*
```c
import rl;
import std::io;

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
```

**6.** Run `c3c run` command to test it out!

**7.** Enjoy your time by learning C3 and create some amazing games!

### Running the example without using C3s build system
Running C3 with external libraries is really easy!

**1.** Create your source code file with the example above.

**2.** Clone the Raylib C3 repository.
```bash
https://github.com/Its-Kenta/Raylib-C3.git
```

**3.** Place your the downloaded *raylib.c3l* preferrably in a folder called "lib", but that is up to you. You will just have to pass the path to it later.

**4.** Run the following command `c3c compile-run --lib raylib --libdir /path/to/the/dir/with/raylibc3l/ main.c3`
This command will compile and run the code and pass the library being imported with it's path.


## Disclaimer
This is the first binding I've made and made available to the public.
I am aware that not everyone adheres to the same coding conventions and that this may not be to everyone's liking, but please feel free to submit your PRs so that we may make different branches to suit everyone!

Due to my lack of confidence in my abilities, I would also like to mention that there *might* be some code that does not function properly, not that I believe there is. Nevertheless, I hope you can help me improve by pointing out any potential mistakes I may have made. 

## Credits
Massive thank you to Christoffer L (C3 Creator) for his help on [C3 Discord community server](https://discord.gg/UWUTtUGJBT) and his vendor library template that Raylib-C3 grew from.
