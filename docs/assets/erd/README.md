# Diagramas ERD - Blackstone

## Modelo de datos

El modelo de datos completo está documentado en:
- [Diccionario de Datos](../../diccionario-datos.md)

### Diagrama ERD

| Diagrama | Archivo | Descripción |
|----------|---------|-------------|
| **ERD Completo (PlantUML)** | [erd-blackstone.md](erd-blackstone.md) | Diagrama entidad-relación en PlantUML |
| **ERD Completo (DBML)** | [erd-blackstone.dbml](erd-blackstone.dbml) | Diagrama en DBML, renderizable en dbdiagram.io |

### Resumen de entidades

| Entidad | Descripción |
|---------|-------------|
| **User** | Usuarios del sistema |
| **Category** | Categorías de herramientas y cursos |
| **Tool** | Herramientas de desarrollo |
| **Course** | Cursos en video |
| **CourseEpisode** | Episodios individuales de cursos |
| **VideoProgress** | Progreso de visualización |
| **FavoriteTool** | Herramientas favoritas |
| **FavoriteCourse** | Cursos favoritos |
| **FeaturedItem** | Herramienta destacada del día |
| **ContactMessage** | Mensajes de contacto |

### Herramientas utilizadas

- **PostgreSQL** - Base de datos relacional
- **ActiveRecord** - ORM de Rails
- **PlantUML** - Generación de diagramas ERD
- **DBML** - Database Markup Language (dbdiagram.io)

## Cómo renderizar

Los diagramas `.puml` se renderizan con:
- [PlantUML Server](https://www.plantuml.com/plantuml/uml/)
- VS Code + PlantUML extension
- `plantuml` CLI: `plantuml docs/assets/erd/*.puml`

Los diagramas `.dbml` se renderizan con:
- [dbdiagram.io](https://dbdiagram.io) — pegar el código en el editor
- VS Code + DBML extension
