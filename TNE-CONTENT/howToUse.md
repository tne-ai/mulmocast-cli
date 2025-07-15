# How to Use MulmoCast CLI - AI Teaching Guide

**Created:** 2025-06-14 21:20:30  
**Purpose:** Comprehensive guide for AIs to understand, install, and use MulmoCast CLI

## What is MulmoCast?

MulmoCast is an AI-native multi-modal presentation platform that transforms text into multiple content formats:
- **Videos** with narration and visuals
- **Podcasts** with natural speech
- **Slideshows** with interactive elements  
- **PDF documents** with professional layouts
- **Manga-style comics** with visual storytelling

**Key Innovation:** Uses **MulmoScript** (JSON/YAML format) as an intermediate language that AI models can easily generate and modify.

## Quick Installation Guide

### 1. Prerequisites Check
```bash
# Check system requirements
make status

# Required: Node.js 16+, FFmpeg, OPENAI_API_KEY
node --version    # Should be v16+ 
ffmpeg -version   # Should be installed
echo $OPENAI_API_KEY  # Should be set
```

### 2. Install Dependencies
```bash
# Install all dependencies and setup
make install

# This will:
# - Install Node.js dependencies via npm
# - Install FFmpeg via brew (macOS)
# - Build TypeScript to JavaScript
# - Show environment variable requirements
```

### 3. Environment Configuration
Create a `.env` file with required API keys:

```bash
# Required
OPENAI_API_KEY=sk-your-openai-key-here

# Optional but recommended
DEFAULT_OPENAI_IMAGE_MODEL=gpt-image-1
GOOGLE_PROJECT_ID=your-google-project-id
ELEVENLABS_API_KEY=your-elevenlabs-key
NIJIVOICE_API_KEY=your-nijivoice-key
BROWSERLESS_API_TOKEN=your-browserless-token
```

**Alternative:** Use environment variables with 1Password CLI:
```bash
# Create .envrc file for direnv
echo 'export OPENAI_API_KEY="$(op read op://vault/openai/api-key)"' > .envrc
direnv allow
```

## Basic Usage Workflow

### Step 1: Generate a MulmoScript

**Interactive Script Generation:**
```bash
# Generate script interactively with AI assistance
make run-example-script
# OR
mulmo tool scripting -i -t children_book -o ./ -s story
```

**From URL Content:**
```bash
# Extract content from webpage and create script
mulmo tool scripting -u https://example.com/article
```

**Available Templates:**
- `business` - Professional presentations
- `children_book` - Story-driven content
- `coding` - Technical tutorials
- `ghibli_strips` - Anime-style visuals
- `podcast_standard` - Audio-focused content
- `comic_strips` - Manga-style layout

### Step 2: Generate Multi-Modal Content

**Create Complete Video:**
```bash
# Generate audio + images + combine into video
make run-example-movie
# OR
mulmo movie your-script.json
```

**Generate Individual Components:**
```bash
# Audio only
mulmo audio your-script.json

# Images only  
mulmo images your-script.json

# PDF document
mulmo pdf your-script.json

# Translate to Japanese
mulmo translate your-script.json -l ja
```

## Complete MulmoScript Reference

### Core Document Structure

**Required Root Properties:**
- `$mulmocast` - Version metadata (required)
- `beats` - Array of content segments (required, min 1)

**Optional Root Properties:**
- `title`, `description`, `lang`, `references`
- `speechParams`, `imageParams`, `movieParams`, `audioParams`
- `canvasSize`, `textSlideParams`

### Full Syntax Example
```json
{
  "$mulmocast": {
    "version": "1.0",
    "credit": "closing"
  },
  "title": "Complete MulmoScript Example",
  "description": "Demonstrates all available features",
  "lang": "en",
  "references": [
    {
      "url": "https://example.com/source",
      "title": "Source Article",
      "description": "Reference material",
      "type": "article"
    }
  ],
  "canvasSize": {
    "width": 1920,
    "height": 1080
  },
  "speechParams": {
    "provider": "openai",
    "speakers": {
      "Presenter": {
        "voiceId": "shimmer",
        "displayName": { "en": "Presenter", "ja": "発表者" },
        "provider": "openai",
        "speechOptions": {
          "speed": 1.0,
          "instruction": "Speak clearly and professionally"
        }
      },
      "Narrator": {
        "voiceId": "nova",
        "displayName": { "en": "Narrator" }
      }
    }
  },
  "imageParams": {
    "provider": "openai",
    "model": "gpt-image-1",
    "style": "professional business presentation style",
    "moderation": "strict",
    "images": {
      "logo": {
        "type": "image",
        "source": { "kind": "path", "path": "./assets/logo.png" }
      }
    }
  },
  "movieParams": {
    "provider": "google",
    "model": "imagen-video",
    "transition": {
      "type": "fade",
      "duration": 0.5
    }
  },
  "audioParams": {
    "padding": 0.3,
    "introPadding": 1.5,
    "closingPadding": 1.0,
    "outroPadding": 2.0,
    "bgm": {
      "kind": "path",
      "path": "./assets/background.mp3"
    }
  },
  "textSlideParams": {
    "cssStyles": [
      "body { font-family: 'Arial', sans-serif; }",
      "h1 { color: #2c3e50; }"
    ]
  },
  "beats": [
    // See beat examples below...
  ]
}
```

