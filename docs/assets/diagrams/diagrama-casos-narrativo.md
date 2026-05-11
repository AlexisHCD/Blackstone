# Diagrama de Casos de Uso Narrativo

## Caso de Uso: Agregar Herramienta a Favoritos

**Actor:** Usuario Registrado

**Objetivo:** Guardar una herramienta en la lista de favoritos personal

**Precondiciones:**
- Usuario debe estar autenticado
- Herramienta debe existir en el sistema

**Flujo Básico:**

| Paso | Actor | Sistema |
|------|-------|---------|
| 1 | Usuario navega a detalle de herramienta | - |
| 2 | - | Muestra informacion de herramienta con boton "Agregar a Favoritos" |
| 3 | Usuario presiona boton "Agregar a Favoritos" | - |
| 4 | - | Verifica que el usuario este autenticado |
| 5 | - | Verifica que la herramienta no este ya en favoritos |
| 6 | - | Crea registro en FavoriteTool |
| 7 | - | Confirma con mensaje "Herramienta agregada a favoritos" |

**Flujo Alternativo:**

| Paso | Condicion | Accion |
|------|-----------|--------|
| 4a | Usuario no autenticado | Redirige a pagina de login |
| 5a | Herramienta ya en favoritos | Muestra error "ya esta en tus favoritos" |

**Postcondiciones:**
- Registro FavoriteTool creado con user_id y tool_id
- Herramienta visible en /mis-favoritos

### Diagrama de Secuencia

```plantuml
@startuml
skinparam sequenceFontSize 10
skinparam noteFontSize 9

title Agregar Herramienta a Favoritos - Secuencia

actor ":Usuario" as usuario
boundary ":ToolsController" as toolsController
boundary ":FavoriteToolsController" as favController
entity ":FavoriteTool" as model
database ":PostgreSQL" as db

== Mostrar Detalle de Herramienta ==

usuario -> toolsController : GET /tools/:id
toolsController -> db : SELECT * FROM tools WHERE id = ?
db --> toolsController : [tool]
toolsController -> db : SELECT * FROM categories WHERE id = tool.category_id
db --> toolsController : [category]
toolsController --> usuario : Renderiza tool detail con boton favorito

== Agregar a Favoritos ==

usuario -> favController : POST /favorite_tools
favController -> favController : authenticate_user!
favController -> favController : favorite_tool_params

alt Usuario no autenticado
  favController --> usuario : Redirect a /users/sign_in
else Usuario autenticado
  favController -> model : new
  model -> db : BEGIN TRANSACTION
  db --> model : OK
  model -> db : SELECT * FROM favorite_tools WHERE user_id = ? AND tool_id = ?
  db --> model : [resultado]

  alt Duplicado encontrado
    model --> favController : [errors: ya esta en tus favoritos]
    favController --> usuario : Redirect con alert error
  else No existe duplicado
    model -> db : INSERT INTO favorite_tools (user_id, tool_id, created_at, updated_at)
    db --> model : [favorite_tool creado]
    model --> favController : [favorite_tool]
    favController -> db : COMMIT
    favController --> usuario : Redirect a /tools/:id con notice
  end
end

note right of model
  Validacion uniqueness scope: [user_id, tool_id]
  Mensaje: ya esta en tus favoritos
end note

@enduml
```

---

## Caso de Uso: Quitar Herramienta de Favoritos

**Actor:** Usuario Registrado

**Objetivo:** Eliminar una herramienta de la lista de favoritos

**Precondiciones:**
- Usuario debe estar autenticado
- Herramienta debe estar en favoritos del usuario

**Flujo Básico:**

| Paso | Actor | Sistema |
|------|-------|---------|
| 1 | Usuario navega a /mis-favoritos | - |
| 2 | - | Lista herramientas y cursos favoritos |
| 3 | Usuario presiona boton "Eliminar" en herramienta | - |
| 4 | - | Busca FavoriteTool por id |
| 5 | - | Elimina registro de FavoriteTool |
| 6 | - | Confirma con mensaje "Herramienta eliminada de favoritos" |

**Postcondiciones:**
- Registro FavoriteTool eliminado
- Herramienta ya no aparece en /mis-favoritos

### Diagrama de Secuencia

