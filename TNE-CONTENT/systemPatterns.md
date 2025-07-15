# System Patterns

This file documents recurring patterns and standards used in the MulmoCast project.
It is recommended to be updated as the project evolves.

**2025-06-14 21:28:00** - Initial system patterns documentation based on codebase analysis.

## Coding Patterns

### TypeScript Module Organization
**Pattern:** Layered module structure with clear separation of concerns
```
src/
├── cli/          # Command-line interface layer
├── actions/      # High-level business operations  
├── agents/       # AI provider integration layer
├── methods/      # Core business logic
├── utils/        # Shared utilities
└── types/        # Type definitions and schemas
```

**Implementation:**
- Each layer imports only from layers below it
- Clear module boundaries prevent circular dependencies
- [`src/index.ts`](src/index.ts:1) provides clean public API exports

### Zod Schema-First Development
**Pattern:** Runtime validation with compile-time type safety
```typescript
// Define schema first
export const mulmoScriptSchema = z.object({
  $mulmocast: mulmoCastCreditSchema,
  beats: z.array(mulmoBeatSchema).min(1)
});

// Extract TypeScript types
export type MulmoScript = z.infer<typeof mulmoScriptSchema>;
```

**Benefits:**
- Single source of truth for data structures
- Runtime validation prevents invalid inputs
- Automatic TypeScript type generation
- Self-documenting API contracts

### GraphAI Agent Pattern
**Pattern:** Uniform agent interface for AI providers
```typescript
// All AI agents follow consistent interface
export default {
  name: "providerSpecificAgent",
  agent: async (params, namedInputs, context) => {
    // Provider-specific implementation
    return result;
  }
};
```

**Implementation:**
- Consistent async agent signature across all providers
- Centralized agent registration in [`src/agents/index.ts`](src/agents/index.ts:1)
- Provider abstraction enables easy switching and testing

## Architectural Patterns

### Command Pattern for CLI Operations
**Pattern:** Each CLI command maps to a dedicated action module
```
CLI Command → Command Handler → Action Module → Agent(s)
     ↓              ↓              ↓            ↓
mulmo movie → movie/handler → movie.ts → [tts, image, ffmpeg]
```

**Implementation:**
- Clear separation between CLI parsing and business logic
- Reusable action modules for programmatic usage
- Consistent error handling and progress reporting

### Provider Strategy Pattern
**Pattern:** Interchangeable AI service providers
```typescript
interface Text2SpeechProvider {
  provider: "openai" | "google" | "elevenlabs" | "nijivoice";
  voiceId: string;
  speechOptions?: SpeechOptions;
}
```

**Benefits:**
- Easy provider switching without code changes
- A/B testing of different AI services
- Fallback mechanisms for service outages
- Cost optimization through provider selection

### Template Method Pattern
**Pattern:** Standardized content generation workflow
```
1. Script Validation (Zod)
2. Content Processing (Beat-by-beat)
3. AI Generation (Provider-specific)
4. Media Assembly (FFmpeg)
5. Output Generation (File system)
```

**Implementation:**
- Each action follows the same processing pipeline
- Hooks for customization at each step
- Caching optimizations throughout the workflow

### Configuration-over-Convention
**Pattern:** Explicit configuration for all AI parameters
```json
{
  "speechParams": {
    "provider": "openai",
    "speakers": { "Presenter": { "voiceId": "shimmer" } }
  },
  "imageParams": {
    "provider": "openai", 
    "style": "professional business style"
  }
}
```

**Benefits:**
- Predictable behavior across environments
- Easy customization for specific use cases
- Version control friendly (text-based configuration)
- AI models can generate valid configurations

## Testing Patterns

### Schema Validation Testing
**Pattern:** Comprehensive Zod schema testing
```typescript
// Test valid inputs
expect(mulmoScriptSchema.parse(validScript)).toBeDefined();

// Test invalid inputs with specific error messages
expect(() => mulmoScriptSchema.parse(invalidScript)).toThrow();
```

**Coverage:**
- All schema variations tested in [`test/agents/test_validate_schema_agent.ts`](test/agents/test_validate_schema_agent.ts:1)
- Edge cases for optional vs required fields
- Provider-specific parameter validation

### Integration Testing with Real Providers
**Pattern:** Environment-conditional real API testing
```typescript
if (process.env.OPENAI_API_KEY) {
  test('OpenAI TTS integration', async () => {
    // Test with real API
  });
} else {
  test.skip('OpenAI TTS - no API key');
}
```

**Benefits:**
- Validates real provider integrations
- Skips expensive tests in CI when API keys unavailable
- Catches provider API changes early

### File System Testing
**Pattern:** Isolated file system testing with cleanup
```typescript
beforeEach(() => {
  testDir = fs.mkdtempSync(path.join(os.tmpdir(), 'mulmo-test-'));
});

afterEach(() => {
  fs.rmSync(testDir, { recursive: true, force: true });
});
```

**Implementation:**
- Tests in [`test/utils/test_file_path.ts`](test/utils/test_file_path.ts:1)
- Isolated test environments prevent conflicts
- Automatic cleanup prevents test pollution

## Error Handling Patterns

### Graceful AI Provider Failures
**Pattern:** Fallback mechanisms for AI service failures
```typescript
try {
  return await primaryProvider.generate(prompt);
} catch (error) {
  logger.warn(`Primary provider failed: ${error.message}`);
  return await fallbackProvider.generate(prompt);
}
```

**Implementation:**
- Provider-specific error handling in agent layer
- User-friendly error messages for common failures
- Automatic retries with exponential backoff

### Progressive Enhancement
**Pattern:** Degrade gracefully when optional features fail
```typescript
// Core functionality always works
const audio = await generateAudio(script);

// Enhanced features fail gracefully  
try {
  const subtitles = await generateSubtitles(audio);
  return combineWithSubtitles(audio, subtitles);
} catch {
  return audio; // Return basic version
}
```

## Performance Patterns

### Intelligent Caching Strategy
**Pattern:** Multi-level caching with content-based invalidation
```
Level 1: Memory (session cache)
Level 2: File system (persistent cache)  
Level 3: Content hash (invalidation strategy)
```

**Implementation:**
- Audio cached by text content hash
- Images cached by prompt + parameters hash
- Smart invalidation when script content changes

### Parallel Processing Where Possible
**Pattern:** Concurrent AI operations when dependencies allow
```typescript
// Generate audio and images in parallel
const [audioPromise, imagePromise] = await Promise.allSettled([
  generateAudio(beat.text),
  generateImage(beat.image)
]);
```

**Benefits:**
- Reduced total processing time
- Better resource utilization
- Maintains deterministic output order

---

**2025-06-14 21:28:00** - Documented core coding patterns, architectural patterns, testing strategies, error handling, and performance optimizations used throughout the MulmoCast codebase.