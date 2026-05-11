# Diagramas BPMN - Blackstone

## Procesos modelados

| Proceso | Archivo | Descripción |
|---------|---------|-------------|
| **Autenticación y Registro** | [bpmn-autenticacion-usuario.md](bpmn-autenticacion-usuario.md) | Flujo completo de login, registro email/password y OAuth (Google/Microsoft) |
| **Progreso de Video** | [bpmn-progreso-video.md](bpmn-progreso-video.md) | Seguimiento de reproducción con auto-guardado cada 15s y marcado de completado al 90% |
| **Herramientas y Favoritos** | [bpmn-herramientas-favoritos.md](bpmn-herramientas-favoritos.md) | Exploración, filtrado y gestión de favoritos de herramientas |

## Herramientas utilizadas

- **PlantUML** - Diagramas de actividad estilo BPMN
- **Draw.io** - Alternativa para diagramas BPMN nativos

## Cómo renderizar

Los diagramas en formato `.puml` se pueden renderizar con:
- [PlantUML Server](https://www.plantuml.com/plantuml/uml/)
- VS Code + PlantUML extension
- `plantuml` CLI: `plantuml docs/assets/bpmn/*.puml`
