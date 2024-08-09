# DJAM 8 (Pending Game Name)

![](assets/logos/djam8.png)

Theme: TBD

[DJAM8](https://itch.io/jam/discord-jam-8) - [Discord](https://discord.gg/uTaQTzTtBF)

Team members:

- [HotNoggin](https://github.com/HotNoggin)
- [TheNetherPug](https://github.com/TheNetherPug)
- [ZAFT](https://github.com/zaftnotameni)

Built Using:

- [Godot 4.3-rc3](https://github.com/godotengine/godot-builds/releases/download/4.3-rc3/Godot_v4.3-rc3_win64.exe.zip)
- [neovim](https://neovim.io/)
- [butler](https://itch.io/docs/butler/pushing.html)

Jam Rules:

- Make a game in 48 hours around the theme
- You’re free to use any tools or libraries to create your game
- Basecode is allowed
- You are allowed to used premade assets (including third-party assets you have the right to use)
- You can work Solo or in a Team. There is no limit to the amount of members you can have in a team.

## Running the Project

If you are on windows and have the correct Godot version with the default name in a folder on your path, you can just run:

```ps
bat\editor-rc.bat
```

That line will automatically start Godot 4.3-rc3 in verbose mode, skipping the project selection screen.

## Deploying the project

The project should be exported to (those folders already have a `.gdignore` so the editor won't load them):

- `res://exports/web`: web version
- `res://exports/win`: windows version
- `res://exports/lin`: linux version

After exporting, the following commands (assuming you have butler setup) will deploy each version:

- `bat\itch-web.bat`: web version
- `bat\itch-win.bat`: windows version
- `bat\itch-lin.bat`: linux version
