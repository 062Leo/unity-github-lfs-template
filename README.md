# Unity Project Template with Git LFS

This repository serves as a template for new Unity projects with pre-configured Git LFS support. It provides a clean project structure and optimized configuration files for efficient version control of Unity projects.

## Purpose

This template offers:
- ✅ Pre-configured Git LFS for Unity asset types
- ✅ Optimized `.gitignore` for Unity projects
- ✅ Clear, logical project structure
- ✅ No unwanted Unity-generated files in version control
- ✅ Ideal as a starting point for new Unity projects with Git version control

## Usage

### Prerequisites
Before you begin, make sure the following is installed:
- [Git](https://git-scm.com/downloads)
- [Git LFS](https://git-lfs.github.com/)
- [Unity Hub](https://unity.com/download) with a current Unity version

### Installation

1. **Clone repository**
   ```bash
   git clone <Your-Repository-URL>
   cd <Your-Project-Name>
   ```

2. **Initialize Git LFS**
   ```bash
   git lfs install
   ```

3. **Copy template files**
   Copy the following files to your new Unity project:
   - `.gitattributes` - For proper handling of binary files with Git LFS
   - `.gitignore` - Ignores Unity-specific files that should not be versioned

4. **Adopt project structure (optional)**
   The `Assets` folder contains a recommended project structure for your Unity project. You can copy this to your project to start immediately with a clean folder structure.

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

### Remove .gitkeep files
The folder structure contains `.gitkeep` files to version empty folders in Git. After you have adopted the project, these files can be removed:

**Important Note:** Run this command while you are in the directory where the `Assets` folder is located (not in the `Assets` folder itself).

```bash
del /s /q Assets\.gitkeep
```

This command recursively deletes all `.gitkeep` files in the subdirectories of `Assets`.

## Next Steps

1. Create a new repository on GitHub
2. Initialize Git in your project directory:
   ```bash
   git init
   git remote add origin <Your-Repository-URL>
   ```
3. Make your first commit and push your changes

## License

This template is licensed under the MIT License and can be freely used, modified and distributed.

## Contributing

This repository is open to contributions and improvements. Feel free to submit issues, feature requests, or pull requests to enhance this Unity project template for the community.
