# API - Blackstone

## 1. Endpoints

### 1.1 Progreso de Video

#### Guardar Progreso

```
PATCH /video_progress
```

**Headers:**
```
Content-Type: application/json
X-User-Email: usuario@ejemplo.com
X-User-Token: token_del_usuario
```

**Body:**
```json
{
  "course_episode_id": 1,
  "seconds_watched": 120
}
```

**Respuesta (200):**
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

**Respuesta (401 - Sin autenticar):**
```json
{
  "status": "unauthorized",
  "message": "Debes iniciar sesión"
}
```

---

### 1.2 Favoritos de Herramientas

#### Agregar a Favoritos

```
POST /favorite_tools
```

**Headers:**
```
Content-Type: application/json
```

**Body:**
```json
{
  "tool_id": 1
}
```

**Respuesta (201):**
```json
{
  "status": "created",
  "message": "Herramienta agregada a favoritos",
  "data": {
    "id": 1,
    "tool_id": 1
  }
}
```

**Respuesta (422 - Ya existe):**
```json
{
  "status": "error",
  "message": "ya está en tus favoritos"
}
```

#### Quitar de Favoritos

```
DELETE /favorite_tools/:id
```

**Respuesta (200):**
```json
{
  "status": "ok",
  "message": "Herramienta eliminada de favoritos"
}
```

---

### 1.3 Favoritos de Cursos

#### Agregar a Favoritos

```
POST /favorite_courses
```

**Body:**
```json
{
  "course_id": 1
}
```

**Respuesta (201):**
```json
{
  "status": "created",
  "message": "Curso agregado a favoritos",
  "data": {
    "id": 1,
    "course_id": 1
  }
}
```

#### Quitar de Favoritos

```
DELETE /favorite_courses/:id
```

---

### 1.4 Mensajes de Contacto

#### Enviar Mensaje

```
POST /contact_messages
```

**Body:**
```json
{
  "name": "Usuario",
  "email": "usuario@ejemplo.com",
  "message_type": "sugerencia",
  "body": "Consideren agregar la herramienta XYZ",
  "tool_id": null
}
```

**Tipos de mensaje:**
- `sugerencia` - Sugerencia de nueva herramienta o mejora
- `reclamo` - Queja o problema
- `link_roto` - Reporte de enlace roto
- `otro` - Otro tipo de mensaje

**Respuesta (201):**
```json
{
  "status": "created",
  "message": "Mensaje enviado correctamente"
}
```

**Respuesta (422 - Validación fallida):**
```json
{
  "status": "error",
  "message": "Email no puede estar vacío"
}
```

---

## 2. Autenticación API

### 2.1 Métodos Soportados

| Método | Descripción |
|--------|-------------|
| **Devise Token Auth** | Usar tokens de sesión Devise |
| **Cookie Session** | Sesión por cookie (método default) |

### 2.2 Con Cookie de Sesión

Para endpoints que requieren autenticación, el usuario debe haber iniciado sesión previamente. Rails maneja la cookie automáticamente.

### 2.3 Con Token (X-User-Token)

Para APIs externas o testing:

```bash
# Obtener token al iniciar sesión
curl -X POST http://localhost:3000/users/sign_in \
  -d "user[email]=test@example.com" \
  -d "user[password]=password123"
```

Rails genera una cookie de sesión válida.

---

## 3. Respuestas JSON

### 3.1 Formato Estándar

```json
{
  "status": "ok" | "error" | "created" | "unauthorized",
  "message": "Descripción del resultado",
  "data": { ... } // Opcional
}
```

### 3.2 Códigos de Estado HTTP

| Código | Significado |
|--------|-------------|
| 200 | OK |
| 201 | Creado |
| 204 | Sin contenido |
| 401 | No autorizado |
| 404 | No encontrado |
| 422 | Validación fallida |
| 500 | Error del servidor |

---

## 4. Rutas Resumen

| Método | Ruta | Controlador | Acción |
|--------|------|-------------|--------|
| GET | `/` | home | index |
| GET | `/categories` | categories | index |
| GET | `/categories/:id` | categories | show |
| GET | `/tools` | tools | index |
| GET | `/tools/:id` | tools | show |
| GET | `/courses` | courses | index |
| GET | `/courses/:id` | courses | show |
| GET | `/mis-favoritos` | favorites | index |
| PATCH | `/video_progress` | video_progresses | upsert |
| POST | `/favorite_tools` | favorite_tools | create |
| DELETE | `/favorite_tools/:id` | favorite_tools | destroy |
| POST | `/favorite_courses` | favorite_courses | create |
| DELETE | `/favorite_courses/:id` | favorite_courses | destroy |
| POST | `/contact_messages` | contact_messages | create |
| GET | `/admin` | admin/dashboard | index |
| GET | `/admin/categories` | admin/categories | index |
| POST | `/admin/categories` | admin/categories | create |
| GET | `/admin/categories/new` | admin/categories | new |
| GET | `/admin/categories/:id/edit` | admin/categories | edit |
| PATCH | `/admin/categories/:id` | admin/categories | update |
| DELETE | `/admin/categories/:id` | admin/categories | destroy |
| GET | `/admin/tools` | admin/tools | index |
| POST | `/admin/tools` | admin/tools | create |
| GET | `/admin/tools/new` | admin/tools | new |
| GET | `/admin/tools/:id/edit` | admin/tools | edit |
| PATCH | `/admin/tools/:id` | admin/tools | update |
| DELETE | `/admin/tools/:id` | admin/tools | destroy |
| GET | `/admin/courses` | admin/courses | index |
| POST | `/admin/courses` | admin/courses | create |
| GET | `/admin/courses/:id` | admin/courses | show |
| GET | `/admin/courses/:id/episodes/new` | admin/course_episodes | new |
| POST | `/admin/courses/:id/episodes` | admin/course_episodes | create |
| PATCH | `/admin/courses/:course_id/episodes/:id` | admin/course_episodes | update |
| DELETE | `/admin/courses/:course_id/episodes/:id` | admin/course_episodes | destroy |
| GET | `/admin/contact_messages` | admin/contact_messages | index |
| GET | `/admin/contact_messages/:id` | admin/contact_messages | show |
| PATCH | `/admin/contact_messages/:id/mark_read` | admin/contact_messages | mark_read |
| DELETE | `/admin/contact_messages/:id` | admin/contact_messages | destroy |
| GET | `/admin/users` | admin/users | index |
| PATCH | `/admin/users/:id/toggle_admin` | admin/users | toggle_admin |

---

*Versión 1.0 - Blackstone*
