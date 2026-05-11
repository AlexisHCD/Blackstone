# Blackstone

> Directorio de herramientas de desarrollo y cursos para estudiantes de programación.

[![Rails](https://img.shields.io/badge/Rails-7.1.3-CC0000?style=flat-square&logo=ruby-on-rails)](https://rubyonrails.org)
[![Ruby](https://img.shields.io/badge/Ruby-3.3.0-701516?style=flat-square&logo=ruby)](https://www.ruby-lang.org)
[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-14-336791?style=flat-square&logo=postgresql)](https://www.postgresql.org)
[![Hotwire](https://img.shields.io/badge/Hotwire-Turbo-FF6B35?style=flat-square)](https://hotwire.dev)

## Quick Start

```bash
# Clonar y entrar al directorio
cd blackstone

# Instalar dependencias
bundle install

# Configurar base de datos
cp config/database.yml.example config/database.yml  # Editar credenciales
rails db:create db:migrate

# Iniciar servidor
rails server
```

Visita [http://localhost:3000](http://localhost:3000)

## Características

- **Directorio de herramientas** categorizadas (Desarrollo, Ciberseguridad, Redes, IA, DevOps)
- **Catálogo de cursos** en video con tracking de progreso
- **Sistema de favoritos** para herramientas y cursos
- **Progreso de video** con auto-save cada 15s y marca de completado al 90%
- **Herramienta destacada del día** (seleccionada automáticamente)
- **Panel de administración** completo
- **Dark theme premium** inspirado en Resend/Linear

## Tech Stack

| Componente | Tecnología |
|------------|------------|
| Framework | Rails 7.1.3 |
| Lenguaje | Ruby 3.3.0 |
| Base de datos | PostgreSQL 14+ |
| Frontend | Hotwire (Turbo + Stimulus) |
| Autenticación | Devise + OmniAuth |
| OAuth | Google (activo), Microsoft (pendiente) |
| Storage | Active Storage |
| Video | YouTube IFrame API |

## Documentation

Toda la documentación técnica está en [/docs/](./docs/)

| Documento | Descripción |
|-----------|-------------|
| [documentacion-general.md](./docs/documentacion-general.md) | Índice principal - visión completa del proyecto |
| [requerimientos.md](./docs/requerimientos.md) | Requerimientos funcionales y no funcionales |
| [diccionario-datos.md](./docs/diccionario-datos.md) | Modelo de datos, tablas, relaciones |
| [arquitectura.md](./docs/arquitectura.md) | Arquitectura del sistema, tech stack |
| [auth.md](./docs/auth.md) | Sistema de autenticación con Devise |
| [api.md](./docs/api.md) | Endpoints y documentación de la API |
| [design.md](./docs/design.md) | Sistema de diseño visual (tokens, colores, tipografía) |
| [metodologia.md](./docs/metodologia.md) | Metodología de desarrollo |
| [sprint-planning.md](./docs/sprint-planning.md) | Planificación de sprints |
| [descripcion-lenguajes.md](./docs/descripcion-lenguajes.md) | Descripción de lenguajes y tecnologías |
| [/docs/decisions/](./docs/decisions/) | Decisiones técnicas (ADRs) |

## Diagramas y Modelado

La documentación visual y de análisis del sistema se encuentra en `/docs/assets`.

Incluye:

- Diagramas BPMN de procesos actuales y propuestos
- Diagramas de casos de uso
- Diagramas de secuencia
- Diagramas de clases
- Diagramas de componentes
- Diagramas de despliegue
- Diagramas entidad-relación (DER)
- Arquitectura MVC del sistema
- Flujos de autenticación
- Wireframes y mockups UI

### Estructura de assets

```
docs/assets/
├── uml/              # Diagramas UML (PlantUML)
│   ├── diagrama-casos-uso.md
│   ├── diagrama-clases.md
│   ├── diagrama-componentes.md
│   ├── diagrama-despliegue.md
│   ├── diagrama-secuencia.md
│   ├── diagrama-secuencia-video.md
│   ├── diagrama-actividades.md
│   ├── diagrama-actividades-admin.md
│   ├── diagrama-casos-narrativo.md
│   └── diagrama-casos-narrativo-simple.md
├── bpmn/             # Diagramas de procesos de negocio
├── erd/              # Diagramas entidad-relación
├── wireframes/       # Mockups y wireframes UI
│   ├── wireframe-perfil-usuario.md
│   ├── capturatools.png
│   └── currentheroINTOOLS.png
└── auth/             # Flujos de autenticación
```

### Herramientas utilizadas

- **PlantUML** - Diagramas UML en texto
- **Draw.io** - Diagramas BPMN y wireframes
- **Figma** - Diseño de interfaces
- **PostgreSQL DBML** - Documentación de esquema

## Estructura del Proyecto

```
blackstone/
├── app/
│   ├── controllers/       # Controladores (public + admin)
│   ├── models/            # Modelos ActiveRecord
│   ├── views/            # Plantillas ERB
│   └── javascript/
│       └── controllers/   # Stimulus controllers
├── config/
│   ├── routes.rb         # Rutas de la aplicación
│   └── database.yml      # Configuración de BD
├── db/
│   ├── migrate/          # Migraciones
│   └── schema.rb         # Schema generado
└── docs/                 # Documentación técnica
    ├── documentacion-general.md
    ├── diccionario-datos.md
    ├── arquitectura.md
    ├── auth.md
    ├── api.md
    ├── design.md
    ├── metodologia.md
    ├── sprint-planning.md
    ├── requerimientos.md
    ├── descripcion-lenguajes.md
    ├── assets/           # Diagramas, wireframes, mockups
    │   ├── uml/
    │   ├── bpmn/
    │   ├── erd/
    │   ├── wireframes/
    │   └── auth/
    └── decisions/        # ADRs
```

## Rutas Principales

| Ruta | Descripción |
|------|-------------|
| `/` | Home con herramienta destacada |
| `/categories` | Lista de categorías |
| `/tools` | Directorio de herramientas |
| `/courses` | Catálogo de cursos |
| `/mis-favoritos` | Favoritos del usuario |
| `/admin` | Panel de administración |

## Deployment

Ver [documentacion-general.md](./docs/documentacion-general.md) para instrucciones completas de deployment.

### Producción

```bash
RAILS_ENV=production rails db:migrate
RAILS_ENV=production rails assets:precompile
rails server -e production
```

## Licencia

MIT
