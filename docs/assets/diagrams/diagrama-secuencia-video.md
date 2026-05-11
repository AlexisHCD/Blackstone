# Diagrama de Secuencia - Tracking de Progreso de Video

```plantuml
@startuml

title Diagrama de Secuencia - Tracking de Progreso de Video

actor ":Usuario" as usuario
boundary ":VideoPlayerController (JS)" as jsPlayer
boundary ":VideoProgressesController" as controller
entity ":VideoProgress" as model
database ":Database" as db

== Inicialización del Reproductor ==

usuario -> jsPlayer : connect()
jsPlayer -> jsPlayer : loadYouTubeAPI()
jsPlayer -> jsPlayer : initPlayer(youtubeId)
jsPlayer --> usuario : YouTube Player listo

== Reproducción y Tracking ==

usuario -> jsPlayer : playVideo()
jsPlayer -> jsPlayer : startProgressTracking()
jsPlayer -> jsPlayer : [interval: 15000ms]

loop Cada 15 segundos mientras reproduce
  jsPlayer -> jsPlayer : getCurrentTime()
  jsPlayer -> controller : PATCH /video_progress
  controller -> model : upsert(params)
  model -> db : BEGIN TRANSACTION
  model -> db : SELECT * FROM video_progresses WHERE user_id = ? AND course_episode_id = ?
  db --> model : [progress existente]
  alt No existe progreso
    model -> db : INSERT INTO video_progresses (user_id, course_episode_id, seconds_watched, completed, ...)
  else Existe progreso
    model -> db : UPDATE video_progresses SET seconds_watched = ?
  end
  model -> model : checkCompletion()
  alt seconds_watched / duration >= 0.9
    model -> db : UPDATE video_progresses SET completed = true
  end
  db --> model : [progress actualizado]
  model --> controller : { status: "ok", completed: true/false }
  controller --> jsPlayer : { json }
  jsPlayer -> jsPlayer : updateUI()
end

== Pausa del Video ==

usuario -> jsPlayer : pauseVideo()
jsPlayer -> jsPlayer : stopProgressTracking()
jsPlayer -> controller : PATCH /video_progress (último estado)
controller --> jsPlayer : { status: "ok" }

note right of jsPlayer
  Timer se limpia con clearInterval()
  al pausar o terminar el video
end note

note right of model
  checkCompletion():
  if seconds_watched >= duration * 0.9
    completed = true
end note

@enduml
```

## Descripción del Flujo

### Inicialización
1. Stimulus controller se conecta al DOM
2. Carga YouTube IFrame API
3. Inicializa el reproductor con el `youtube_id`

### Tracking Automático
1. Cada **15 segundos** mientras el video reproduce:
   - Obtiene tiempo actual (`getCurrentTime()`)
   - Envía PATCH al servidor con segundos
2. Servidor busca o crea `VideoProgress`
3. Verifica completion (>= 90%)

### Completion
Cuando `seconds_watched / duration >= 0.9`:
- `completed` se marca como `true`
- UI se actualiza para mostrar checkmark

## Parámetros del Endpoint

```json
PATCH /video_progress
{
  "course_episode_id": 1,
  "seconds_watched": 120
}
```

## Respuesta del Servidor

```json
{
  "status": "ok",
  "data": {
    "id": 1,
    "course_episode_id": 1,
    "seconds_watched": 120,
    "completed": false,
    "duration_seconds": 600
  }
}
```
