# ADR-001: Usar Rails como Framework Principal

## Status

Aceptado

## Context

Necesitamos elegir un framework web para desarrollar Blackstone. Se evaluaron las siguientes opciones:

- **Rails** (Ruby)
- **Django** (Python)
- **Laravel** (PHP)
- **Next.js** (Node.js)

## Decision

**Usar Rails 7.1.3 como framework principal**
**Decision del Profesor**


## Reasons

| Razón | Detalle |
|-------|--------|
| **Productividad** | Rails genera CRUD completo con scaffolds, acelera desarrollo |
| **Hotwire** | Integración nativa con Turbo y Stimulus para interactividad sin JavaScript pesado |
| **Ecosistema** | Gemas maduras para auth (Devise), storage (Active Storage), PostgreSQL |
| **Convención sobre configuración** | Decisiones tomadas por el framework, menos deuda técnica |
| **Experiencia del equipo** | Conocimiento previo de Rails, curva de aprendizaje reducida |
| **ActiveRecord** | ORM potente con migraciones versionadas |

## Consequences

### Positive

- Desarrollo rápido de features CRUD
- Integración nativa con PostgreSQL
- Seguridad incluida (CSRF, SQL injection protection)
- Comunidad activa y documentación extensa

### Negative

- Runtime de Ruby más lento que Node.js
- Menor flexibilidad en arquitectura compared to Node.js
- Deployment requiere Puma + Ruby

### Risks

- Escalabilidad horizontal requiere más configuración
- Menor ecosistema de libraries vs Node.js

## Alternatives Considered

| Alternativa | Razón de rechazo |
|-------------|------------------|
| Django | Menos familiar con Python, menos suited para Hotwire |
| Laravel | PHP menos preferido para proyectos nuevos |
| Next.js | Requiere JavaScript/TypeScript full-stack, diferente paradigma |

---

*Decisión tomada: 2024-05-10*
