# Diagrama de Componentes

```plantuml
@startuml

title Diagrama de Componentes - Blackstone

package "Client Layer" {
  [Web Browser\n(Chrome, Firefox, Safari)] as browser
  [HTML/CSS/JS\n(ERB Templates)] as frontend
  [Stimulus\nControllers] as stimulus

  browser --> frontend
  frontend --> stimulus
}

package "Rails Application" {
  [Controllers\n(Home, Tools, Courses, etc.)] as controllers
  [Models\n(Category, Tool, User, etc.)] as models
  [Views\n(ERB Templates)] as views
  [Devise\n(Auth Module)] as devise
  [Active Storage\n(File Handling)] as storage

  controllers --> models
  controllers --> views
  controllers --> devise
  controllers --> storage
  models --> storage
}

package "Hotwire" {
  [Turbo\n(Page Accelerator)] as turbo
  [Stimulus\n(JS Framework)] as stimulus_framework

  frontend --> turbo
  stimulus --> stimulus_framework
}

package "Database Layer" {
  [PostgreSQL 14+\n(Relational DB)] as database
  [Migrations\n(Schema Versioning)] as migrations
  [ActiveRecord\n(ORM)] as orm

  models --> orm
  orm --> database
  migrations --> database
}

package "External Services" {
  [YouTube IFrame API\n(Video Playback)] as youtube
  [Google Fonts\n(Typography)] as fonts
  [SMTP Server\n(Email - Future)] as smtp

  stimulus --> youtube
  frontend --> fonts
}

database <--> migrations
stimulus_framework <--> youtube

@enduml
```

## Arquitectura de Componentes

### Client Layer (Navegador)
| Componente | Descripción |
|-----------|-------------|
| **Web Browser** | Chrome, Firefox, Safari |
| **HTML/CSS/JS** | Templates ERB renderizados por Rails |
| **Stimulus Controllers** | Video player, Modal |

### Rails Application
| Componente | Descripción |
|-----------|-------------|
| **Controllers** | Home, Tools, Courses, Admin, etc. |
| **Models** | Category, Tool, User, Course, etc. |
| **Views** | Plantillas ERB |
| **Devise** | Autenticación |
| **Active Storage** | Gestión de archivos (logos) |

### Hotwire
| Componente | Descripción |
|-----------|-------------|
| **Turbo** | Acelerador de páginas (SPA-like) |
| **Stimulus** | Framework JavaScript ligero |

### Database Layer
| Componente | Descripción |
|-----------|-------------|
| **PostgreSQL 14+** | Base de datos relacional |
| **Migrations** | Versionado del schema |
| **ActiveRecord** | ORM de Rails |

### External Services
| Componente | Descripción |
|-----------|-------------|
| **YouTube IFrame API** | Reproductor de video |
| **Google Fonts** | Inter, DM Serif Display, JetBrains Mono |
| **SMTP Server** | Futuro: notificaciones email |
