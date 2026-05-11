# Arquitectura - Blackstone

## 1. Vista General

Blackstone sigue una arquitectura **monolítica clássica de Rails** con componentes modernos de Hotwire para interactividad.

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                              ARQUITECTURA BLACKSTONE                       │
└─────────────────────────────────────────────────────────────────────────────┘

                          ┌─────────────────────┐
                          │      BROWSER        │
                          │   (HTML + CSS + JS) │
                          └──────────┬──────────┘
                                     │
                          ┌──────────▼──────────┐
                          │      RAILS          │
                          │  (Turbo + Stimulus) │
                          │                     │
                          │  ┌──────────────┐  │
                          │  │ Controllers  │  │
                          │  │   + Views     │  │
                          │  └──────────────┘  │
                          │          │          │
                          │  ┌──────────────┐  │
                          │  │    Models    │  │
                          │  │ ActiveRecord │  │
                          │  └──────────────┘  │
                          └──────────┬──────────┘
                                     │
                          ┌──────────▼──────────┐
                          │     POSTGRESQL       │
                          │   (Base de datos)    │
                          └─────────────────────┘
```

---

## 2. Capas de la Aplicación

### 2.1 Presentación (Views + Controllers)

| Componente | Responsabilidad |
|------------|-----------------|
| **Views (ERB)** | Renderizado de templates HTML |
| **Controllers** | Recibir requests, coordinar responses |
| **Helpers** | Métodos utilitarios para views |
| **JavaScript (Stimulus)** | Interactividad del lado del cliente |

### 2.2 Lógica de Negocio (Models)

| Componente | Responsabilidad |
|------------|-----------------|
| **ActiveRecord Models** | Validaciones, relaciones, lógica de negocio |
| **Scopes** | Consultas reutilizables |
| **Callbacks** | Acciones automáticas en eventos del modelo |
| **Enumerations** | Conjuntos de valores constantes |

### 2.3 Persistencia (Database)

| Componente | Responsabilidad |
|------------|-----------------|
| **PostgreSQL** | Almacenamiento de datos |
| **Migrations** | Versionado del schema |
| **Active Storage** | Almacenamiento de archivos |

---

## 3. Estructura de Directorios

```
blackstone/
├── app/
│   ├── assets/                 # CSS, JavaScript, imágenes
│   │   ├── images/
│   │   └── stylesheets/
│   │       └── application.css
│   ├── controllers/           # Controladores de la app
│   │   ├── admin/            # Panel administrativo
│   │   ├── application_controller.rb
│   │   ├── categories_controller.rb
│   │   ├── contact_messages_controller.rb
│   │   ├── courses_controller.rb
│   │   ├── favorites_controller.rb
│   │   ├── favorite_courses_controller.rb
│   │   ├── favorite_tools_controller.rb
│   │   ├── home_controller.rb
│   │   ├── tools_controller.rb
│   │   └── video_progresses_controller.rb
│   ├── javascript/
│   │   └── controllers/      # Stimulus controllers
│   │       ├── modal_controller.js
│   │       └── video_player_controller.js
│   ├── jobs/                  # Jobs en background
│   ├── mailers/              # Mailers de Devise
│   ├── models/               # Modelos ActiveRecord
│   │   ├── application_record.rb
│   │   ├── category.rb
│   │   ├── contact_message.rb
│   │   ├── course.rb
│   │   ├── course_episode.rb
│   │   ├── favorite_course.rb
│   │   ├── favorite_tool.rb
│   │   ├── featured_item.rb
│   │   ├── tool.rb
│   │   ├── user.rb
│   │   └── video_progress.rb
│   └── views/                # Plantillas ERB
│       ├── admin/            # Vistas del admin
│       ├── categories/
│       ├── courses/
│       ├── favorites/
│       ├── home/
│       ├── layouts/
│       ├── tools/
│       ├── devise/           # Vistas de autenticación
│       └── contact_messages/
├── config/
│   ├── application.rb
│   ├── database.yml
│   ├── environment.rb
│   ├── environments/
│   ├── initializers/
│   ├── routes.rb
│   └── storage.yml
├── db/
│   ├── migrate/              # Migraciones
│   ├── schema.rb             # Schema generado
│   └── seeds.rb              # Datos de prueba
├── lib/
│   └── tasks/
├── public/
├── spec/                     # Tests (pendiente)
└── tmp/
```

---

## 4. Modelos de Datos (ERD Simplificado)

```
┌─────────────────┐      ┌─────────────────┐
│    Category      │      │      Tool       │
├─────────────────┤      ├─────────────────┤
│ id              │◄──┐  │ id              │
│ name            │   │  │ name           │
│ description     │   │  │ website_url    │
│ slug            │   │  │ slug           │
└─────────────────┘   │  │ open_source    │
         │            │  │ free_tier      │
         │            │  │ platform       │
         │            │  │ level          │
         │            │  │ category_id    │───┘
         │            │  │ logo           │
         │            │  └─────────────────┘
         │            │           │
         │            │           │
         ▼            ▼           ▼
