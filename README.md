# HappyBug

HappyBug is a mod for the now defunct Otherland MMO. It adds a bunch of miscellaneous features that make offline exploration of the game's maps possible/more convenient.

## Installation

Place `HappyBug.u` in the `UnrealEngine3/AmunGame/CookedPCConsole` directory within your Otherland install.

Open `UnrealEngine3/AmunGame/Config/DefaultGame.ini` and replace this section near the top of the file:

```
DefaultGame=Otherland.OtherlandGameInfo
DefaultServerGame=OtherLand.OtherlandGameInfo
```

With this:

```
DefaultGame=HappyBug.HappyBugGameInfo
DefaultServerGame=HappyBug.HappyBugGameInfo
```

(If you've used "OtherlandStartAtOrigin" before, you'll have different values there.)

## Features

Debug camera is enabled by default, the `re ClientOnlyStartUp` trick is not required.

For some reason, the mod also enables the console in earlier versions of the game, that didn't have the test exe.

All maps that crash the game due to missing player start should be fixed now.

Use the `HBGhost` command to toggle world collisions.

Use `HBSpeed` to toggle high speed mode, or use it to set a specific speed (e.g. `HBSpeed 1000`).

The `HBCinematic` command can trigger some in-game rendered cutscenes. Call it with the name of a cinematic to play that one. Using an invalid name will list out the available cinematics in the level.

The `HBMatinee` command is a bit more aggressive and can play most cutscenes, though some have issues with hidden objects. Call it without an argument to list the number of matinees in the level. Call it with an index to start a matinee (starting with 0). Use `HBMatinee <number> true` to reset a matinee without playing it.

The `HBUnhideAll` command makes every hidden actor visible.
## Development

The repo should be checked out into the `Development/Src` directory of the 2011-08 version of the UDK. First, navigate to the right directory, then do:

```
git init
git remote add origin https://github.com/DRKV333/HappyBug.git
git pull origin master
git branch --set-upstream-to=origin/master master
```

Open `UDKGame/Config/DefaultEngine.ini` and at the end of the `[UnrealEd.EditorEngine]` section, add these lines:

```
+EditPackages=HappyBug
```

(This list might expand in the future.)

In `UDKGame/Config/DefaultGame.ini` replace these line:

```
DefaultGame=UDKBase.SimpleGame
DefaultServerGame=UDKBase.SimpleGame
```

With these:

```
DefaultGame=HappyBug.HappyBugGameInfo
DefaultServerGame=HappyBug.HappyBugGameInfo
```

(This is technically not required, but it lets you debug the mod in UnrealEd.)

To compile open `Binaries/UnrealFrontend.exe`, click on `Script` at the top and select `Compile scripts`.

The compiled package will be at `UDKGame/Script/HappyBug.u`.