```plantuml
@startuml
skinparam sequenceFontSize 10

title Quitar Herramienta de Favoritos - Secuencia

actor ":Usuario" as usuario
boundary ":FavoritesController" as favController
boundary ":FavoriteToolsController" as favToolsController
entity ":FavoriteTool" as model
database ":PostgreSQL" as db

== Ver Favoritos ==

usuario -> favController : GET /mis-favoritos
favController -> favController : authenticate_user!
favController -> db : SELECT favorite_tools.*, tools.* FROM favorite_tools\nINNER JOIN tools ON favorite_tools.tool_id = tools.id\nWHERE favorite_tools.user_id = ?
db --> favController : [lista_favoritos]
favController --> usuario : Renderiza /favorites/index.html.erb

== Eliminar Favorito ==

usuario -> favToolsController : DELETE /favorite_tools/:id
favToolsController -> model : find(params[:id])
model -> db : SELECT * FROM favorite_tools WHERE id = ?
db --> model : [favorite_tool]

alt No existe o no pertenece al usuario
  model --> favToolsController : raise ActiveRecord::RecordNotFound
  favToolsController --> usuario : Redirect con alert error
else Existe y pertenece al usuario
  model -> db : DELETE FROM favorite_tools WHERE id = ?
  db --> model : [filas_afectadas]
  model --> favToolsController : [destruido]
  favToolsController --> usuario : Redirect a /mis-favoritos con notice
end

@enduml
```

---

## Caso de Uso: Trackear Progreso de Video

**Actor:** Usuario Registrado

**Objetivo:** Guardar el progreso de visualizacion de un video

**Precondiciones:**
- Usuario debe estar autenticado
- Episodio de curso debe existir
- Video debe estar en reproduccion

**Flujo Básico:**

| Paso | Actor | Sistema |
|------|-------|---------|
| 1 | Usuario selecciona episodio de curso | - |
| 2 | - | Inicializa reproductor YouTube |
| 3 | Usuario presiona "Play" | - |
| 4 | - | Inicia timer cada 15 segundos |
| 5 | - | Obtiene tiempo actual del reproductor |
| 6 | - | Envia PATCH /video_progress con segundos |
| 7 | - | Busca o crea VideoProgress |
| 8 | - | Actualiza seconds_watched |
| 9 | - | Verifica si >= 90% de duracion |
| 10 | - | Si si, marca completed = true |
| 11 | - | Confirma guardado |

**Flujo Alternativo:**

| Paso | Condicion | Accion |
|------|-----------|--------|
| 9a | seconds_watched < 90% | completed permanece false |
| 10 | Video terminado | Detiene timer, guarda progreso final |

**Postcondiciones:**
- VideoProgress actualizado con segundos vistos
- Si >= 90%, video marcado como completado
- Progreso visible en UI de episodios

### Diagrama de Secuencia

```plantuml
@startuml
skinparam sequenceFontSize 10
skinparam noteFontSize 9

title Trackear Progreso de Video - Secuencia

actor ":Usuario" as usuario
boundary ":VideoPlayerController (JS)" as jsPlayer
boundary ":VideoProgressesController" as controller
entity ":VideoProgress" as model
database ":PostgreSQL" as db

== Inicializacion ==

usuario -> jsPlayer : connect()
jsPlayer -> jsPlayer : loadYouTubeAPI()
jsPlayer -> jsPlayer : initPlayer(youtubeId)
jsPlayer --> usuario : YouTube Player listo

== Reproduccion y Tracking ==

usuario -> jsPlayer : playVideo()
jsPlayer -> jsPlayer : startProgressTracking()
jsPlayer -> jsPlayer : [interval: 15000ms]

loop Cada 15 segundos mientras reproduce
  jsPlayer -> jsPlayer : getCurrentTime()
  jsPlayer -> controller : PATCH /video_progress\n{course_episode_id: 1, seconds_watched: 120}
  controller -> model : upsert(params)
  model -> db : BEGIN TRANSACTION
  model -> db : SELECT * FROM video_progresses\nWHERE user_id = ? AND course_episode_id = ?
  db --> model : [progress existente]

  alt No existe progreso
    model -> db : INSERT INTO video_progresses\n(user_id, course_episode_id, seconds_watched, completed, ...)
  else Existe progreso
    model -> db : UPDATE video_progresses\nSET seconds_watched = ?
  end

  model -> model : checkCompletion()
  alt seconds_watched / duration >= 0.9
    model -> db : UPDATE video_progresses SET completed = true
  end

  db --> model : [progress actualizado]
  model --> controller : { status: ok, completed: true/false }
  controller --> jsPlayer : { json }
  jsPlayer -> jsPlayer : updateUI()
end

== Pausa del Video ==

usuario -> jsPlayer : pauseVideo()
jsPlayer -> jsPlayer : stopProgressTracking()
jsPlayer -> controller : PATCH /video_progress (ultimo estado)
controller --> jsPlayer : { status: ok }

note right of model
  checkCompletion():
  if seconds_watched >= duration * 0.9
    completed = true
end note

note right of jsPlayer
  Timer se limpia con clearInterval()
  al pausar o terminar el video
end note

@enduml
```

