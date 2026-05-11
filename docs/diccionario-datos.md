# Diccionario de Datos - Blackstone

## Tabla de Contenidos

1. [Categorías](#1-categories)
2. [Herramientas](#2-tools)
3. [Cursos](#3-courses)
4. [Episodios de Curso](#4-course_episodes)
5. [Progreso de Video](#5-video_progresses)
6. [Herramientas Favoritas](#6-favorite_tools)
7. [Cursos Favoritos](#7-favorite_courses)
8. [Mensajes de Contacto](#8-contact_messages)
9. [Items Destacados](#9-featured_items)
10. [Usuarios](#10-users)
11. [Active Storage](#11-active_storage)

---

## 1. Categories

Directorio de categorías para clasificar herramientas y cursos.

| Campo | Tipo | Nulo | Default | Descripción |
|-------|------|------|---------|-------------|
| `id` | `bigint` | NO | auto-increment | Identificador único |
| `name` | `string` | YES | nil | Nombre de la categoría |
| `description` | `text` | YES | nil | Descripción de la categoría |
| `slug` | `string` | YES | nil | Slug URL-friendly (generado de `name`) |
| `created_at` | `datetime` | NO | - | Fecha de creación |
| `updated_at` | `datetime` | NO | - | Fecha de última modificación |

### Relaciones

- 1:N con `tools` (una categoría tiene muchas herramientas)
- 1:N con `courses` (una categoría tiene muchos cursos)

### Validaciones

- `name`: presencia obligatoria
- `slug`: presencia obligatoria, único

### Notas

- El slug se genera automáticamente con `name.parameterize`
- Ejemplo de slug: "Desarrollo Web" → `desarrollo-web`

---

## 2. Tools

Catálogo de herramientas de desarrollo.

| Campo | Tipo | Nulo | Default | Descripción |
|-------|------|------|---------|-------------|
| `id` | `bigint` | NO | auto-increment | Identificador único |
| `name` | `string` | YES | nil | Nombre de la herramienta |
| `description` | `text` | YES | nil | Descripción (máx. 300 caracteres) |
| `website_url` | `string` | YES | nil | URL del sitio web oficial |
| `slug` | `string` | YES | nil | Slug URL-friendly (generado de `name`) |
| `open_source` | `boolean` | YES | nil | ¿Es de código abierto? |
| `free_tier` | `boolean` | YES | nil | ¿Tiene plan gratuito? |
| `platform` | `string` | YES | nil | Plataforma: Web, Windows, Mac, Linux, Multiplataforma |
| `level` | `string` | YES | nil | Nivel: Principiante, Normal, Intermedio, Avanzado, Cualquiera |
| `category_id` | `bigint` | NO | - | FK a `categories.id` |
| `logo` | `attachment` | YES | nil | Logo (Active Storage) |
| `created_at` | `datetime` | NO | - | Fecha de creación |
| `updated_at` | `datetime` | NO | - | Fecha de última modificación |

### Relaciones

- N:1 con `categories` (muchas herramientas pertenecen a una categoría)
- 1:1 con `featured_items` (una herramienta puede estar destacada)
- 1:N con `favorite_tools` (una herramienta puede tener muchos favoritos)
- 1:N con `contact_messages` (opcional, para reporte de problemas)

### Validaciones

- `name`: presencia obligatoria
- `slug`: presencia obligatoria, único
- `description`: longitud máxima de 300 caracteres
- `platform`: valor incluido en `PLATFORMS`
- `level`: valor incluido en `LEVELS`

### Constantes

```ruby
PLATFORMS = ["Web", "Windows", "Mac", "Linux", "Multiplataforma"]
LEVELS = ["Principiante", "Normal", "Intermedio", "Avanzado", "Cualquiera"]
```

### Notas

- El slug se genera automáticamente con `name.parameterize`
- `open_source` y `free_tier` pueden ser `nil` (valor desconocido)

---

## 3. Courses

Catálogo de cursos en video.

| Campo | Tipo | Nulo | Default | Descripción |
|-------|------|------|---------|-------------|
| `id` | `bigint` | NO | auto-increment | Identificador único |
| `title` | `string` | YES | nil | Título del curso |
| `description` | `text` | YES | nil | Descripción del curso |
| `is_series` | `boolean` | YES | nil | ¿Es una serie? (true) o video único (false) |
| `category_id` | `bigint` | NO | - | FK a `categories.id` |
| `created_at` | `datetime` | NO | - | Fecha de creación |
| `updated_at` | `datetime` | NO | - | Fecha de última modificación |

### Relaciones

- N:1 con `categories` (muchos cursos pertenecen a una categoría)
- 1:N con `course_episodes` (ordenados por `position`)
- 1:N con `favorite_courses` (una herramienta puede tener muchos favoritos)

### Validaciones

- `title`: presencia obligatoria
- `is_series`: inclusión en `[true, false]`

### Notas

- Si `is_series = true`, el curso tiene múltiples episodios
- Si `is_series = false`, es un video único (aún puede tener episodios)

---

## 4. Course_episodes

Episodios/vídeos individuales dentro de un curso.

| Campo | Tipo | Nulo | Default | Descripción |
|-------|------|------|---------|-------------|
| `id` | `bigint` | NO | auto-increment | Identificador único |
| `title` | `string` | YES | nil | Título del episodio |
| `youtube_url` | `string` | YES | nil | URL completa de YouTube |
| `youtube_id` | `string` | YES | nil | ID extraído de YouTube (11 caracteres) |
| `duration_seconds` | `integer` | YES | nil | Duración en segundos |
| `position` | `integer` | YES | nil | Orden del episodio en el curso |
| `course_id` | `bigint` | NO | - | FK a `courses.id` |
| `created_at` | `datetime` | NO | - | Fecha de creación |
| `updated_at` | `datetime` | NO | - | Fecha de última modificación |

### Relaciones

- N:1 con `courses` (muchos episodios pertenecen a un curso)
- 1:N con `video_progresses` (un episodio puede tener muchos progresos)

### Validaciones

- `title`: presencia obligatoria
- `youtube_url`: presencia obligatoria

### Extracción de YouTube ID

El campo `youtube_id` se genera automáticamente al guardar, soportando:

| Formato | Ejemplo URL | `youtube_id` resultante |
|---------|-------------|-------------------------|
| `watch?v=` | `https://www.youtube.com/watch?v=abc123xyz` | `abc123xyz` |
| `youtu.be/` | `https://youtu.be/abc123xyz` | `abc123xyz` |
| `/embed/` | `https://www.youtube.com/embed/abc123xyz` | `abc123xyz` |

### Notas

- `duration_seconds` es opcional y representa la duración total del vídeo
- `position` determina el orden de los episodios

---

## 5. Video_progresses

Seguimiento del progreso de visualización de vídeos por usuario.

| Campo | Tipo | Nulo | Default | Descripción |
|-------|------|------|---------|-------------|
| `id` | `bigint` | NO | auto-increment | Identificador único |
| `user_id` | `bigint` | NO | - | FK a `users.id` |
| `course_episode_id` | `bigint` | NO | - | FK a `course_episodes.id` |
| `seconds_watched` | `integer` | NO | 0 | Segundos visualizados |
| `completed` | `boolean` | NO | false | ¿Vídeo completado? |
| `created_at` | `datetime` | NO | - | Fecha de creación |
| `updated_at` | `datetime` | NO | - | Fecha de última modificación |

### Relaciones

- N:1 con `users` (muchos progresos pertenecen a un usuario)
- N:1 con `course_episodes` (muchos progresos pertenecen a un episodio)

### Validaciones

- `user_id`: presencia obligatoria, único con `course_episode_id`
- `course_episode_id`: presencia obligatoria, único con `user_id`
- `seconds_watched`: debe ser >= 0

### Índice único

```ruby
add_index :video_progresses, [:user_id, :course_episode_id], unique: true
```

### Lógica de completado

Un vídeo se marca como `completed = true` cuando:

```
seconds_watched / duration_seconds >= 0.90
```

Es decir, cuando el usuario ha visto al menos el 90% del vídeo.

### Notas

- El progreso se guarda automáticamente cada 15 segundos
- Un usuario tiene un único registro de progreso por episodio

---

## 6. Favorite_tools

Asociación de herramientas favoritas por usuario.

| Campo | Tipo | Nulo | Default | Descripción |
|-------|------|------|---------|-------------|
| `id` | `bigint` | NO | auto-increment | Identificador único |
| `user_id` | `bigint` | NO | - | FK a `users.id` |
| `tool_id` | `bigint` | NO | - | FK a `tools.id` |
| `created_at` | `datetime` | NO | - | Fecha de creación |
| `updated_at` | `datetime` | NO | - | Fecha de última modificación |

### Relaciones

- N:1 con `users` (muchos favoritos pertenecen a un usuario)
- N:1 con `tools` (muchos favoritos pertenecen a una herramienta)

### Validaciones

- `tool_id`: único con `user_id` (un usuario no puede favoritear la misma herramienta dos veces)
- Mensaje de error: "ya está en tus favoritos"

### Notas

- Tabla de unión simple sin campos adicionales
- Si se elimina un usuario o herramienta, se eliminan los registros asociados

---

## 7. Favorite_courses

Asociación de cursos favoritos por usuario.

| Campo | Tipo | Nulo | Default | Descripción |
|-------|------|------|---------|-------------|
| `id` | `bigint` | NO | auto-increment | Identificador único |
| `user_id` | `bigint` | NO | - | FK a `users.id` |
| `course_id` | `bigint` | NO | - | FK a `courses.id` |
| `created_at` | `datetime` | NO | - | Fecha de creación |
| `updated_at` | `datetime` | NO | - | Fecha de última modificación |

### Relaciones

- N:1 con `users` (muchos favoritos pertenecen a un usuario)
- N:1 con `courses` (muchos favoritos pertenecen a un curso)

### Validaciones

- `course_id`: único con `user_id` (un usuario no puede favoritear el mismo curso dos veces)
- Mensaje de error: "ya está en tus favoritos"

### Notas

- Tabla de unión simple sin campos adicionales
- Si se elimina un usuario o curso, se eliminan los registros asociados

---

## 8. Contact_messages

Mensajes de contacto enviados por usuarios.

| Campo | Tipo | Nulo | Default | Descripción |
|-------|------|------|---------|-------------|
| `id` | `bigint` | NO | auto-increment | Identificador único |
| `name` | `string` | YES | nil | Nombre del remitente |
| `email` | `string` | YES | nil | Email del remitente |
| `message_type` | `string` | YES | nil | Tipo: sugerencia, reclamo, link_roto, otro |
| `body` | `text` | YES | nil | Cuerpo del mensaje |
| `tool_id` | `integer` | YES | nil | ID de herramienta relacionada (opcional) |
| `read` | `boolean` | NO | false | ¿Mensaje leído? |
| `created_at` | `datetime` | NO | - | Fecha de creación |
| `updated_at` | `datetime` | NO | - | Fecha de última modificación |

### Relaciones

- N:1 con `tools` (opcional, una herramienta puede tener mensajes relacionados)

### Validaciones

- `name`: presencia obligatoria
- `email`: presencia obligatoria
- `message_type`: presencia obligatoria, inclusión en `MESSAGE_TYPES`
- `body`: presencia obligatoria

### Constantes

```ruby
MESSAGE_TYPES = ["sugerencia", "reclamo", "link_roto", "otro"]
```

| Tipo | Descripción |
|------|-------------|
| `sugerencia` | El usuario sugiere agregar una herramienta o mejora |
| `reclamo` | El usuario presenta una queja |
| `link_roto` | El usuario reporta un enlace roto |
| `otro` | Otros mensajes |

### Notas

- `tool_id` es opcional y permite asociar el mensaje a una herramienta específica
- `read` permite filtrar mensajes no leídos en el admin

---

## 9. Featured_items

Relación para destacar una herramienta diariamente.

| Campo | Tipo | Nulo | Default | Descripción |
|-------|------|------|---------|-------------|
| `id` | `bigint` | NO | auto-increment | Identificador único |
| `tool_id` | `bigint` | NO | - | FK a `tools.id` |
| `featured_on` | `date` | YES | nil | Fecha en que está destacada |
| `created_at` | `datetime` | NO | - | Fecha de creación |
| `updated_at` | `datetime` | NO | - | Fecha de última modificación |

### Relaciones

- N:1 con `tools` (muchos items destacados pueden apuntar a una herramienta)

### Validaciones

- `tool_id`: presencia obligatoria
- `featured_on`: presencia obligatoria, único con `tool_id`
- Mensaje de error: "Esta herramienta ya fue destacada en esta fecha"

### Índice único

```ruby
add_index :featured_items, [:tool_id, :featured_on], unique: true
```

### Lógica de featured item

1. Al cargar el home, se busca `FeaturedItem` con `featured_on: Date.today`
2. Si no existe, se selecciona una herramienta aleatoria y se crea un nuevo `FeaturedItem`
3. La herramienta destacada se muestra en el hero del home

### Notas

- Una misma herramienta no puede estar destacada dos veces en la misma fecha
- El sistema asegura que siempre haya una herramienta destacada del día

---

## 10. Users

Usuarios registrados en la plataforma.

| Campo | Tipo | Nulo | Default | Descripción |
|-------|------|------|---------|-------------|
| `id` | `bigint` | NO | auto-increment | Identificador único |
| `email` | `string` | NO | "" | Email único del usuario |
| `encrypted_password` | `string` | NO | "" | Contraseña encriptada (Devise) |
| `reset_password_token` | `string` | YES | nil | Token para resetear contraseña |
| `reset_password_sent_at` | `datetime` | YES | nil | Fecha en que se envió token de reset |
| `remember_created_at` | `datetime` | YES | nil | Fecha en que "recordarme" fue activado |
| `name` | `string` | YES | nil | Nombre del usuario |
| `admin` | `boolean` | NO | false | ¿Es administrador? |
| `created_at` | `datetime` | NO | - | Fecha de creación |
| `updated_at` | `datetime` | NO | - | Fecha de última modificación |

### Relaciones

- 1:N con `video_progresses` (un usuario tiene muchos progresos)
- 1:N con `favorite_tools` (un usuario tiene muchas herramientas favoritas)
- 1:N con `favorite_courses` (un usuario tiene muchos cursos favoritos)
- N:1 con `favorited_tools` (a través de `favorite_tools`)
- N:1 con `favorited_courses` (a través de `favorite_courses`)

### Módulos Devise

```ruby
devise :database_authenticatable, :registerable,
       :recoverable, :rememberable, :validatable
```

| Módulo | Descripción |
|--------|-------------|
| `database_authenticatable` | Autenticación con email y password |
| `registerable` | Permite registro de usuarios |
| `recoverable` | Permite resetear contraseña |
| `rememberable` | Recordar sesión con "recordarme" |
| `validatable` | Validaciones de email y password |

### Validaciones Devise

- Email: único, no nulo
- Password: mínimo 6 caracteres

### Índices

```ruby
add_index :users, :email, unique: true
add_index :users, :reset_password_token, unique: true
```

### Notas

- `admin` es `false` por defecto (usuario regular)
- Solo usuarios con `admin: true` pueden acceder al panel `/admin`
- Los módulos `confirmable`, `lockable`, `timeoutable`, `trackable` y `omniauthable` no están activos

---

## 11. Active Storage

Tablas generadas automáticamente por Rails para gestión de archivos.

### 11.1 Active_storage_attachments

Tabla polimórfica para adjuntar archivos a cualquier modelo.

| Campo | Tipo | Descripción |
|-------|------|-------------|
| `id` | `bigint` | Identificador único |
| `name` | `string` | Nombre del adjunto (ej: "logo") |
| `record_type` | `string` | Tipo del modelo associated (ej: "Tool") |
| `record_id` | `bigint` | ID del modelo associated |
| `blob_id` | `bigint` | FK a `active_storage_blobs` |
| `created_at` | `datetime` | Fecha de creación |

### 11.2 Active_storage_blobs

Almacenamiento de metadatos y datos del archivo.

| Campo | Tipo | Descripción |
|-------|------|-------------|
| `id` | `bigint` | Identificador único |
| `key` | `string` | Clave de almacenamiento (path) |
| `filename` | `string` | Nombre original del archivo |
| `content_type` | `string` | MIME type (ej: "image/png") |
| `metadata` | `text` | Metadatos adicionales en JSON |
| `service_name` | `string` | Nombre del servicio (ej: "local") |
| `byte_size` | `bigint` | Tamaño en bytes |
| `checksum` | `string` | Checksum para verificación |
| `created_at` | `datetime` | Fecha de creación |

### 11.3 Active_storage_variant_records

Variantes de imágenes procesadas (thumbnails, etc.).

| Campo | Tipo | Descripción |
|-------|------|-------------|
| `id` | `bigint` | Identificador único |
| `blob_id` | `bigint` | FK a `active_storage_blobs` |
| `variation_digest` | `string` | Hash que identifica la transformación |

### Uso en Blackstone

```ruby
class Tool < ApplicationRecord
  has_one_attached :logo
end
```

- Los logos de herramientas se almacenan usando Active Storage
- Servicio configurado: `:local` (almacenamiento en disco)
- En producción se recomienda usar un servicio cloud (S3, GCS, etc.)

---

## Diagrama ER (Entidad-Relación)

```
┌─────────────────┐      ┌─────────────────┐      ┌─────────────────┐
│    Category      │      │      Tool       │      │ FeaturedItem    │
├─────────────────┤      ├─────────────────┤      ├─────────────────┤
│ id              │◄──┐  │ id              │◄──┐  │ id              │
│ name            │   │  │ name            │   │  │ tool_id         │
│ description     │   │  │ website_url     │   │  │ featured_on     │
│ slug            │   │  │ slug           │   │  └─────────────────┘
└─────────────────┘   │  │ open_source     │   │
         │            │  │ free_tier       │   │  ┌─────────────────┐
         │            │  │ platform        │   │  │      User       │
         │            │  │ level           │   │  ├─────────────────┤
         │            │  │ category_id     │───┘  │ id              │
         │            │  │ logo            │      │ email           │
         │            │  └─────────────────┘      │ admin           │
         │            │           │                 └─────────────────┘
         │            │           │                       │
         │            │           │                       │
         ▼            ▼           ▼                       ▼
┌─────────────────────────────────────────────────────────────────┐
│                         FavoriteTool                             │
├─────────────────────────────────────────────────────────────────┤
│ id, user_id, tool_id, created_at, updated_at                   │
│ [unique: user_id + tool_id]                                    │
└─────────────────────────────────────────────────────────────────┘
                                  │
┌─────────────────┐      ┌─────────────────┐      ┌─────────────────┐
│      Course      │      │ CourseEpisode   │      │  VideoProgress   │
├─────────────────┤      ├─────────────────┤      ├─────────────────┤
│ id              │◄──┐  │ id              │◄──┐  │ id              │
│ title           │   │  │ title           │   │  │ user_id         │
│ description     │   │  │ youtube_url    │   │  │ course_ep_id    │
│ is_series       │   │  │ youtube_id     │   │  │ seconds_watched │
│ category_id     │───┘  │ duration_seconds│   │  │ completed       │
└─────────────────┘      │ position        │   │  └─────────────────┘
                                  │            │
                                  ▼            ▼
┌─────────────────────────────────────────────────────────────────┐
│                      FavoriteCourse                             │
├─────────────────────────────────────────────────────────────────┤
│ id, user_id, course_id, created_at, updated_at                 │
│ [unique: user_id + course_id]                                  │
└─────────────────────────────────────────────────────────────────┘

┌─────────────────┐
│ ContactMessage   │
├─────────────────┤
│ id              │
│ name            │
│ email           │
│ message_type    │
│ body            │
│ tool_id         │
│ read            │
└─────────────────┘
```

---

## Resumen de Tablas

| Tabla | Purpose | Llave Foránea |
|-------|---------|---------------|
| `categories` | Clasificación de herramientas y cursos | - |
| `tools` | Directorio de herramientas de desarrollo | `category_id` |
| `courses` | Catálogo de cursos en video | `category_id` |
| `course_episodes` | Vídeos individuales de un curso | `course_id` |
| `video_progresses` | Seguimiento de progreso por usuario | `user_id`, `course_episode_id` |
| `favorite_tools` | Herramientas favoriteariadas | `user_id`, `tool_id` |
| `favorite_courses` | Cursos favoriteariados | `user_id`, `course_id` |
| `contact_messages` | Mensajes de contacto de usuarios | `tool_id` (opcional) |
| `featured_items` | Herramienta destacada del día | `tool_id` |
| `users` | Usuarios registrados | - |
| `active_storage_*` | Gestión de archivos adjuntos | - |

---

*Versión 1.0 - Blackstone*
