# Unity Projekt Template mit Git LFS

Diese Repository dient als Vorlage für neue Unity-Projekte mit bereits konfigurierter Git LFS-Unterstützung. Es bietet eine saubere Projektstruktur und optimierte Konfigurationsdateien für eine effiziente Versionskontrolle von Unity-Projekten.

## Zweck

Dieses Template bietet:
- ✅ Vorkonfiguriertes Git LFS für Unity-Asset-Typen
- ✅ Optimierte `.gitignore` für Unity-Projekte
- ✅ Klare, logische Projektstruktur
- ✅ Keine unerwünschten Unity-generierten Dateien in der Versionskontrolle
- ✅ Ideal als Ausgangspunkt für neue Unity-Projekte mit Git-Versionskontrolle

## Verwendung

### Voraussetzungen
Bevor Sie beginnen, stellen Sie sicher, dass folgendes installiert ist:
- [Git](https://git-scm.com/downloads)
- [Git LFS](https://git-lfs.github.com/)
- [Unity Hub](https://unity.com/download) mit einer aktuellen Unity-Version

### Installation

1. **Repository klonen**
   ```bash
   git clone <Ihre-Repository-URL>
   cd <Ihr-Projekt-Name>
   ```

2. **Git LFS initialisieren**
   ```bash
   git lfs install
   ```

3. **Template-Dateien kopieren**
   Kopieren Sie die folgenden Dateien in Ihr neues Unity-Projekt:
   - `.gitattributes` - Für die korrekte Handhabung von Binärdateien mit Git LFS
   - `.gitignore` - Ignoriert Unity-spezifische Dateien, die nicht versioniert werden sollten

4. **Projektstruktur übernehmen (optional)**
   Der `Assets`-Ordner enthält eine empfohlene Projektstruktur für Ihr Unity-Projekt. Sie können diesen in Ihr Projekt kopieren, um sofort mit einer sauberen Ordnerstruktur zu beginnen.

## Dateien im Detail

### `.gitattributes`
Diese Datei konfiguriert Git LFS für gängige Unity-Dateitypen wie:
- Texturen (PNG, JPG, TGA, PSD)
- Audiodateien (WAV, OGG, MP3)
- 3D-Modelle (FBX, OBJ)
- Unity-spezifische Dateien (Scene, Prefab, Material, etc.)

### `.gitignore`
Ignoriert automatisch generierte Dateien und temporäre Dateien, die nicht in der Versionskontrolle gespeichert werden sollten, wie z.B.:
- Temporäre Build-Dateien
- Cache-Ordner
- IDE-spezifische Dateien
- Lokale Benutzereinstellungen

### `Assets/`-Struktur
Die mitgelieferte Ordnerstruktur im `Assets`-Verzeichnis bietet eine logische Organisation für Ihr Projekt:
- **Animations/** - Für Animationen und Animator-Controller
- **Audio/** - Unterteilt in Music, SFX und Voice
- **Editor/** - Für benutzerdefinierte Editor-Skripte
- **Materials/** - Materialdateien
- **Models/** - 3D-Modelle
- **Prefabs/** - Unity-Prefabs
- **Scenes/** - Szenen, aufgeteilt in Core und Levels
- **Scripts/** - C#-Skripte, organisiert nach Funktionalität
- **UI/** - Benutzeroberflächen-Elemente

## Nächste Schritte

1. Erstellen Sie ein neues Repository auf GitHub
2. Initialisieren Sie Git in Ihrem Projektverzeichnis:
   ```bash
   git init
   git remote add origin <Ihre-Repository-URL>
   ```
3. Führen Sie einen ersten Commit durch und pushen Sie Ihre Änderungen

## Lizenz

Diese Vorlage kann frei verwendet, modifiziert und verteilt werden.
