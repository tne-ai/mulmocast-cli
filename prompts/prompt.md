# MulmoCast AI Agent Prompt

This document provides a comprehensive guide for an AI agent to understand and use the `mulmocast-cli` tool.

## Introduction

MulmoCast is a next-generation, AI-native multi-modal presentation platform that transforms text-based content into various formats, including videos, podcasts, slideshows, PDFs, and manga-style comics. The platform is designed to work with Large Language Models (LLMs) through an intermediate JSON-based language called **MulmoScript**.

The `mulmocast-cli` is a command-line interface that allows developers and AI agents to programmatically generate and manipulate multi-modal content.

## Installation

To use the `mulmocast-cli`, you need to have Node.js and ffmpeg installed.

### 1. Install Node.js

Make sure you have Node.js version 16 or higher. You can check your version with:

```bash
node --version
```

### 2. Install ffmpeg

On macOS, you can install ffmpeg using Homebrew:

```bash
brew install ffmpeg
```

For other operating systems, please refer to the official ffmpeg website: https://ffmpeg.org/download.html

### 3. Install mulmocast-cli

You can install the `mulmocast-cli` globally using npm:

```bash
npm install -g mulmocast
```

### 4. Configure API Keys

Create a `.env` file in your project directory and add your API keys.

**Required:**

```
OPENAI_API_KEY=your_openai_api_key
```

**Optional:**

```
DEFAULT_OPENAI_IMAGE_MODEL=gpt-image-1
GOOGLE_PROJECT_ID=your_google_project_id
ELEVENLABS_API_KEY=your_elevenlabs_key
NIJIVOICE_API_KEY=your_nijivoice_key
BROWSERLESS_API_TOKEN=your_browserless_api_token
```

## CLI Commands

The `mulmocast-cli` provides a set of commands to generate and manipulate multi-modal content.

### Main Commands

| Command | Description |
|---|---|
| `translate <file>` | Translate a MulmoScript to a different language. |
| `audio <file>` | Generate audio files from a MulmoScript. |
| `images <file>` | Generate image files from a MulmoScript. |
| `movie <file>` | Generate a complete video from a MulmoScript. |
| `pdf <file>` | Generate a PDF document from a MulmoScript. |
| `tool <subcommand>` | Access utility tools for script generation and schema management. |

### Tool Subcommands

| Subcommand | Description |
|---|---|
| `scripting` | Generate a MulmoScript from a URL, markdown file, or interactive prompts. |
| `prompt` | Dump template prompts. |
| `schema` | Show the JSON schema for MulmoScript. |

### `translate <file>`

Translates a MulmoScript to a different language.

**Usage:**

```bash
mulmo translate <file> [options]
```

**Arguments:**

| Argument | Description |
|---|---|
| `file` | The path to the MulmoScript file. |

**Options:**

| Option | Description |
|---|---|
| `-o, --outdir <dir>` | The output directory for the translated file. |
| `-b, --basedir <dir>` | The base directory for resolving relative paths. |
| `-l, --lang <lang>` | The target language for translation (e.g., `en`, `ja`). |
| `-f, --force` | Force regeneration of the translated file. |

### `audio <file>`

Generates audio files from a MulmoScript.

**Usage:**

```bash
mulmo audio <file> [options]
```

**Arguments:**

| Argument | Description |
|---|---|
| `file` | The path to the MulmoScript file. |

**Options:**

| Option | Description |
|---|---|
| `-o, --outdir <dir>` | The output directory for the audio files. |
| `-b, --basedir <dir>` | The base directory for resolving relative paths. |
| `-l, --lang <lang>` | The target language for the audio (e.g., `en`, `ja`). |
| `-f, --force` | Force regeneration of the audio files. |
| `--dryRun` | Perform a dry run without generating any files. |
| `-p, --presentationStyle <style>` | The presentation style to use. |
| `-a, --audiodir <dir>` | The output directory for the audio files. |

### `images <file>`

Generates image files from a MulmoScript.

**Usage:**

```bash
mulmo images <file> [options]
```

**Arguments:**

| Argument | Description |
|---|---|
| `file` | The path to the MulmoScript file. |

**Options:**

| Option | Description |
|---|---|
| `-o, --outdir <dir>` | The output directory for the image files. |
| `-b, --basedir <dir>` | The base directory for resolving relative paths. |
| `-l, --lang <lang>` | The target language for the images (e.g., `en`, `ja`). |
| `-f, --force` | Force regeneration of the image files. |
| `--dryRun` | Perform a dry run without generating any files. |
| `-p, --presentationStyle <style>` | The presentation style to use. |
| `-i, --imagedir <dir>` | The output directory for the image files. |

### `movie <file>`

Generates a movie file from a MulmoScript.

**Usage:**

```bash
mulmo movie <file> [options]
```

**Arguments:**

| Argument | Description |
|---|---|
| `file` | The path to the MulmoScript file. |

**Options:**

| Option | Description |
|---|---|
| `-o, --outdir <dir>` | The output directory for the movie file. |
| `-b, --basedir <dir>` | The base directory for resolving relative paths. |
| `-l, --lang <lang>` | The target language for the movie (e.g., `en`, `ja`). |
| `-f, --force` | Force regeneration of the movie file. |
| `--dryRun` | Perform a dry run without generating any files. |
| `-p, --presentationStyle <style>` | The presentation style to use. |
| `-a, --audiodir <dir>` | The directory containing the audio files. |
| `-i, --imagedir <dir>` | The directory containing the image files. |
| `-c, --caption <lang>` | Add video captions in the specified language (e.g., `en`, `ja`). |

