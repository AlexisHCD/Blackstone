# Diagramas ERD - Blackstone

## Modelo de datos

El modelo de datos completo está documentado en:
- [Diccionario de Datos](../../diccionario-datos.md)

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
- **DBML** - Documentación de esquema
