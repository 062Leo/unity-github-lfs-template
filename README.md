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

It merges `.unity`, `.prefab` and `.meta` files. `.asset`, `.mat` and `.controller` fall through to
your normal merge tool unless you pass `--force`.

**The cheaper rule, and the one that actually holds:** do not edit the same scene or prefab in
parallel. Split a scene into additive sub scenes or prefabs per person, or agree who owns a scene
right now. A merged scene file is valid YAML long before it is a working scene.

### 4. What goes through LFS, and the price for text assets
LFS earns its keep on binaries: textures, audio, 3D models, video, archives, native plugins. Those
lines in `.gitattributes` are the reason to use LFS at all.

`.gitattributes` in this template also routes the **text** assets through LFS:

```
*.unity *.prefab *.mat *.asset *.anim *.controller
```

A file in LFS is a pointer in Git history, marked `-text`. So for these you get no diff, no merge
and no `UnityYAMLMerge`, only "keep mine or keep theirs" on every conflict. That is the right trade
for a solo project or a team that locks files, and the wrong one for a team that merges branches.

If you want mergeable scenes and prefabs, delete those six lines from your `.gitattributes` (the
"Materials & scriptable assets" and "Scenes & animation" blocks) and keep setting 1 and 3. Decide
this **before** the first commit; moving files in or out of LFS later rewrites history.

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
This file configures Git LFS for common Unity file types such as:
- Textures (PNG, JPG, TGA, PSD)
- Audio files (WAV, OGG, MP3)
- 3D models (FBX, OBJ)
- Unity-specific files (Scene, Prefab, Material, etc.)

### `.gitignore`
Ignores automatically generated files and temporary files that should not be stored in version control, such as:
- Temporary build files
- Cache folders
- IDE-specific files
- Local user settings

### `Assets/` Structure
The included folder structure in the `Assets` directory provides a logical organization for your project:
- **Animations/** - For animations and animator controllers
- **Audio/** - Divided into Music, SFX and Voice
- **Editor/** - For custom editor scripts
- **Materials/** - Material files
- **Models/** - 3D models
- **Prefabs/** - Unity prefabs
- **Scenes/** - Scenes, divided into Core and Levels
- **Scripts/** - C# scripts, organized by functionality
- **UI/** - User interface elements

**Note:** The folder structure contains `.gitkeep` files to version empty folders in Git. These are automatically removed in step 4 of the setup guide.

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
