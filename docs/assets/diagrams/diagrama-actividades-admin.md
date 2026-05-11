# Diagrama de Actividades - Flujo Admin Panel

```plantuml
@startuml
skinparam activityFontSize 10
skinparam noteFontSize 9

title Diagrama de Actividades - Flujo Admin Panel

| :Administrador: |
start

:Acceder a /admin;
:Authenticate_admin!;
if (Usuario es admin?) then (Si)
  :Mostrar dashboard admin;
  :Listar opciones de gestion;
  if (Gestionar Categorias?) then (Si)
    :Ir a /admin/categories;
    if (Nueva categoria?) then (Si)
      :Formulario de creacion;
      :Validar nombre y descripcion;
      :Generar slug automatico;
      :Crear Category;
    elseif (Editar?) then (Si)
      :Formulario de edicion;
      :Actualizar Category;
    elseif (Eliminar?) then (Si)
      if (Tiene herramientas asociadas?) then (Si)
        :Bloquear eliminacion;
        :Mensaje de error;
      else (No)
        :Eliminar Category;
      endif;
    endif;
  endif;

  if (Gestionar Herramientas?) then (Si)
    :Ir a /admin/tools;
    if (Nueva herramienta?) then (Si)
      :Formulario con logo (Active Storage);
      :Seleccionar categoria;
      :Marcar open_source, free_tier;
      :Definir platform y level;
      :Crear Tool;
    elseif (Editar?) then (Si)
      :Actualizar datos;
      :Subir nuevo logo si aplica;
    elseif (Eliminar?) then (Si)
      :Eliminar Tool + FavoriteTools asociados;
    endif;
  endif;

  if (Gestionar Cursos?) then (Si)
    :Ir a /admin/courses;
    if (Nuevo curso?) then (Si)
      :Formulario con titulo y descripcion;
      :Marcar is_series;
      :Seleccionar categoria;
      :Crear Course;
      :Agregar episodios;
    elseif (Gestionar Episodios?) then (Si)
      :Ir a /admin/courses/:id/episodes;
      :Agregar YouTube URL;
      :Auto-extraer youtube_id;
      :Definir posicion y duracion;
    endif;
  endif;

  if (Gestionar Mensajes?) then (Si)
    :Ir a /admin/contact_messages;
    :Ver lista de mensajes;
    :Filtrar por tipo y estado (leido/no leido);
    if (Marcar como leido?) then (Si)
      :Update read = true;
    elseif (Eliminar?) then (Si)
      :Eliminar ContactMessage;
    endif;
  endif;

  if (Gestionar Usuarios?) then (Si)
    :Ir a /admin/users;
    :Ver lista de usuarios;
    :Ver email, nombre, admin?;
    if (Toggle admin?) then (Si)
      :Update admin = true/false;
      :No permitir revocarse a si mismo;
    endif;
  endif;
else (No)
  :Redirect a /;
  :Mostrar mensaje de acceso denegado;
endif;

stop

note right
  current_user.id != params[:id]
  No se permite revocarse admin a si mismo
end note

@enduml
```

## Flujo del Administrador

### 1. Autenticacion
1. Admin accede a /admin
2. Sistema verifica authenticate_user!
3. Sistema verifica authenticate_admin!
4. Si no es admin -> redirect con error

### 2. Gestion de Categorias (CRUD)
- **Crear**: Nombre, descripcion -> slug auto-generado
- **Editar**: Modificar datos existentes
- **Eliminar**: Bloqueado si tiene herramientas asociadas

### 3. Gestion de Herramientas (CRUD)
- **Crear**: Formulario completo con logo (Active Storage)
- **Editar**: Actualizar cualquier campo
- **Eliminar**: CASCADE elimina favoritos asociados

### 4. Gestion de Cursos (CRUD)
- **Crear**: Titulo, descripcion, is_series, categoria
- **Gestionar Episodios**: YouTube URL -> auto-extrae youtube_id
- **Eliminar**: CASCADE elimina episodios

### 5. Gestion de Mensajes
- **Ver**: Lista filtrable por tipo y estado
- **Marcar leido**: Update read = true
- **Eliminar**: Eliminacion directa

### 6. Gestion de Usuarios
- **Ver**: Lista de usuarios con email, nombre, rol
- **Toggle Admin**: Cambiar admin de otros usuarios
- **Restriccion**: No puede revocarse admin a si mismo
