# Diagrama de Actividades - Flujo de Usuario Registrado

```plantuml
@startuml
skinparam activityFontSize 10
skinparam noteFontSize 9

title Diagrama de Actividades - Flujo de Usuario Registrado

| :Actor: |
start

:Visitar homepage;
:Ver herramienta destacada;
if (Hay featured item hoy?) then (No)
  :Sistema selecciona herramienta aleatoria;
  :Crear FeaturedItem para hoy;
endif

:Explorar categorías en carousel;
if (Click en categoría?) then (Sí)
  :Navegar a /categories/:id;
  :Mostrar herramientas de la categoría;
  if (Click en herramienta?) then (Sí)
    :Navegar a /tools/:id;
    :Mostrar detalle;
    if (Agregar a favoritos?) then (Sí)
      :Verificar no esté en favoritos;
      :Crear FavoriteTool;
      :Mostrar confirmación;
    endif;
  endif;
else (No)
  :Ver lista de cursos;
endif;

if (Click en curso?) then (Sí)
  :Navegar a /courses/:id;
  :Mostrar episodios;
  if (Click en episodio?) then (Sí)
    :Reproducir video YouTube;
    :Iniciar tracking cada 15s;
    if (Video completado >= 90%?) then (Sí)
      :Marcar VideoProgress.completed = true;
    endif;
    if (Usuario guarda favorito?) then (Sí)
      :Crear FavoriteCourse;
    endif;
  endif;
endif;

if (Ir a Mis Favoritos?) then (Sí)
  :Navegar a /mis-favoritos;
  :Mostrar herramientas y cursos favoritos;
  if (Quitar favorito?) then (Sí)
    :Eliminar FavoriteTool/Course;
  endif;
endif;

if (Enviar mensaje de contacto?) then (Sí)
  :Abrir modal de contacto;
  :Seleccionar tipo de mensaje;
  :Enviar ContactMessage;
endif;

stop

note right
  Validación uniqueness scope: [user_id, tool_id]
  Mensaje error: ya está en tus favoritos
end note

note right
  Cálculo: seconds_watched / duration >= 0.9
end note

@enduml
```

## Flujo de Usuario Registrado

### 1. Home y Descubrimiento
1. Usuario visita homepage
2. Sistema verifica si hay featured item para hoy
3. Si no hay, selecciona herramienta aleatoria
4. Usuario explora categorías en carousel

### 2. Exploración de Herramientas
1. Click en categoría → lista herramientas
2. Click en herramienta → detalle
3. Opcional: agregar a favoritos

### 3. Cursos y Progreso
1. Usuario selecciona curso
2. Ve lista de episodios
3. Reproduce episodio
4. Sistema guarda progreso cada 15s
5. Si >= 90%, marca como completado

### 4. Favoritos
1. Usuario accede a `/mis-favoritos`
2. Ve herramientas y cursos guardados
3. Puede eliminar favoritos

### 5. Contacto
1. Abre modal de contacto
2. Selecciona tipo de mensaje
3. Envía mensaje al admin
