# ADR-006: YouTube IFrame API para Videos

## Status

Aceptado

## Context

Necesitamos integrar reproducción de videos de cursos. Opciones evaluadas:

- **YouTube IFrame API** (embebido)
- **Vimeo Embed**
- **Video hosting propio**
- **Mux** (video hosting service)
- **AWS CloudFront + S3**

## Decision

**Usar YouTube IFrame API con tracking de progreso**

## Reasons

| Razón | Detalle |
|-------|--------|
| **Gratis** | No hay costo por hosting de videos |
| **CDN global** | YouTube tiene infraestructura worldwide |
| **Sin bandwidth costs** | YouTube serve el video, no nuestro server |
| **API Established** | IFrame API bien documentada |
| **Thumbnails automatic** | HD thumbnails disponibles |

## Implementation

```javascript
// video_player_controller.js
export default class extends Controller {
  static values = { youtubeId: String, episodeId: Number }

  connect() {
    this.player = new YT.Player(this.element, {
      videoId: this.youtubeIdValue,
      events: {
        onStateChange: this.onPlayerStateChange.bind(this)
      }
    })
  }

  onPlayerStateChange(event) {
    if (event.data === YT.PlayerState.PLAYING) {
      this.startProgressTracking()
    }
  }
}
```

### Progress Tracking

- Timer each 15 seconds while playing
- PATCH `/video_progress` with seconds_watched
- Server marks completed when >= 90%

## Consequences

### Positive

- Zero hosting costs
- Global CDN with low latency
- Automatic quality adaptation
- Caption support

### Negative

- YouTube branding in player
- Cannot control ad-free experience (without YouTube Premium)
- External dependency (if YouTube is down, videos don't work)

### Risks

- YouTube could change API (mitigated: stable API)
- Videos may be blocked in some countries (rare)
- No offline viewing

## Alternatives Considered

| Alternativa | Razón de rechazo |
|-------------|------------------|
| Vimeo | No es gratis para todos los features |
| Mux | Costo mensual, overkill para MVP |
| AWS S3 + CloudFront | Costos de storage y bandwidth |

## Notes

- Extract YouTube ID from URL in `CourseEpisode.before_save`
- Support formats: `watch?v=`, `youtu.be/`, `/embed/`
- Store `duration_seconds` manually (YouTube API quota limits)

---

*Decisión tomada: 2024-05-10*
