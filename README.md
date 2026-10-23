# Unity Project Template with Git LFS

This repository serves as a template for new Unity projects with pre-configured Git LFS support. It provides a clean project structure and optimized configuration files for efficient version control of Unity projects.

## Purpose

This template offers:
- ✅ Pre-configured Git LFS for Unity asset types
- ✅ Optimized `.gitignore` for Unity projects
- ✅ Clear, logical project structure
- ✅ No unwanted Unity-generated files in version control
- ✅ Ideal as a starting point for new Unity projects with Git version control

## Quick Setup Guide

Follow these steps to set up your Unity project with Git LFS:

### 1. Create and Clone Your Repository
- Create a new repository on GitHub
- Clone it locally to your computer:
  ```bash
  git clone https://github.com/your-username/your-repo-name.git
  cd your-repo-name
  ```

### 2. Set Up Your Unity Project
- Create a new Unity project in this folder, OR
- Move your existing Unity project into this folder

### 3. Copy Template Files
```bash
git clone https://github.com/LeosGmbH/unity-github-lfs-template.git
```

Then copy thes files form `/ProjectTemplateFiles/`:
- `/.gitattributes.template` → `.gitattributes` (in your project root)
- `/.gitignore.template` → `.gitignore` (in your project root)
- `/Assets/` → `Assets/` (merge with your existing Assets folder)


**Note:** Remove the `.template` suffix from the 2 files.

**Optional:** You don't have to clone the entire repository. You can also download just the `ProjectTemplateFiles` folder or its contents directly.

### 4. Remove .gitkeep Files
After copying the folder structure, remove all `.gitkeep` files:
```bash
# On Windows
del /s /q Assets\.gitkeep
# On macOS/Linux
find Assets -name ".gitkeep" -delete
```

### 5. Initialize Git LFS
```bash
git lfs install
```

### 6. Commit and Push
```bash
git add .
git commit -m "Initial Unity project setup with Git LFS"
git push
```

### Clean Up (if you cloned the template)
Delete the cloned 'unity-github-lfs-template.git' project as you no longer need it.

## Unity Settings You Have to Change

Do this inside Unity **before the first commit** (step 6). These settings decide whether the
repository is usable by more than one person, and whether `.gitattributes` does anything at all.

*Checked against the Unity 6.6 (6000.6) manual. The menu paths are the same in Unity 6.0 LTS and
in the 2021 to 2023 versions, only the defaults differ.*

### 1. Asset Serialization: `Force Text`
`Edit > Project Settings > Editor > Asset Serialization > Mode: Force Text`

Writes scenes, prefabs, materials and `.asset` files as YAML text instead of binary. Without it
every one of those files is an opaque blob: no readable diff, no three way merge, no merge tool.
`Force Text` is the default in Unity 6; the other options are `Mixed` (new assets become binary)
and `Force Binary`. Check it anyway, projects that started in an older Editor often carry `Mixed`.

### 2. Version Control: `Visible Meta Files`
`Edit > Project Settings > Version Control > Mode: Visible Meta Files`

Every asset has a `.meta` file next to it holding its GUID and its import settings. Visible means
the files are on disk where Git can see and commit them. Commit the `.meta` files together with
their asset, always. A missing `.meta` file breaks every reference to that asset for everyone else.
Pick `Perforce` only if you actually use Perforce; `Hidden Meta Files` is for projects without
version control.

### 3. Merging scenes and prefabs
Text serialization only makes a merge *possible*. Unity ships `UnityYAMLMerge` to actually do it,
and with plain Git you wire it in yourself (the `Smart Merge` dropdown in the Version Control
settings only applies to Perforce and Unity Version Control):

```ini
# in .git/config of your project, or in ~/.gitconfig for all projects
[merge]
    tool = unityyamlmerge
[mergetool "unityyamlmerge"]
    trustExitCode = false
    cmd = 'C:/Program Files/Unity/Hub/Editor/<version>/Editor/Data/Tools/UnityYAMLMerge.exe' merge -p "$BASE" "$REMOTE" "$LOCAL" "$MERGED"
```

`git mergetool` is what invokes it, after a `git merge` left a conflict. UnityYAMLMerge itself
merges `.unity`, `.prefab` and `.meta` files; `.asset`, `.mat` and `.controller` are handed to a
fallback merge tool unless you pass `--force`. The `merge=unityyamlmerge` attribute in
`.gitattributes` marks the file types that belong on this path.

**The cheaper rule, and the one that actually holds:** do not edit the same scene or prefab in
parallel. Split a scene into additive sub scenes or prefabs per person, or agree who owns a scene
right now. A merged scene file is valid YAML long before it is a working scene.

### 4. What goes through LFS, and what must not
LFS earns its keep on binaries: textures, audio, 3D models, video, fonts, archives, native plugins.
Those lines in `.gitattributes` are the reason to use LFS at all.

**Text assets stay out of LFS.** A file in LFS is a pointer in Git history, marked `-text`, so Git
cannot diff it and `UnityYAMLMerge` never sees it: every scene change becomes a binary conflict
that one side has to win whole. That would undo settings 1 and 3 above. The shipped
`.gitattributes` therefore gives the YAML types text handling instead:

```
*.unity *.prefab *.meta *.asset *.mat *.anim *.controller *.overrideController ...
    text eol=lf merge=unityyamlmerge
```