---

## Caso de Uso: Gestionar Categorias (Admin)

**Actor:** Administrador

**Objetivo:** Mantener el catalogo de categorias

**Precondiciones:**
- Usuario debe tener rol admin = true

**Flujo Básico:**

| Paso | Actor | Sistema |
|------|-------|---------|
| 1 | Admin accede a /admin/categories | - |
| 2 | - | Lista todas las categorias |
| 3 | Admin presiona "Nueva Categoria" | - |
| 4 | Admin completa: nombre, descripcion | - |
| 5 | Admin presiona "Guardar" | - |
| 6 | - | Genera slug desde nombre |
| 7 | - | Valida campos requeridos |
| 8 | - | Crea Category en base de datos |
| 9 | - | Confirma con mensaje |

**Flujo de Edicion:**

| Paso | Actor | Sistema |
|------|-------|---------|
| 1 | Admin presiona "Editar" en categoria | - |
| 2 | - | Muestra formulario con datos actuales |
| 3 | Admin modifica campos | - |
| 4 | Admin presiona "Actualizar" | - |
| 5 | - | Actualiza Category |
| 6 | - | Confirma con mensaje |

**Flujo de Eliminacion:**

| Paso | Actor | Sistema |
|------|-------|---------|
| 1 | Admin presiona "Eliminar" | - |
| 2 | - | Verifica si hay herramientas asociadas |
| 3a | Hay herramientas | Muestra error, no permite eliminar |
| 3b | No hay herramientas | Elimina Category |
| 4 | - | Confirma con mensaje |

---

## Caso de Uso: Gestionar Herramientas (Admin)

**Actor:** Administrador

**Objetivo:** Mantener el catalogo de herramientas

**Precondiciones:**
- Usuario debe tener rol admin = true
- Categorias deben existir

**Flujo Básico:**

| Paso | Actor | Sistema |
|------|-------|---------|
| 1 | Admin accede a /admin/tools/new | - |
| 2 | Admin completa formulario | - |
| 3 | Admin sube logo (opcional) | - |
| 4 | Admin presiona "Crear Herramienta" | - |
| 5 | - | Valida campos requeridos |
| 6 | - | Genera slug desde nombre |
| 7 | - | Almacena logo en Active Storage |
| 8 | - | Crea Tool en base de datos |
| 9 | - | Confirma con mensaje |

**Flujo de Eliminacion (CASCADE):**

| Paso | Actor | Sistema |
|------|-------|---------|
| 1 | Admin presiona "Eliminar" | - |
| 2 | - | Elimina FavoriteTools asociados |
| 3 | - | Elimina ContactMessages asociados |
| 4 | - | Elimina FeaturedItems asociados |
| 5 | - | Elimina registro de Tool |
| 6 | - | Elimina logo de Active Storage |

---

## Requerimientos Asociados

| Caso de Uso | Requerimientos |
|-------------|----------------|
| Agregar Favorito | RF-FAV-01, RF-FAV-05 |
| Quitar Favorito | RF-FAV-02, RF-FAV-04 |
| Trackear Progreso | RF-PROG-01, RF-PROG-02 |
| Marcar Completado | RF-PROG-03 |
| Gestionar Categorias | RF-CAT-01, RF-CAT-02, RF-CAT-03, RF-CAT-04 |
| Gestionar Herramientas | RF-TOOL-01, RF-TOOL-02, RF-TOOL-07, RF-TOOL-10 |
