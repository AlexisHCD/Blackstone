# ADR-005: Hotwire (Turbo + Stimulus) para Interactividad

## Status

Aceptado

## Context

Necesitamos agregar interactividad al frontend sin usar un framework JavaScript completo. Opciones evaluadas:

- **Hotwire (Turbo + Stimulus)** - El nuevo default de Rails
- **React** con ViewComponent
- **Vue.js** inline
- **Vanilla JavaScript**
- **jQuery** (legacy)

## Decision

**Usar Hotwire (Turbo + Stimulus)**

## Components

### Turbo

| Feature | Uso |
|---------|-----|
| **Page caching** | Navigate without full reloads |
| **Frames** | Update specific parts of page |
| **Streams** | Real-time updates via WebSockets |
| **Drive** | History management |

### Stimulus

| Controller | Uso |
|------------|-----|
| `video_player_controller` | YouTube player + progress tracking |
| `modal_controller` | Contact form modal |

## Reasons

| Razón | Detalle |
|-------|--------|
| **Rails magic** | Integración native, generators, conventions |
| **Minimal JavaScript** | 90% of interactivity with HTML over-the-wire |
| **Progressive enhancement** | Works without JS, enhanced with it |
| **Stimulus is elegant** | Lightweight, targets, actions, values pattern |
| **Performance** | Less JavaScript = faster page loads |

## Consequences

### Positive

- Fast page transitions without full reloads
- Less custom JavaScript code
- Server-rendered HTML is accessible by default
- Easy to debug (plain HTML network inspectable)

### Negative

- Requires understanding Turbo frames and streams
- Debugging can be tricky with caching
- Some edge cases require workarounds

### Risks

- Turbo streams require WebSocket setup for real-time (future)
- Need to handleTurbo.visit() for some SPA-like behaviors

## Alternatives Considered

| Alternativa | Razón de rechazo |
|-------------|------------------|
| React | Overkill, too much JavaScript |
| Vue | No native Rails integration |
| Vanilla JS | More code to write and maintain |

## Implementation Notes

- Turbo enabled by default in Rails 7
- Stimulus installed via `importmap-rails`
- Stimulus controllers: `app/javascript/controllers/`
- Use `data-turbo-frame` for partial updates

---

*Decisión tomada: 2024-05-10*
