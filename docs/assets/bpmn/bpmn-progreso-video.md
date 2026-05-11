# BPMN - Seguimiento de Progreso de Video

## Diagrama

```plantuml
@startuml bpmn-progreso-video
!theme plain
skinparam backgroundColor #0f1117
skinparam activity {
    BackgroundColor #1a1d24
    BorderColor #3a3f4a
    ArrowColor #6c8cff
    FontColor #c9d1d9
}
skinparam diamond {
    BackgroundColor #2a2d34
    BorderColor #6c8cff
    FontColor #c9d1d9
}

title Blackstone - Proceso de Seguimiento de Progreso de Video

start

:Usuario reproduce episodio de curso;

:Reproductor YouTube carga video;

:Usuario interactúa con el video;

repeat
    :Evento de reproducción (play/pause/seek);
    :Calcular segundos vistos;
    :Actualizar contador local;
    if (¿Han pasado 15 segundos?) then (sí)
        :Enviar progreso al servidor;
        :Actualizar VideoProgress en BD;
        if (¿seconds_watched > duración?) then (sí)
            :Limitar a duración máxima;
        endif
    else (no)
    endif
repeat while (¿Video en reproducción?) is (sí)
->no;

if (¿Progreso >= 90%?) then (sí)
    :Marcar episodio como completado;
    :Actualizar completed = true;
    :Notificar al usuario;
else (no)
    :Guardar progreso parcial;
endif

:Usuario continúa o cambia episodio;

stop

@enduml
```

## Descripción del proceso

Este diagrama modela el sistema de seguimiento de progreso de videos:

1. **Reproducción**: El usuario inicia un episodio de curso
2. **Monitoreo continuo**: Eventos de play/pause/seek se monitorean
3. **Auto-guardado**: Cada 15 segundos se envía progreso al servidor
4. **Validación**: Se previene abuso limitando seconds_watched a la duración máxima
5. **Completado**: Al alcanzar 90% se marca como completado

## Componentes técnicos

- `video_player_controller.js` - Stimulus controller para YouTube API
- `VideoProgress` model - Almacena progreso por usuario y episodio
- `video_progresses_controller.rb` - Endpoint para guardar progreso
