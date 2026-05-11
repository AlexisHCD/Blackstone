# ADR-004: Dark Theme Premium con CSS Custom (Estilo Resend)

## Status

Aceptado

## Context

Necesitamos definir el sistema de diseño visual para Blackstone. Opciones evaluadas:

- **Tailwind CSS** + dark mode
- **Bootstrap** + dark theme
- **CSS Custom** (variables CSS nativas)
- **Radix UI / Headless UI** + custom CSS

## Decision

**Usar CSS Custom (variables CSS) con dark theme premium estilo Resend/Linear**

## Reasons

| Razón | Detalle |
|-------|--------|
| **Simplicidad** | No requiere build step adicional |
| **Rendimiento** | CSS nativo, no JavaScript para estilos |
| **Control total** | Diseño exactly como especificado |
| **Tokens centralizados** | Variables CSS para colores, tipografía, spacing |
| **Hotwire compatible** | Funciona perfectamente con Turbo |

## Design Tokens

### Colors

```css
:root {
  --color-void-black: #000000;
  --color-graphite-rail: #292d30;
  --color-smoke: #464a4d;
  --color-ash: #6c6c6c;
  --color-steel: #6e727a;
  --color-fog: #a1a4a5;
  --color-mist: #abafb4;
  --color-frost: #f0f0f0;
  --color-pure-white: #ffffff;
  --color-electric-blue: #3b9eff;
  --color-resend-violet: #9281f7;
  /* Status colors */
  --color-delivered-green: #3ad389;
  --color-bounced-red: #ff9592;
  --color-complained-yellow: #ffca16;
}
```

### Typography

| Font | Uso | Fallback |
|------|-----|----------|
| `Inter` | UI, body | system-ui |
| `DM Serif Display` | Headings | serif |
| `JetBrains Mono` | Code, badges | monospace |

### Spacing

Base unit: 4px

| Token | Value |
|-------|-------|
| `--spacing-4` | 4px |
| `--spacing-8` | 8px |
| `--spacing-16` | 16px |
| `--spacing-32` | 32px |

### Border Radius

| Element | Value |
|---------|-------|
| Buttons | 6px |
| Cards | 16px |
| Badges | 6px |
| Modals | 16px |

## Consequences

### Positive

- Zero dependencies for styling
- Dark theme by default (no toggle complexity)
- Consistency across all components
- Easy to maintain and modify
- Performance optimal

### Negative

- More manual CSS writing than utility-first frameworks
- No built-in responsive utilities
- Requires discipline to maintain consistency

### Risks

- Could become messy without strict conventions
- Need to document component classes

## Alternatives Considered

| Alternativa | Razón de rechazo |
|-------------|------------------|
| Tailwind | Over-engineering para proyecto de este tamaño |
| Bootstrap | Estilo genérico, difícil de customize |
| CSS-in-JS | Overkill, runtime overhead |

## Notes

- Design system documentado en `/docs/design.md`
- Assets: `/app/assets/stylesheets/application.css`
- Fonts via Google Fonts CDN

---

*Decisión tomada: 2024-05-10*
