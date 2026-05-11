# Diagrama de Secuencia - Sistema de Favoritos

```plantuml
@startuml

title Diagrama de Secuencia - Agregar Herramienta a Favoritos

actor ":Usuario" as usuario
boundary ":FavoritesController" as controller
boundary ":FavoriteToolsController" as favController
entity ":FavoriteTool" as model
database ":Database" as db

== Flujo Principal: Ver Favoritos ==

usuario -> controller : GET /mis-favoritos
controller -> controller : authenticate_user!
controller -> favController : index
favController -> db : SELECT * FROM favorite_tools WHERE user_id = ?
db --> favController : [lista_favoritos]
favController --> usuario : Renderiza /favorites/index.html.erb

== Flujo: Agregar Herramienta a Favoritos ==

usuario -> controller : POST /favorite_tools
controller -> favController : create
favController -> favController : favorite_tool_params
favController -> model : new
model -> db : BEGIN TRANSACTION
db --> model : OK
model -> db : INSERT INTO favorite_tools (user_id, tool_id, created_at, updated_at)
db --> model : [favorite_tool creado]
model --> favController : [favorite_tool]
favController -> db : COMMIT
favController --> usuario : redirect_to :back, notice: "Agregada"

note right of controller
  Validación: verifica que no exista duplicado
  Message: "ya está en tus favoritos"
end note

== Flujo: Quitar de Favoritos ==

usuario -> controller : DELETE /favorite_tools/:id
controller -> favController : destroy
favController -> model : find(params[:id])
model -> db : SELECT * FROM favorite_tools WHERE id = ?
db --> model : [favorite_tool]
model -> db : DELETE FROM favorite_tools WHERE id = ?
model --> favController : [destruido]
favController --> usuario : redirect_to :back

@enduml
```

## Descripción del Flujo

### 1. Ver Favoritos
El usuario autenticado accede a `/mis-favoritos`. El sistema verifica su sesión, consulta los favoritos del usuario y los muestra.

### 2. Agregar a Favoritos
1. Usuario presiona "Agregar a Favoritos" en una herramienta
2. Sistema crea registro `FavoriteTool` con `user_id` y `tool_id`
3. Validación: no permite duplicados (unique scope)

### 3. Quitar de Favoritos
1. Usuario presiona "Eliminar" en `/mis-favoritos`
2. Sistema busca y elimina el registro `FavoriteTool`

## Escenarios Alternativos

| Escenario | Condición | Resultado |
|-----------|----------|-----------|
| Usuario no autenticado | Intentando agregar | Redirige a login |
| Duplicado | Herramienta ya en favoritos | Muestra mensaje de error |
| Registro no existe | ID inválido al eliminar | Error 404 |