## Beat Object Reference

### Core Beat Properties
```json
{
  "speaker": "Presenter",              // Required: Speaker ID from speechParams
  "text": "Content to be spoken",        // Default: "" (empty = no audio)
  "id": "unique-beat-identifier",     // Optional: For referencing
  "description": "Internal note",     // Optional: Documentation
  "duration": 3.0,                    // Optional: Fixed duration (seconds)
  "image": { /* Image Asset */ },     // Optional: Visual content
  "audio": { /* Audio Asset */ },     // Optional: Custom audio
  "imageParams": { /* Override */ },  // Optional: Beat-specific image settings
  "audioParams": { /* Override */ },  // Optional: Beat-specific audio settings
  "speechOptions": { /* Override */ },// Optional: Beat-specific speech settings
  "textSlideParams": { /* Override */ }, // Optional: Beat-specific slide styling
  "imageNames": ["logo", "chart"],    // Optional: Specific images to use
  "imagePrompt": "Custom prompt",     // Optional: Override image generation
  "moviePrompt": "Custom prompt"      // Optional: Override movie generation
}
```

## Image Asset Types

### 1. Text Slides
```json
{
  "type": "textSlide",
  "slide": {
    "title": "Main Title",
    "subtitle": "Optional Subtitle",
    "bullets": [
      "First bullet point",
      "Second bullet point",
      "Third bullet point"
    ]
  }
}
```

### 2. Markdown Content
```json
{
  "type": "markdown",
  "markdown": [
    "# Main Heading",
    "## Subheading",
    "- Bullet point",
    "**Bold text** and *italic text*",
    "",
    "| Column 1 | Column 2 |",
    "|----------|----------|",
    "| Data 1   | Data 2   |"
  ]
}
```

### 3. Mermaid Diagrams
```json
{
  "type": "mermaid",
  "title": "Process Flow",
  "code": {
    "kind": "text",
    "text": "graph TD\n    A[Start] --> B{Decision}\n    B -->|Yes| C[Action 1]\n    B -->|No| D[Action 2]\n    C --> E[End]\n    D --> E"
  },
  "appendix": [
    "%%{init: {'theme':'neutral'}}%%",
    "classDef default fill:#f9f9f9,stroke:#333,stroke-width:2px"
  ]
}
```

### 4. Charts (Chart.js)
```json
{
  "type": "chart",
  "title": "Sales Performance",
  "chartData": {
    "type": "bar",
    "data": {
      "labels": ["Q1", "Q2", "Q3", "Q4"],
      "datasets": [{
        "label": "Revenue ($M)",
        "data": [12, 19, 3, 5],
        "backgroundColor": "rgba(54, 162, 235, 0.5)",
        "borderColor": "rgba(54, 162, 235, 1)",
        "borderWidth": 1
      }]
    },
    "options": {
      "scales": {
        "y": {
          "beginAtZero": true,
          "title": { "display": true, "text": "Revenue" }
        }
      }
    }
  }
}
```

### 5. Static Images
```json
{
  "type": "image",
  "source": {
    "kind": "url",           // url, base64, text, path
    "url": "https://example.com/image.jpg"
  }
}
```

### 6. HTML with Tailwind
```json
{
  "type": "html_tailwind",
  "html": [
    "<div class='bg-blue-500 text-white p-8 rounded-lg'>",
    "  <h1 class='text-4xl font-bold mb-4'>Custom Design</h1>",
    "  <p class='text-xl'>Built with Tailwind CSS</p>",
    "</div>"
  ]
}
```

### 7. Video Content
```json
{
  "type": "movie",
  "source": {
    "kind": "path",
    "path": "./videos/intro.mp4"
  },
  "mixAudio": 0.3  // Audio mixing level (0.0-1.0)
}
```

