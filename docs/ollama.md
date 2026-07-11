# Ollama

Local LLM inference server — runs open models with an OpenAI-compatible API.

**Status:** running — Docker on `<ip>:11434`

- **Host**: `<host>` (`<ip>`)
- **Port**: 11434
- **Public URL**: `ollama.<domain>` (fronted by a reverse proxy such as Caddy)

## Notes

Runs via Docker. Exposes the standard Ollama API on port 11434. Fronted by a reverse proxy (e.g. Caddy) for TLS at `ollama.<domain>`.
