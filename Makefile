# Makefile for MulmoCast CLI
# Multi-Modal Presentation Tool

.PHONY: help install dev run clean build test lint format

## help: Show this help message
help:
	@echo "MulmoCast CLI - Available commands:"
	@sed -n 's/^##//p' $(MAKEFILE_LIST) | column -t -s ':' | sed -e 's/^/ /'

## install: Install all dependencies and setup development environment
install:
	@echo "Installing MulmoCast dependencies..."
	@echo "Note: Ensure you have Node.js 16+ installed"
	@echo "Installing system dependencies..."
	@command -v brew >/dev/null 2>&1 && brew install ffmpeg || echo "Please install ffmpeg manually: https://ffmpeg.org/download.html"
	@echo "Installing Node.js dependencies..."
	npm install
	@echo "Building TypeScript..."
	npm run build
	@echo ""
	@echo "📝 IMPORTANT: Create a .env file with required API keys:"
	@echo "   OPENAI_API_KEY=your_openai_api_key"
	@echo "   # Optional but recommended:"
	@echo "   DEFAULT_OPENAI_IMAGE_MODEL=gpt-image-1"
	@echo "   GOOGLE_PROJECT_ID=your_google_project_id"
	@echo "   ELEVENLABS_API_KEY=your_elevenlabs_api_key"
	@echo "   NIJIVOICE_API_KEY=your_nijivoice_api_key"
	@echo ""
	@echo "💡 Alternative: Use environment variables with 1Password CLI and direnv:"
	@echo "   Create .envrc file and use 'op run --env-file .env -- command'"
	@echo ""
	@echo "✅ Installation complete! Run 'make help' to see available commands"

## dev: Run development server with watch mode
dev:
	@echo "Starting MulmoCast in development mode..."
	npx tsx --watch src/cli/bin.ts

## run: Run the CLI tool (example usage)
run:
	@echo "MulmoCast CLI ready. Usage examples:"
	@echo "  make run-example-script    # Generate a sample script interactively"
	@echo "  make run-example-movie     # Create a movie from existing script"
	@echo "  npm run cli -- --help      # Show full CLI help"

## run-example-script: Generate an example script interactively
run-example-script:
	@echo "Generating an example MulmoScript..."
	npm run scripting -- -i -t children_book -o ./ -s example

## run-example-movie: Create a movie from the example script (requires existing script)
run-example-movie:
	@echo "Creating movie from example script..."
	@if [ -f example-*.json ]; then \
		npm run movie $$(ls example-*.json | head -1); \
	else \
		echo "❌ No example script found. Run 'make run-example-script' first."; \
	fi

## build: Build TypeScript to JavaScript
build:
	@echo "Building MulmoCast..."
	npm run build

## test: Run test suite
test:
	@echo "Running MulmoCast tests..."
	npm run ci_test

## lint: Run linter and check code style
lint:
	@echo "Linting code..."
	npm run lint

## format: Format code with Prettier
format:
	@echo "Formatting code..."
	npm run format

## clean: Clean build artifacts and temporary files
clean:
	@echo "Cleaning build artifacts..."
	rm -rf lib/
	rm -rf output/
	rm -rf node_modules/.cache/
	@echo "Clean complete"

## install-global: Install MulmoCast globally
install-global:
	@echo "Installing MulmoCast globally..."
	npm install -g .
	@echo "✅ MulmoCast installed globally. Use 'mulmo --help' anywhere"

## uninstall-global: Uninstall global MulmoCast
uninstall-global:
	@echo "Uninstalling global MulmoCast..."
	npm uninstall -g mulmocast

## status: Check system requirements and configuration
status:
	@echo "🔍 MulmoCast System Status:"
	@echo ""
	@echo "Node.js version:"
	@node --version
	@echo ""
	@echo "FFmpeg installation:"
	@command -v ffmpeg >/dev/null 2>&1 && ffmpeg -version | head -1 || echo "❌ FFmpeg not found"
	@echo ""
	@echo "Environment configuration:"
	@test -f .env && echo "✅ .env file exists" || echo "⚠️  .env file not found"
	@test -n "$$OPENAI_API_KEY" && echo "✅ OPENAI_API_KEY is set" || echo "⚠️  OPENAI_API_KEY not set"
	@echo ""
	@echo "Project build status:"
	@test -d lib && echo "✅ Project is built" || echo "⚠️  Project needs building (run 'make build')"