### 8. Beat References
```json
{
  "type": "beat",
  "id": "intro-slide"  // References another beat's visual
}
```

## Audio Asset Types

### 1. Audio Files
```json
{
  "type": "audio",
  "source": {
    "kind": "path",
    "path": "./audio/custom-sound.mp3"
  }
}
```

### 2. MIDI Content
```json
{
  "type": "midi",
  "source": "C4 E4 G4"  // MIDI notation
}
```

## Media Source Types

**URL Source:**
```json
{ "kind": "url", "url": "https://example.com/file.jpg" }
```

**File Path:**
```json
{ "kind": "path", "path": "./assets/image.png" }
```

**Base64 Data:**
```json
{ "kind": "base64", "data": "iVBORw0KGgoAAAANSUhEUgA..." }
```

**Text Content:**
```json
{ "kind": "text", "text": "Plain text content or code" }
```

## Provider-Specific Options

### TTS Providers & Voice IDs

**OpenAI TTS:**
```json
{
  "provider": "openai",
  "voiceId": "alloy" | "echo" | "fable" | "onyx" | "nova" | "shimmer"
}
```

**Google TTS:**
```json
{
  "provider": "google",
  "voiceId": "en-US-Wavenet-D"  // See Google Cloud TTS docs
}
```

**ElevenLabs:**
```json
{
  "provider": "elevenlabs",
  "voiceId": "21m00Tcm4TlvDq8ikWAM"  // Your ElevenLabs voice ID
}
```

**Nijivoice:**
```json
{
  "provider": "nijivoice",
  "voiceId": "afd7df65-0fdc-4d31-ae8b-a29f0f5eed62"  // Nijivoice ID
}
```

### Image Generation Providers

**OpenAI DALL-E:**
```json
{
  "provider": "openai",
  "model": "gpt-image-1",     // Advanced model (requires verification)
  "style": "photographic style, high contrast"
}
```

**Google Imagen:**
```json
{
  "provider": "google",
  "model": "imagen-2",
  "style": "anime art style, Studio Ghibli inspired"
}
```

## Complete Beat Examples

### 1. Title Slide with Custom Styling
```json
{
  "speaker": "Presenter",
  "text": "Welcome to our quarterly business review",
  "image": {
    "type": "textSlide",
    "slide": {
      "title": "Q4 Business Review",
      "subtitle": "Performance & Strategic Outlook"
    }
  },
  "textSlideParams": {
    "cssStyles": [
      "body { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); }",
      "h1 { color: white; font-size: 72px; }",
      "h2 { color: #f0f0f0; font-style: italic; }"
    ]
  },
  "speechOptions": {
    "speed": 0.9,
    "instruction": "Speak with enthusiasm and confidence"
  }
}
```

### 2. Data Visualization Beat
```json
{
  "id": "revenue-chart",
  "speaker": "Analyst",
  "text": "Our revenue grew consistently across all quarters, with Q4 showing exceptional performance due to our new product launch.",
  "image": {
    "type": "chart",
    "title": "2024 Revenue Growth",
    "chartData": {
      "type": "line",
      "data": {
        "labels": ["Q1", "Q2", "Q3", "Q4"],
        "datasets": [{
          "label": "Revenue ($M)",
          "data": [45, 52, 48, 67],
          "borderColor": "rgb(75, 192, 192)",
          "backgroundColor": "rgba(75, 192, 192, 0.2)",
          "tension": 0.4
        }]
      },
      "options": {
        "responsive": true,
        "plugins": {
          "title": { "display": true, "text": "Quarterly Revenue" }
        }
      }
    }
  },
  "duration": 8.0
}
```

### 3. Technical Architecture
```json
{
  "speaker": "TechLead",
  "text": "Our new microservices architecture improves scalability and maintainability through clear separation of concerns.",
  "image": {
    "type": "mermaid",
    "title": "Microservices Architecture",
    "code": {
      "kind": "text",
      "text": "graph TB\n    subgraph \"Frontend\"\n        UI[React App]\n    end\n    subgraph \"API Gateway\"\n        GW[Kong Gateway]\n    end\n    subgraph \"Services\"\n        AUTH[Auth Service]\n        USER[User Service]\n        ORDER[Order Service]\n        PAY[Payment Service]\n    end\n    subgraph \"Data\"\n        DB1[(User DB)]\n        DB2[(Order DB)]\n        CACHE[Redis Cache]\n    end\n    UI --> GW\n    GW --> AUTH\n    GW --> USER\n    GW --> ORDER\n    GW --> PAY\n    USER --> DB1\n    ORDER --> DB2\n    AUTH --> CACHE"
    },
    "appendix": [
      "classDef service fill:#e1f5fe,stroke:#01579b,stroke-width:2px",
      "classDef database fill:#f3e5f5,stroke:#4a148c,stroke-width:2px",
      "class AUTH,USER,ORDER,PAY service",
      "class DB1,DB2,CACHE database"
    ]
  },
  "imagePrompt": "Clean technical diagram, modern software architecture"
}
```

