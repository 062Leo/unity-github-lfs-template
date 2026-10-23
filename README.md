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
