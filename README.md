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