### 4. Multi-Media Beat with Custom Audio
```json
{
  "speaker": "Presenter",
  "text": "Let me show you our product demo",
  "image": {
    "type": "movie",
    "source": {
      "kind": "path",
      "path": "./videos/product-demo.mp4"
    },
    "mixAudio": 0.7
  },
  "audio": {
    "type": "audio",
    "source": {
      "kind": "path",
      "path": "./audio/product-intro.mp3"
    }
  },
  "audioParams": {
    "padding": 1.0
  }
}
```

### 5. Interactive Content Beat
```json
{
  "speaker": "Presenter",
  "text": "Here's our interactive dashboard showing real-time metrics",
  "image": {
    "type": "html_tailwind",
    "html": [
      "<div class='min-h-screen bg-gray-100 p-8'>",
      "  <div class='max-w-6xl mx-auto'>",
      "    <h1 class='text-4xl font-bold text-gray-800 mb-8'>Analytics Dashboard</h1>",
      "    <div class='grid grid-cols-1 md:grid-cols-3 gap-6'>",
      "      <div class='bg-white rounded-lg shadow-lg p-6'>",
      "        <h3 class='text-lg font-semibold text-gray-700'>Active Users</h3>",
      "        <p class='text-3xl font-bold text-blue-600'>12,847</p>",
      "        <p class='text-sm text-green-600'>↑ 12% from last week</p>",
      "      </div>",
      "      <div class='bg-white rounded-lg shadow-lg p-6'>",
      "        <h3 class='text-lg font-semibold text-gray-700'>Revenue</h3>",
      "        <p class='text-3xl font-bold text-green-600'>$45,231</p>",
      "        <p class='text-sm text-green-600'>↑ 8% from last week</p>",
      "      </div>",
      "      <div class='bg-white rounded-lg shadow-lg p-6'>",
      "        <h3 class='text-lg font-semibold text-gray-700'>Conversion</h3>",
      "        <p class='text-3xl font-bold text-purple-600'>3.2%</p>",
      "        <p class='text-sm text-red-600'>↓ 2% from last week</p>",
      "      </div>",
      "    </div>",
      "  </div>",
      "</div>"
    ]
  }
}
```

### 6. Markdown Documentation Beat
```json
{
  "speaker": "Developer",
  "text": "Our API documentation follows RESTful conventions with clear endpoint descriptions",
  "image": {
    "type": "markdown",
    "markdown": [
      "# API Documentation",
      "",
      "## Authentication",
      "",
      "All API requests require authentication via API key:",
      "",
      "```bash",
      "curl -H \"Authorization: Bearer YOUR_API_KEY\" \\",
      "     https://api.example.com/users",
      "```",
      "",
      "## Endpoints",
      "",
      "| Method | Endpoint | Description |",
      "|--------|----------|-------------|",
      "| GET    | `/users` | List all users |",
      "| POST   | `/users` | Create new user |",
      "| GET    | `/users/{id}` | Get user by ID |",
      "| PUT    | `/users/{id}` | Update user |",
      "| DELETE | `/users/{id}` | Delete user |",
      "",
      "## Response Format",
      "",
      "```json",
      "{",
      "  \"status\": \"success\",",
      "  \"data\": { ... },",
      "  \"meta\": {",
      "    \"timestamp\": \"2024-01-15T10:30:00Z\"",
      "  }",
      "}",
      "```"
    ]
  }
}
```

## Development Commands

### Available Make Commands
```bash
make help              # Show all available commands
make install           # Install dependencies and setup
make dev              # Development mode with watch
make build            # Build TypeScript to JavaScript
make test             # Run test suite
make lint             # Check code style
make format           # Format code
make clean            # Clean build artifacts
make install-global   # Install CLI globally
make status           # Check system configuration
```

### Development Mode
```bash
# Start development server with hot reload
make dev

# Run specific commands in development
npx tsx src/cli/bin.ts --help
npx tsx src/cli/bin.ts tool scripting -i
```

## Common Workflow Patterns

### 1. Business Presentation Flow
```bash
# Generate business presentation
mulmo tool scripting -i -t business -o ./output -s quarterly-report

