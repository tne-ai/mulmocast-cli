# Decision Log

This file records architectural and implementation decisions using a list format.

**2025-06-14 21:27:00** - Initial decision log established during TNE1 analysis phase.

## Decision: GraphAI Framework for AI Orchestration

**Date:** 2025-06-14 21:27:00  
**Context:** Core AI agent coordination system  

### Rationale
- **Provider Abstraction:** GraphAI provides unified interface across OpenAI, Google, Anthropic, Groq
- **Agent-Based Architecture:** Modular design allows independent TTS, image, and video agents
- **Async Workflow:** Handles complex multi-step AI generation pipelines efficiently
- **Established Framework:** Version 2.0.5 with mature ecosystem of agents

### Implementation Details
- All AI interactions flow through GraphAI agent system
- Individual agents for each provider type (tts_openai_agent, image_google_agent, etc.)
- Centralized agent registration in [`src/agents/index.ts`](src/agents/index.ts:1)
- Configuration-driven provider selection via MulmoScript parameters

## Decision: Zod for Runtime Schema Validation

**Date:** 2025-06-14 21:27:00  
**Context:** MulmoScript validation and type safety

### Rationale
- **Runtime Safety:** Validates JSON inputs at runtime, not just compile time
- **Schema Evolution:** Easy to modify and extend MulmoScript format
- **Type Generation:** Automatic TypeScript type inference from schemas
- **Developer Experience:** Clear validation errors for malformed scripts

### Implementation Details
- 388-line comprehensive schema in [`src/types/schema.ts`](src/types/schema.ts:1)
- All MulmoScript inputs validated through [`mulmoScriptSchema`](src/types/schema.ts:297)
- Type exports in [`src/types/type.ts`](src/types/type.ts:1) for TypeScript integration
- Validation agent for error checking: [`validate_schema_agent.ts`](src/agents/validate_schema_agent.ts:8)

## Decision: CLI-First Architecture

**Date:** 2025-06-14 21:27:00  
**Context:** Primary user interface design

### Rationale
- **Developer Focus:** Target audience expects command-line automation
- **Scriptability:** Enables integration with CI/CD and automated workflows
- **AI Integration:** CLI interface works naturally with AI code generation
- **Cross-Platform:** Works consistently across macOS, Linux, Windows

### Implementation Details
- yargs-based CLI with comprehensive command structure
- Main entry point: [`src/cli/bin.ts`](src/cli/bin.ts:1)
- Subcommands: audio, images, movie, pdf, translate, tool
- Global installation via npm: `npm install -g mulmocast`

## Decision: Multi-Provider AI Strategy

**Date:** 2025-06-14 21:27:00  
**Context:** AI service integration approach

### Rationale
- **Redundancy:** Avoid single provider lock-in for critical functionality
- **Quality Options:** Different providers excel at different content types
- **Cost Optimization:** Allow users to choose cost-effective options
- **Regional Availability:** Providers have different geographic coverage

### Implementation Details
- **TTS Providers:** OpenAI, Google Cloud, ElevenLabs, Nijivoice
- **Image Providers:** OpenAI DALL-E, Google Imagen
- **Video Providers:** OpenAI, Google Cloud
- **LLM Providers:** OpenAI, Anthropic, Google Gemini, Groq
- Provider selection via MulmoScript configuration or environment variables

## Decision: JSON-Based Intermediate Language (MulmoScript)

**Date:** 2025-06-14 21:27:00  
**Context:** Content representation format

### Rationale
- **AI-Native:** JSON is natural output format for large language models
- **Structured Content:** Enables complex multi-modal content organization
- **Version Control:** Text-based format works with Git and standard tools
- **Extensibility:** Easy to add new media types and parameters
- **Human Readable:** Developers can edit and understand the format

### Implementation Details
- Core format defined by [`mulmoScriptSchema`](src/types/schema.ts:297)
- Supports 8+ media types: textSlide, chart, mermaid, markdown, html, image, movie, audio
- Template system for common use cases (business, education, creative)
- Validation and type safety through Zod schemas

## Decision: File-Based Caching Strategy

**Date:** 2025-06-14 21:27:00  
**Context:** Performance optimization for expensive AI operations

### Rationale
- **Cost Efficiency:** Avoid regenerating expensive AI content unnecessarily
- **Development Speed:** Faster iteration during script development
- **Reliability:** Simple file system approach with minimal dependencies
- **Transparency:** Users can inspect and manage cached content

### Implementation Details
- Smart caching in `output/` directory structure
- Audio fragments cached by text content hash
- Images cached by prompt and parameters
- Force regeneration via `-f` flag or manual file deletion
- Automatic cache invalidation when script content changes

---

**2025-06-14 21:27:00** - Documented core architectural decisions covering AI orchestration, validation, CLI design, provider strategy, content format, and caching approach.