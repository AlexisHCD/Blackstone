# Diagrama de Clases

```plantuml
@startuml

title Diagrama de Clases - Blackstone

class User {
  +id: BigInt
  +email: String
  +encrypted_password: String
  +name: String
  +admin: Boolean
  +reset_password_token: String
  +remember_created_at: DateTime
  --
  +devise_modules: String[]
  +video_progresses: VideoProgress[]
  +favorite_tools: FavoriteTool[]
  +favorite_courses: FavoriteCourse[]
  --
  +authenticate_user!: Boolean
  +admin?: Boolean
}

class Category {
  +id: BigInt
  +name: String
  +description: Text
  +slug: String
  +created_at: DateTime
  +updated_at: DateTime
  --
  +tools: Tool[]
  +courses: Course[]
  --
  +generate_slug(): void
}

class Tool {
  +id: BigInt
  +name: String
  +description: Text
  +website_url: String
  +slug: String
  +open_source: Boolean
  +free_tier: Boolean
  +platform: String
  +level: String
  +category_id: BigInt
  +logo_attachment: ActiveStorage
  +created_at: DateTime
  +updated_at: DateTime
  --
  +category: Category
  +featured_items: FeaturedItem[]
  +favorite_tools: FavoriteTool[]
  +contact_messages: ContactMessage[]
  --
  +generate_slug(): void
}

class Course {
  +id: BigInt
  +title: String
  +description: Text
  +is_series: Boolean
  +category_id: BigInt
  +created_at: DateTime
  +updated_at: DateTime
  --
  +category: Category
  +course_episodes: CourseEpisode[]
  +favorite_courses: FavoriteCourse[]
}

class CourseEpisode {
  +id: BigInt
  +title: String
  +youtube_url: String
  +youtube_id: String
  +duration_seconds: Integer
  +position: Integer
  +course_id: BigInt
  +created_at: DateTime
  +updated_at: DateTime
  --
  +course: Course
  +video_progresses: VideoProgress[]
  --
  +extract_youtube_id(): void
}

class VideoProgress {
  +id: BigInt
  +user_id: BigInt
  +course_episode_id: BigInt
  +seconds_watched: Integer
  +completed: Boolean
  +created_at: DateTime
  +updated_at: DateTime
  --
  +user: User
  +course_episode: CourseEpisode
  --
  +check_completion(): Boolean
}

class FavoriteTool {
  +id: BigInt
  +user_id: BigInt
  +tool_id: BigInt
  +created_at: DateTime
  +updated_at: DateTime
  --
  +user: User
  +tool: Tool
}

class FavoriteCourse {
  +id: BigInt
  +user_id: BigInt
  +course_id: BigInt
  +created_at: DateTime
  +updated_at: DateTime
  --
  +user: User
  +course: Course
}

class FeaturedItem {
  +id: BigInt
  +tool_id: BigInt
  +featured_on: Date
  +created_at: DateTime
  +updated_at: DateTime
  --
  +tool: Tool
}

class ContactMessage {
  +id: BigInt
  +name: String
  +email: String
  +message_type: String
  +body: Text
  +tool_id: BigInt (nullable)
  +read: Boolean
  +created_at: DateTime
  +updated_at: DateTime
  --
  +tool: Tool (nullable)
}

class ActiveStorage::Attachment {
  +id: BigInt
  +name: String
  +record_type: String
  +record_id: BigInt
  +blob_id: BigInt
  +created_at: DateTime
}

class ActiveStorage::Blob {
  +id: BigInt
  +key: String
  +filename: String
  +content_type: String
  +byte_size: BigInt
  +checksum: String
  +service_name: String
}

' Relaciones
User "1" --> "*" VideoProgress : has_many
User "1" --> "*" FavoriteTool : has_many
User "1" --> "*" FavoriteCourse : has_many

Category "1" --> "*" Tool : has_many
Category "1" --> "*" Course : has_many

Tool "1" --> "*" FeaturedItem : has_one
Tool "1" --> "*" FavoriteTool : has_many
Tool "1" --> "*" ContactMessage : has_many
Tool "1" --> "1" ActiveStorage::Attachment : has_one_attached

Course "1" --> "*" CourseEpisode : has_many
Course "1" --> "*" FavoriteCourse : has_many

CourseEpisode "1" --> "*" VideoProgress : has_many

VideoProgress "*" --> "1" User : belongs_to
VideoProgress "*" --> "1" CourseEpisode : belongs_to

FavoriteTool "*" --> "1" User : belongs_to
FavoriteTool "*" --> "1" Tool : belongs_to

FavoriteCourse "*" --> "1" User : belongs_to
FavoriteCourse "*" --> "1" Course : belongs_to

FeaturedItem "*" --> "1" Tool : belongs_to

ContactMessage "*" --> "0..1" Tool : belongs_to

ActiveStorage::Attachment "*" --> "1" ActiveStorage::Blob : belongs_to

@enduml
```

## Modelo de Dominio

### Entidades Principales

| Entidad | Descripción | Relaciones |
|---------|-------------|------------|
| **User** | Usuario del sistema | has_many :video_progresses, :favorite_tools, :favorite_courses |
| **Category** | Categoría de herramientas/cursos | has_many :tools, :courses |
| **Tool** | Herramienta de desarrollo | belongs_to :category, has_many :favorite_tools |
| **Course** | Curso en video | belongs_to :category, has_many :course_episodes |
| **CourseEpisode** | Episodio individual de curso | belongs_to :course, has_many :video_progresses |
| **VideoProgress** | Tracking de progreso | belongs_to :user, :course_episode |

### Entidades de Favoritos

| Entidad | Descripción | Llave única |
|---------|-------------|-------------|
| **FavoriteTool** | Herramienta favoriteda | [user_id, tool_id] |
| **FavoriteCourse** | Curso favoritedo | [user_id, course_id] |

### Entidades de Soporte

| Entidad | Descripción |
|---------|-------------|
| **FeaturedItem** | Herramienta destacada del día |
| **ContactMessage** | Mensaje de contacto de usuario |
| **ActiveStorage::Attachment** | Archivo adjunts (logos) |

## Constantes del Modelo

```ruby
class Tool < ApplicationRecord
  PLATFORMS = ["Web", "Windows", "Mac", "Linux", "Multiplataforma"]
  LEVELS = ["Principiante", "Normal", "Intermedio", "Avanzado", "Cualquiera"]
end

class ContactMessage < ApplicationRecord
  MESSAGE_TYPES = ["sugerencia", "reclamo", "link_roto", "otro"]
end
```