# Create video with English narration
mulmo movie ./output/quarterly-report-*.json

# Generate PDF for distribution
mulmo pdf ./output/quarterly-report-*.json
```

### 2. Educational Content Flow  
```bash
# Create coding tutorial
mulmo tool scripting -i -t coding -o ./tutorials -s python-basics

# Generate with subtitles
mulmo movie ./tutorials/python-basics-*.json -c en

# Create handout PDF
mulmo pdf ./tutorials/python-basics-*.json --pdf_mode handout
```

### 3. Multi-Language Content
```bash
# Create base content
mulmo tool scripting -i -t children_book -o ./ -s story

# Translate to Japanese
mulmo translate ./story-*.json -l ja

# Generate Japanese video with subtitles
mulmo movie ./story-*.json -c ja
```

## File Organization

### Input/Output Structure
```
project/
├── your-script.json           # Source MulmoScript
├── output/                    # Generated content
│   ├── audio/                # Audio fragments (.mp3)
│   ├── images/               # Generated images (.png)
│   ├── cache/                # Processing cache
│   ├── your-script.mp4       # Final video
│   ├── your-script.mp3       # Audio podcast
│   └── your-script.pdf       # PDF document
└── .env                      # API configuration
```

### Caching and Re-runs
- **Smart Caching:** Previously generated audio/images are reused
- **Force Regeneration:** Use `-f` flag or delete output files
- **Text Changes:** Auto-detected, audio regenerated automatically

## Troubleshooting Guide

### Common Issues

**1. Missing API Keys**
```bash
# Check configuration
make status

# Set missing keys in .env or environment
export OPENAI_API_KEY="your-key-here"
```

**2. FFmpeg Not Found**
```bash
# Install FFmpeg
brew install ffmpeg  # macOS
# OR visit https://ffmpeg.org/download.html
```

**3. Build Errors**
```bash
# Clean and rebuild
make clean
make build
```

**4. Permission Issues**
```bash
# Fix global installation
sudo npm install -g .
# OR use local installation
npx mulmo --help
```

### Advanced Configuration

**Custom Voice Settings:**
```json
{
  "speechParams": {
    "speakers": {
      "Narrator": {
        "voiceId": "nova",
        "provider": "openai",
        "speechOptions": {
          "speed": 0.9,
          "instruction": "Speak in a calm, educational tone"
        }
      }
    }
  }
}
```

**Custom Image Styles:**
```json
{
  "imageParams": {
    "provider": "openai",
    "model": "gpt-image-1",
    "style": "minimalist corporate presentation style"
  }
}
```

## Integration Examples

### Programmatic Usage
```javascript
import { generateAudio, generateImages, generateMovie } from 'mulmocast';

// Load MulmoScript
const script = JSON.parse(fs.readFileSync('script.json', 'utf8'));

// Generate components
await generateAudio(script, { outDir: './output' });
await generateImages(script, { outDir: './output' });
await generateMovie(script, { outDir: './output' });
```

### API Integration
```bash
# Generate script from API data
curl -X POST api.example.com/data | \
  mulmo tool scripting -u - -t business -o ./api-presentations
```

## Testing Your Installation

### Quick Verification
```bash
# 1. Check system status
make status

# 2. Generate hello world
echo '{
  "$mulmocast": {"version": "1.0"},
  "beats": [{"text": "Hello, World!"}]
}' > hello.json

# 3. Create audio
mulmo audio hello.json

# 4. Create video  
mulmo movie hello.json

# 5. Check outputs
ls -la output/
```

### Expected Results
- `output/audio/` contains .mp3 files
- `output/images/` contains .png files
- `hello.mp4` video file created
- No error messages in terminal

## Next Steps for AI Assistants

When using MulmoCast in AI workflows:

1. **Script Generation:** Use structured prompts to create valid MulmoScript JSON
2. **Template Selection:** Match templates to content types (business, educational, creative)
3. **Multi-Modal Thinking:** Consider how text, visuals, and audio work together
4. **Iterative Refinement:** Use caching to quickly test script modifications
5. **Output Optimization:** Choose appropriate formats for target audience

**Key Success Factors:**
- Valid JSON structure following MulmoScript schema
- Appropriate AI provider selection based on quality needs
- Logical beat progression for narrative flow
- Consistent speaker and style definitions

---

**Test Completion Checklist:**
- [ ] `make status` shows all green checkmarks
- [ ] `make run-example-script` completes successfully  
- [ ] `make run-example-movie` generates video output
- [ ] Generated files are accessible and playable
- [ ] No critical error messages in logs

**Ready for Production Use:** ✅