### `pdf <file>`

Generates a PDF file from a MulmoScript.

**Usage:**

```bash
mulmo pdf <file> [options]
```

**Arguments:**

| Argument | Description |
|---|---|
| `file` | The path to the MulmoScript file. |

**Options:**

| Option | Description |
|---|---|
| `-o, --outdir <dir>` | The output directory for the PDF file. |
| `-b, --basedir <dir>` | The base directory for resolving relative paths. |
| `-l, --lang <lang>` | The target language for the PDF (e.g., `en`, `ja`). |
| `-f, --force` | Force regeneration of the PDF file. |
| `--dryRun` | Perform a dry run without generating any files. |
| `-p, --presentationStyle <style>` | The presentation style to use. |
| `-i, --imagedir <dir>` | The directory containing the image files. |
| `--pdf_mode <mode>` | The PDF mode to use (`slide`, `talk`, `handout`). |
| `--pdf_size <size>` | The PDF paper size (`letter`, `a4`). |

### `tool scripting`

Generates a MulmoScript from a URL, markdown file, or interactive prompts.

**Usage:**

```bash
mulmo tool scripting [options]
```

**Options:**

| Option | Description |
|---|---|
| `-o, --outdir <dir>` | The output directory for the script file. |
| `-b, --basedir <dir>` | The base directory for resolving relative paths. |
| `-u, --url <url>` | The URL to reference for script generation. |
| `-i, --interactive` | Generate the script in interactive mode. |
| `-t, --template <template>` | The template to use for script generation. |
| `-c, --cache <dir>` | The cache directory to use. |
| `-s, --script <filename>` | The name of the script file. |
| `--llm <llm>` | The LLM to use for script generation. |
| `--llm_model <model>` | The LLM model to use for script generation. |

**Converting a Markdown Story to a MulmoScript:**

To convert a markdown file to a MulmoScript, use the `tool scripting` command with the markdown file as the last argument. The `--template` argument is required.

**Usage:**

```bash
mulmo tool scripting --template <template> <your_story>.md
```

**Example:**

```bash
mulmo tool scripting --template business story.md
```

This will create a `story.json` file in the same directory.

### `tool prompt`

Dumps a prompt from a template.

**Usage:**

```bash
mulmo tool prompt [options]
```

**Options:**

| Option | Description |
|---|---|
| `-t, --template <template>` | The template to use for dumping the prompt. |

### `tool schema`

Dumps the MulmoCast schema.

**Usage:**

```bash
mulmo tool schema
```

## MulmoScript Format

MulmoScript is a JSON-based format for describing multi-modal content. It allows you to define speakers, text, images, and layout in a single script.

### Core Document Structure

| Property | Description |
|---|---|
| `$mulmocast` | Version metadata (required). |
| `beats` | An array of content segments (required). |
| `title` | The title of the presentation. |
| `description` | A description of the presentation. |
| `lang` | The language of the presentation (e.g., `en`, `ja`). |
| `references` | An array of reference objects. |
| `speechParams` | Parameters for text-to-speech generation. |
| `imageParams` | Parameters for image generation. |
| `movieParams` | Parameters for movie generation. |
| `audioParams` | Parameters for audio generation. |
| `canvasSize` | The size of the canvas for the presentation. |
| `textSlideParams` | Parameters for text slides. |

### Beat Object

A beat represents a segment of content in the presentation.

| Property | Description |
|---|---|
| `speaker` | The ID of the speaker. |
| `text` | The text to be spoken. |
| `id` | A unique identifier for the beat. |
| `description` | An internal note for the beat. |
| `duration` | The fixed duration of the beat in seconds. |
| `image` | The image asset for the beat. |
| `audio` | The audio asset for the beat. |
| `imageParams` | Beat-specific image parameters. |
| `audioParams` | Beat-specific audio parameters. |
| `speechOptions` | Beat-specific speech options. |
| `textSlideParams` | Beat-specific text slide parameters. |
| `imageNames` | An array of specific images to use. |
| `imagePrompt` | A custom prompt for image generation. |
| `moviePrompt` | A custom prompt for movie generation. |

### Image Asset Types

| Type | Description |
|---|---|
| `textSlide` | A slide with a title, subtitle, and bullet points. |
| `markdown` | A slide with markdown content. |
| `mermaid` | A slide with a Mermaid diagram. |
| `chart` | A slide with a Chart.js chart. |
| `image` | A slide with a static image. |
| `html_tailwind` | A slide with HTML and Tailwind CSS content. |
| `movie` | A slide with video content. |
| `beat` | A reference to another beat's visual. |

### Audio Asset Types

| Type | Description |
|---|---|
| `audio` | An audio file. |
| `midi` | MIDI content. |

## Usage Examples

### "Hello World"

Create a file named `hello.json` with the following content:

```json
{
  "$mulmocast": {
    "version": "1.0"
  },
  "beats": [
    { "text": "Hello World" }
  ]
}
```

Then, run the following commands:

```bash
mulmo audio hello.json
mulmo movie hello.json
```

### Ghibli-Style Animation

1.  **Generate a Ghibli-style MulmoScript:**

    ```bash
    mulmo tool scripting -i -t ghibli_strips -o ./ -s story
    ```

2.  **Translate the MulmoScript:**

    ```bash
    mulmo translate {generated_script_file}
    ```

3.  **Generate video with Japanese subtitles:**

    ```bash
    mulmo movie {generated_script_file} -c ja
