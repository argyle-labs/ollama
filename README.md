<p align="center">
  <img src="assets/icon-256.png" width="120" alt="ollama" />
</p>

# ollama

Ollama runs large language models locally behind an OpenAI-compatible API.

A first-party [orca](https://github.com/argyle-labs/orca) plugin (service-backend).

This repo is **self-contained** — the steps below run ollama **by hand, without orca**. orca automates exactly this (same image, ports, and data) through one generic surface.

---

## Run it without orca

### Docker Compose

```yaml
# compose.yml
services:
  ollama:
    image: ollama/ollama:latest
    container_name: ollama
    restart: unless-stopped
    ports:
      - "11434:11434/tcp"   # API
    volumes:
      - ./ollama:/root/.ollama   # models
```

```sh
docker compose up -d
```

### Other runtimes

**Podman** — the compose above works with `podman compose up -d`, or run it directly:

```sh
podman run -d --name ollama --restart unless-stopped \
    -p 11434:11434/tcp \
    -v ./ollama:/root/.ollama \
    ollama/ollama:latest
```

**LXC** — on a container-capable LXC (e.g. a Proxmox LXC with nesting enabled) run the same image via Docker/Podman as above, or install ollama from upstream directly on the guest: <https://ollama.com/>.

**VM** — install ollama from upstream (<https://ollama.com/>) or run the same container image inside the VM; expose port `11434`.

**Unraid** — add via *Community Applications*, or *Docker → Add Container* with image `ollama/ollama:latest`, port `11434`, and the volume paths above.

### Ports & data

| | |
|---|---|
| Default port | `11434` |
| Upstream | <https://ollama.com/> |


### Backup & restore

Back up the config/data volume(s) above — that's the whole service state (stop the container first for a clean copy). Restore by putting them back and starting it.

> With orca this is **`service.backup` / `service.restore`** — location-agnostic (docker / podman / lxc / vm), one command regardless of where ollama runs. No per-service backup script.

## With orca

orca drives this plugin through the single generic `service.*` surface — no per-plugin tools:

```sh
orca service.deploy ollama      # render + launch on any supported runtime
orca service.status ollama      # health + rich diagnostics (typed payload)
orca service.backup ollama      # location-agnostic backup (tar; PBS on Proxmox)
orca service.configure ollama   # apply config via the upstream API
```

## Layout

- `src/` — the plugin (pure Rust): the `ServiceBackend` descriptor + `configure` / `status`.
- [CAPABILITIES.md](CAPABILITIES.md) — the service-backend contract checklist.
- `assets/` — plugin icon.
