<div align="center">
<p>

[📖 Back to Main Page](./README.md)
</p>

# Installation Guide

</div>

## Table of Contents

- [Installation Guide](#installation-guide)
  - [Table of Contents](#table-of-contents)
  - [Compatibility](#compatibility)
  - [Dependencies](#dependencies)
  - [C3 Build System](#c3-build-system)

## Compatibility

**Supported Platforms:**

- [x] Linux
- [X] Windows *(in progress)*
- [X] MacOS
- [ ] WASM

## Dependencies

You don't need to have Raylib installed on your system to use Raylib.c3, but you will need to provide the static library `libraylib.a` to the required target folder.

To obtain one, you can either download it from Raylib's github page or build it yourself. - Recommended.

## C3 Build System

The recommended and supported way is to create a C3 project which provides you with all the necessary structure to create and run your project easier:

- Go ahead and create your project using `c3c init PROJECT_NAME_HERE`
- [Clone Raylib.c](https://github.com/Its-Kenta/Raylib.c3.git) and extract `raylib.c3l` to your `lib` folder.

We're now ready to prepare our `project.json` file to instruct our C3 compiler - what dependency we're using and where to find it.:

```json
{
  "langrev": "1",
  "warnings": [ "no-unused" ],
  "dependency-search-paths": ["lib"],
  "dependencies": [ "raylib" ],
  "authors": [ "Kenta" ],
  "version": "1.0",
  "sources": [ "src/**" ],
  "targets": {
    "my_game_name_here": {
      "type": "executable"
    }
  }
}
```

As you can see, we tell the compiler it can find dependencies in the `lib` folder and our dependency is `raylib`.


> Note:
>
> You can change your binary file by changing the `my_game_name_here` field in `project.json`
