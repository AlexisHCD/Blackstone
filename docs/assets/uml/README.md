# Diagramas UML - Blackstone

## Índice de Diagramas

### Estructurales
| Diagrama | Archivo | Descripción |
|----------|---------|-------------|
| **Casos de Uso** | `diagrama-casos-uso.md` | 23 casos de uso con 3 actores |
| **Clases** | `diagrama-clases.md` | Modelo de dominio completo con relaciones |
| **Componentes** | `diagrama-componentes.md` | Arquitectura de componentes del sistema |
| **Despliegue** | `diagrama-despliegue.md` | Infraestructura de producción |

### Comportamiento
| Diagrama | Archivo | Descripción |
|----------|---------|-------------|
| **Secuencia - Favoritos** | `diagrama-secuencia.md` | Flujo de agregar/quitar favoritos |
| **Secuencia - Video** | `diagrama-secuencia-video.md` | Tracking de progreso de video |
| **Actividades - Usuario** | `diagrama-actividades.md` | Flujo completo de usuario registrado |
| **Actividades - Admin** | `diagrama-actividades-admin.md` | Flujo del panel de administración |

### Narrativos
| Diagrama | Archivo | Descripción |
|----------|---------|-------------|
| **Casos Narrativos** | `diagrama-casos-narrativo.md` | 5 casos de uso con diagramas de secuencia |
| **Historia de Usuario** | `diagrama-casos-narrativo-simple.md` | Historia de Maria (estudiante típica) |

## Actores del Sistema

| Actor | Descripción |
|-------|-------------|
| **Usuario Anónimo** | Visitante sin cuenta - solo lectura |
| **Usuario Registrado** | Cuenta con email/password - favoritos, progreso, contacto |
| **Administrador** | Cuenta con admin=true - CRUD completo |

## Cómo renderizar los diagramas

Todos los diagramas están en formato **PlantUML**. Para visualizarlos:

1. **VS Code**: Instalar extensión "PlantUML"
2. **Online**: https://www.plantuml.com/plantuml/
3. **CLI**: `java -jar plantuml.jar diagrama.puml`