┌─────────────────────────────────────────────┐
│              FavoriteTool                   │
├─────────────────────────────────────────────┤
│ id, user_id, tool_id                        │
└─────────────────────────────────────────────┘
                                  │
┌─────────────────┐      ┌─────────────────┐
│      Course      │      │  CourseEpisode  │
├─────────────────┤      ├─────────────────┤
│ id              │◄──┐  │ id              │
│ title           │   │  │ title          │
│ description     │   │  │ youtube_url    │
│ is_series       │   │  │ youtube_id     │
│ category_id     │───┘  │ duration_sec.   │
└─────────────────┘      │ position        │
                        │ course_id       │
                        └─────────────────┘
                                  │
                                  ▼
                        ┌─────────────────┐
                        │ VideoProgress   │
                        ├─────────────────┤
                        │ id              │
                        │ user_id         │
                        │ course_ep_id   │
                        │ seconds_watch. │
                        │ completed      │
                        └─────────────────┘
```

---

## 5. Flujo de Datos

### 5.1 Request-Response Classic

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    FLUJO REQUEST-RESPONSE                                 │
└─────────────────────────────────────────────────────────────────────────────┘

  BROWSER                      RAILS                      DATABASE
     │                            │                            │
     │  GET /tools/1              │                            │
     │───────────────────────────►│                            │
     │                            │                            │
     │                            │  Tool.find(1)              │
     │                            │────────────────────────────►│
     │                            │                            │
     │                            │  { tool data }             │
     │                            │◄────────────────────────────│
     │                            │                            │
     │  HTML response             │                            │
     │◄───────────────────────────│                            │
```

### 5.2 Video Progress (Turbo Stream)

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    FLUJO VIDEO PROGRESS (Turbo)                            │
└─────────────────────────────────────────────────────────────────────────────┘

  VIDEO PLAYER              JAVASCRIPT                RAILS                   DATABASE
       │                        │                      │                         │
       │  onStateChange(PLAY)   │                      │                         │
       │───────────────────────►│                      │                         │
       │                        │                      │                         │
       │                        │  saveProgress()      │                         │
       │                        │  fetch PATCH         │                         │
       │                        │────────────────────►│                         │
       │                        │                      │                         │
       │                        │                      │ VideoProgress.upsert()  │
       │                        │                      │────────────────────────►│
       │                        │                      │                         │
       │                        │                      │  { status: "ok" }      │
       │                        │  { json response }   │◄────────────────────────│
       │                        │◄─────────────────────│                         │
       │                        │                      │                         │
       │  Progress saved ✓      │                      │                         │
       │◄──────────────────────│                      │                         │
```

---

## 6. Routing

### 6.1 Estructura de Rutas

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                           ROUTES BLACKSTONE                                 │
└─────────────────────────────────────────────────────────────────────────────┘

devise_for :users                     # /users/sign_up, /users/sign_in, etc.

root "home#index"                     # /

resources :categories, only: [:index, :show]
resources :tools, only: [:index, :show]
resources :courses, only: [:index, :show]

patch "video_progress", to: "video_progresses#upsert"

resources :favorite_tools, only: [:create, :destroy]
resources :favorite_courses, only: [:create, :destroy]
get "mis-favoritos", to: "favorites#index", as: :favorites

resources :contact_messages, only: [:create]

namespace :admin do                    # /admin/*
  root to: "dashboard#index"
  resources :categories
  resources :tools
  resources :courses do
    resources :course_episodes, path: "episodes"
  end
  resources :contact_messages, only: [:index, :show, :destroy] do
    member { patch :mark_read }
  end
  resources :users, only: [:index] do
    member { patch :toggle_admin }
  end
end
```