`eol=lf` because Unity writes these files with LF on every platform, Windows included. Without it,
Git would hand you CRLF on checkout and Unity would rewrite the whole file on the next save.

One exception: `LightingData.asset` is written binary even under `Force Text`, by design, so it is
the single `.asset` file the template routes to LFS.

**The tradeoff that stays.** A text asset in Git is a text asset in Git: a 40 MB terrain or a big
monolithic scene is committed in full on every change, diffs slowly and merges badly, and LFS would
have kept the clone small. Text handling buys you readable history and real merges, it does not
make huge assets cheap. The answer is smaller files, split scenes and prefabs per person, not LFS.

Check your own file after copying or editing it, from your project root:

```powershell
pwsh -File <path to template>/ProjectTemplateFiles/check-gitattributes.ps1
```

Decide this **before** the first commit; moving files in or out of LFS later rewrites history.

### 5. Folders that have to stay ignored
Unity regenerates these per machine, they are large and they conflict constantly. The shipped
`.gitignore` already covers them:

| Folder | Why |
|---|---|
| `Library/` | local cache of imported assets, rebuilt from `Assets/` |
| `Temp/` | cleared every time the Editor closes |
| `Logs/`, `obj/`, `Build/`, `Builds/` | logs, intermediate compiler output, build artifacts |
| `UserSettings/` | your personal layout and preferences, not the project's |

These three must be **committed**, otherwise the clone is not the same project:
`Assets/`, `Packages/` (the manifest pins the package versions) and `ProjectSettings/` (which is
where settings 1 and 2 are stored, so everyone gets them from the clone).

## Files in Detail

### `.gitattributes`
Routes the binary file types through Git LFS:
- Textures (PNG, JPG, TGA, PSD)
- Audio files (WAV, OGG, MP3)
- 3D models (FBX, OBJ)
- Video, fonts, archives, native plugins (DLL, SO)

And keeps Unity's text-serialized assets out of LFS, as `text eol=lf merge=unityyamlmerge`:
scenes, prefabs, `.meta`, materials, animations, animator controllers and the other YAML types.
See [What goes through LFS, and what must not](#4-what-goes-through-lfs-and-what-must-not) for why.

### `.gitignore`
Ignores automatically generated files and temporary files that should not be stored in version control, such as:
- Temporary build files
- Cache folders
- IDE-specific files
- Local user settings

### `Assets/` Structure
The Unity Project window sorts folders alphabetically. The number prefix turns that into an order
you chose: what you open daily on top, the content you only fill once at the bottom.

```
Assets/
  01_Scenes/
  02_Scripts/        01_Core/  02_Managers/  03_Gameplay/  04_UI/  05_Utils/
  03_Prefabs/
  04_Models/
  05_Materials/
  06_Shaders/
  07_Textures/
  08_Sprites/
  09_Animations/     animation clips and animator controllers
  10_Audio/          01_Music/  02_SFX/  03_Voice/
  11_UI/             01_Fonts/  02_Icons/
  12_Settings/       render pipeline, input, package settings
  Editor/            editor scripts, reserved name, never numbered
  Resources/         runtime Resources.Load, reserved name, never numbered
```

**The convention, for anyone adding a folder:**
1. Two digits, underscore, English name: `13_Localization`. Two digits so `10_` sorts after `09_`.
2. Numbers are a sort position, not an ID. Insert where the folder belongs and renumber the
   folders after it. Rename in the Unity Project window, not in Explorer, then the `.meta` files
   and all asset references follow along.
3. Subfolders get their own `01_` upwards, counted fresh per parent.
4. **Unity's reserved folder names stay unprefixed:** `Editor`, `Resources`, `Plugins`, `Gizmos`,
   `StreamingAssets`, `Editor Default Resources`. Their special behaviour is tied to the exact
   name, so `01_Resources` is just an ordinary folder and `Resources.Load` will not find anything
   in it. Letters sort after digits, so these end up at the bottom of the list by themselves.
5. Two digits are enough. If you ever need a 100th top level folder, the problem is not the
   numbering.

**Note:** The folder structure contains `.gitkeep` files to version empty folders in Git. These are automatically removed in step 4 of the setup guide.

### `check-gitattributes.ps1`
Reads a `.gitattributes` and reports every pattern that is a text-serialized Unity asset type and
still carries LFS attributes. Plain PowerShell, no dependency. Exit code 0 clean, 1 findings, so it
also works in a pre-commit hook or in CI.
- Located in `/ProjectTemplateFiles/`
- Run with: `pwsh -File check-gitattributes.ps1` (default `-Path .gitattributes`)

### `list.py` (Optional)
A utility script that creates a list of all file types found in the directory where the script is located. This can be useful for analyzing the file types in your project structure.
- Located in `/ProjectTemplateFiles/`
- Run with: `python list.py`
- Through this list you can extend the `.gitattributes.template` and `.gitignore.template` files with additional file types found in your project

## Important Notes

- **Git LFS**: Make sure Git LFS is installed before working with large assets
- **.gitkeep files**: Remove these after you start adding content to folders

## License

This template is licensed under the MIT License and can be freely used, modified and distributed.

## Contributing

This repository is open to contributions and improvements. Feel free to submit issues, feature requests, or pull requests to enhance this Unity project template for the community.
