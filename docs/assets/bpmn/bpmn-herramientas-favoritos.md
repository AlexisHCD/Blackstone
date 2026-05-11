# BPMN - Exploración y Favoritos de Herramientas

## Diagrama

```plantuml
@startuml bpmn-herramientas-favoritos
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

title Blackstone - Proceso de Exploración y Favoritos de Herramientas

start

:Usuario navega a herramientas;

if (¿Autenticado?) then (no)
    :Mostrar herramientas públicas;
    :Opción de favoritos deshabilitada;
else (sí)
    :Mostrar herramientas con favoritos;
endif

:Usuario filtra por categoría/plataforma/nivel;

:Selecciona una herramienta;

:Ver detalles de la herramienta;

if (¿Usuario autenticado?) then (sí)
    if (¿Acción?) then (agregar favorito)
        :Verificar si ya es favorito;
        if (¿Ya existe?) then (sí)
            :Mostrar mensaje "ya está en favoritos";
        else (no)
            :Crear FavoriteTool en BD;
            :Actualizar UI (corazón relleno);
        endif
    else (remover favorito)
        :Eliminar FavoriteTool de BD;
        :Actualizar UI (corazón vacío);
    else (visitar herramienta)
        :Redirigir a URL externa;
    endif
else (no)
    :Redirigir a login;
    :Guardar URL de retorno;
endif

stop

@enduml
```

## Descripción del proceso

Este diagrama modela el flujo de exploración y gestión de favoritos de herramientas:

1. **Navegación**: Acceso a herramientas (público o autenticado)
2. **Filtrado**: Por categoría, plataforma y nivel
3. **Favoritos**: Agregar/remover con validación de duplicados
4. **Redirección**: Login requerido para favoritos con URL de retorno

## Componentes técnicos

- `tools_controller.rb` - Listado y filtrado de herramientas
- `favorite_tools_controller.rb` - CRUD de favoritos
- `FavoriteTool` model - Con validación de unicidad scopeada