### 6.2 Rutas Principales

| Método | Ruta | Acción | Descripción |
|--------|------|--------|-------------|
| GET | `/` | home#index | Home con featured item |
| GET | `/categories` | categories#index | Lista categorías |
| GET | `/categories/:id` | categories#show | Herramientas por categoría |
| GET | `/tools` | tools#index | Lista herramientas |
| GET | `/tools/:id` | tools#show | Detalle herramienta |
| GET | `/courses` | courses#index | Lista cursos |
| GET | `/courses/:id` | courses#show | Detalle curso |
| GET | `/mis-favoritos` | favorites#index | Favoritos (auth) |
| PATCH | `/video_progress` | video_progresses#upsert | Guardar progreso |
| POST | `/favorite_tools` | favorite_tools#create | Agregar favorito |
| DELETE | `/favorite_tools/:id` | favorite_tools#destroy | Quitar favorito |
| GET | `/admin` | admin/dashboard#index | Dashboard admin |

---

## 7. Componentes Frontend

### 7.1 Hotwire

**Turbo** acelera las páginas sin JavaScript pesado:
- Reemplazo de páginas con links
- Frames para actualizaciones parciales
- Streams para actualizaciones en tiempo real

**Stimulus** proporciona interactividad:
- `video_player_controller.js` - Tracking de progreso YouTube
- `modal_controller.js` - Modal de contacto

### 7.2 CSS (Design System Resend-style)

| Archivo | Propósito |
|---------|-----------|
| `application.css` | Tokens de diseño, componentes, layouts |

**Tokens principales:**
```css
--color-void-black: #000000;
--color-graphite-rail: #292d30;
--color-fog: #a1a4a5;
--color-frost: #f0f0f0;
--color-electric-blue: #3b9eff;
--color-resend-violet: #9281f7;
```

---

## 8. Seguridad

### 8.1 Autenticación

- Devise con password encriptado (BCrypt)
- Sesiones persistentes con "recordarme"
- Tokens de reset de contraseña

### 8.2 Autorización

| Rol | Acceso |
|-----|-------|
| Anónimo | Contenido público |
| Usuario | Favoritos, progreso, contacto |
| Admin | Todo + `/admin/*` |

### 8.3 Protecciones CSRF

- Tokens CSRF en todos los forms
- SameSite cookies
- Content Security Policy

---

## 9. Escalabilidad

### 9.1 Estado Actual (Monolito Simple)

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                           ACTUAL (MONOLITO)                               │
└─────────────────────────────────────────────────────────────────────────────┘

                    ┌─────────────────────┐
                    │   App + DB + Docs    │
                    │   (Todo en 1 server) │
                    └─────────────────────┘
```

### 9.2 Escalabilidad Horizontal (Futuro)

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                        ESCALABILIDAD FUTURA                               │
└─────────────────────────────────────────────────────────────────────────────┘

                    ┌─────────────────────┐
                    │   Load Balancer     │
                    └──────────┬──────────┘
                               │
          ┌────────────────────┼────────────────────┐
          │                    │                    │
┌─────────▼─────────┐  ┌──────▼──────┐  ┌─────────▼─────────┐
│   App Server 1    │  │  App Server │  │   App Server 3    │
│   (Rails + Puma)  │  │  2 (Puma)   │  │   (Rails)        │
└───────────────────┘  └─────────────┘  └───────────────────┘
          │                                       │
          └─────────────────────┬─────────────────┘
                                │
                    ┌───────────▼───────────┐
                    │     PostgreSQL         │
                    │   (Primary + Replica)  │
                    └───────────────────────┘
                                │
                    ┌───────────▼───────────┐
                    │    Object Storage     │
                    │   (S3 / Cloud)        │
                    └───────────────────────┘
```

---

*Versión 1.0 - Blackstone*
