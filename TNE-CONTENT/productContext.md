# Product Context

This file provides a high-level overview of the MulmoCast project and the expected product that will be created. Initially it is based upon the README.md and all other available project-related information in the working directory. This file is intended to be updated as the project evolves, and should be used to inform all other modes of the project's goals and context.

**2025-06-14 21:26:00** - Initial product context analysis completed based on comprehensive codebase review.

## Project Goal

**MulmoCast** is a next-generation, AI-native multi-modal presentation platform that transforms text-based content into multiple output formats including videos, podcasts, slideshows, PDFs, and manga-style comics. The platform is specifically designed for the AI era, using **MulmoScript** (JSON/YAML) as an intermediate language that large language models can easily generate and manipulate.

## Key Features

### Core Capabilities
- **Multi-Modal Output Generation:** Single input → Video, Audio, PDF, Slideshow, Comics
- **AI-Native Design:** Purpose-built for LLM integration with JSON-based scripting
- **MulmoScript Language:** Structured intermediate format for AI content generation
- **CLI-First Architecture:** Developer-friendly command-line interface
- **Template System:** Pre-built templates for business, education, storytelling

### AI Provider Integrations
- **Text-to-Speech:** OpenAI, Google Cloud, ElevenLabs, Nijivoice
- **Image Generation:** OpenAI DALL-E, Google Imagen
- **Video Generation:** OpenAI, Google Cloud
- **LLM Integration:** ChatGPT, Claude, Gemini, Groq

### Content Types Supported
- **Text Slides:** Professional presentation layouts
- **Charts & Graphs:** Chart.js integration for data visualization
- **Mermaid Diagrams:** Technical architecture and flow diagrams
- **Markdown Content:** Rich text with formatting
- **HTML/Tailwind:** Custom styled interactive content
- **Video Content:** Movie generation and integration

## Overall Architecture

### Technical Stack
- **Language:** TypeScript/Node.js (ES2021, NodeNext modules)
- **CLI Framework:** yargs for command-line interface
- **AI Orchestration:** GraphAI framework for agent coordination
- **Schema Validation:** Zod for runtime type checking
- **Media Processing:** FFmpeg for video/audio manipulation
- **Package Management:** npm with global CLI installation

### System Architecture
```
User Input → MulmoScript Generation → Multi-Modal Processing → Output Files
     ↓              ↓                        ↓                    ↓
  Templates    JSON/YAML Schema      GraphAI Agents         MP4/MP3/PDF
  Interactive   Zod Validation      AI Providers           Images/Comics
  Web Content   Type Safety         Media Processing       Translations
```

### Key Architectural Decisions
- **JSON-First:** MulmoScript as the universal intermediate format
- **Agent-Based:** GraphAI framework for modular AI provider integration
- **CLI-Native:** Command-line first, enabling automation and scripting
- **Provider-Agnostic:** Support multiple AI services with unified interface
- **Caching Strategy:** Intelligent file-based caching for expensive operations

---

**2025-06-14 21:26:00** - Established foundational product context covering goals, features, and architecture for AI-native multi-modal presentation platform.