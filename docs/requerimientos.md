# Requerimientos - Blackstone

## 1. Requerimientos Funcionales

### 1.1 Sistema de Autenticación

| ID | Descripción | Prioridad | Módulo |
|----|-------------|-----------|--------|
| RF-AUTH-01 | El sistema debe permitir registrar usuarios con email, password y nombre | Alta | Auth |
| RF-AUTH-02 | El sistema debe permitir iniciar sesión con email y password | Alta | Auth |
| RF-AUTH-03 | El sistema debe permitir cerrar sesión | Alta | Auth |
| RF-AUTH-04 | El sistema debe permitir resetear contraseña | Alta | Auth |
| RF-AUTH-05 | El sistema debe recordar sesión con "recordarme" | Media | Auth |
| RF-AUTH-06 | El sistema debe distinguir entre usuarios regulares y administradores | Alta | Auth |

### 1.2 Gestión de Categorías

| ID | Descripción | Prioridad | Módulo |
|----|-------------|-----------|--------|
| RF-CAT-01 | El admin debe poder crear categorías con nombre, descripción y slug | Alta | Admin |
| RF-CAT-02 | El admin debe poder editar categorías existentes | Alta | Admin |
| RF-CAT-03 | El admin debe poder eliminar categorías | Alta | Admin |
| RF-CAT-04 | El sistema debe generar slug automáticamente desde el nombre | Alta | Core |
| RF-CAT-05 | El sistema debe listar todas las categorías | Alta | Public |
| RF-CAT-06 | El sistema debe mostrar las herramientas de una categoría | Alta | Public |

### 1.3 Gestión de Herramientas

| ID | Descripción | Prioridad | Módulo |
|----|-------------|-----------|--------|
| RF-TOOL-01 | El admin debe poder crear herramientas con nombre, descripción, URL | Alta | Admin |
| RF-TOOL-02 | El admin debe poder asignar categoría a una herramienta | Alta | Admin |
| RF-TOOL-03 | El admin debe poder marcar si es open source | Media | Admin |
| RF-TOOL-04 | El admin debe poder marcar si tiene free tier | Media | Admin |
| RF-TOOL-05 | El admin debe poder asignar plataforma (Web, Windows, Mac, Linux, Multiplataforma) | Media | Admin |
| RF-TOOL-06 | El admin debe poder asignar nivel (Principiante, Normal, Intermedio, Avanzado, Cualquiera) | Media | Admin |
| RF-TOOL-07 | El admin debe poder subir logo para la herramienta | Alta | Admin |
| RF-TOOL-08 | El sistema debe listar todas las herramientas | Alta | Public |
| RF-TOOL-09 | El sistema debe mostrar detalle de una herramienta | Alta | Public |
| RF-TOOL-10 | El sistema debe generar slug automáticamente | Alta | Core |

### 1.4 Gestión de Cursos

| ID | Descripción | Prioridad | Módulo |
|----|-------------|-----------|--------|
| RF-COURSE-01 | El admin debe poder crear cursos con título, descripción | Alta | Admin |
| RF-COURSE-02 | El admin debe poder indicar si es serie o video único | Alta | Admin |
| RF-COURSE-03 | El admin debe poder crear episodios con título, URL de YouTube | Alta | Admin |
| RF-COURSE-04 | El sistema debe extraer automáticamente el YouTube ID | Alta | Core |
| RF-COURSE-05 | El sistema debe mostrar reproductor YouTube embebido | Alta | Public |
| RF-COURSE-06 | El sistema debe listar episodios ordenados por posición | Alta | Public |

### 1.5 Sistema de Favoritos

| ID | Descripción | Prioridad | Módulo |
|----|-------------|-----------|--------|
| RF-FAV-01 | El usuario debe poder agregar herramientas a favoritos | Alta | Favoritos |
| RF-FAV-02 | El usuario debe poder quitar herramientas de favoritos | Alta | Favoritos |
| RF-FAV-03 | El usuario debe poder agregar cursos a favoritos | Alta | Favoritos |
| RF-FAV-04 | El usuario debe poder quitar cursos de favoritos | Alta | Favoritos |
| RF-FAV-05 | El sistema debe prevenir duplicados (mismo item dos veces) | Alta | Core |
| RF-FAV-06 | El sistema debe mostrar lista de favoritos del usuario | Alta | Public |

### 1.6 Progreso de Video

| ID | Descripción | Prioridad | Módulo |
|----|-------------|-----------|--------|
| RF-PROG-01 | El sistema debe guardar progreso cada 15 segundos | Alta | Progreso |
| RF-PROG-02 | El sistema debe permitir retomar donde se quedó | Alta | Progreso |
| RF-PROG-03 | El sistema debe marcar como completado al 90% | Alta | Progreso |
| RF-PROG-04 | El usuario debe ver su progreso en lista de episodios | Alta | Public |

### 1.7 Sistema de Contacto

| ID | Descripción | Prioridad | Módulo |
|----|-------------|-----------|--------|
| RF-CONTACT-01 | El usuario debe poder enviar mensaje de contacto | Alta | Contacto |
| RF-CONTACT-02 | El usuario debe poder especificar tipo (sugerencia, reclamo, link_roto, otro) | Media | Contacto |
| RF-CONTACT-03 | El admin debe poder ver mensajes recibidos | Alta | Admin |
| RF-CONTACT-04 | El admin debe poder marcar mensajes como leídos | Media | Admin |
| RF-CONTACT-05 | El admin debe poder eliminar mensajes | Media | Admin |

### 1.8 Featured Item

| ID | Descripción | Prioridad | Módulo |
|----|-------------|-----------|--------|
| RF-FEAT-01 | El sistema debe mostrar una herramienta destacada en el home | Alta | Public |
| RF-FEAT-02 | El sistema debe seleccionar herramienta aleatoria si no hay featured para hoy | Media | Core |

---

## 2. Requerimientos No Funcionales

### 2.1 Performance

| ID | Descripción | Criterio |
|----|-------------|----------|
| RNF-PERF-01 | Tiempo de carga del home | < 2 segundos |
| RNF-PERF-02 | Tiempo de guardado de progreso | < 500ms |
| RNF-PERF-03 | Tiempo de respuesta de API | < 300ms |

### 2.2 Seguridad

| ID | Descripción | Criterio |
|----|-------------|----------|
| RNF-SEC-01 | Contraseñas encriptadas | BCrypt |
| RNF-SEC-02 | Protección CSRF | Tokens en todos los forms |
| RNF-SEC-03 | Acceso admin restringido | Solo usuarios admin |

### 2.3 Usabilidad

| ID | Descripción | Criterio |
|----|-------------|----------|
| RNF-USAB-01 | Diseño responsive | Mobile, tablet, desktop |
| RNF-USAB-02 | Dark theme | Estilo Resend |
| RNF-USAB-03 | Navegación intuitiva | Máximo 3 clicks para cualquier acción |

### 2.4 Disponibilidad

| ID | Descripción | Criterio |
|----|-------------|----------|
| RNF-DISP-01 | Uptime | 99% (objetivo) |
| RNF-DISP-02 | Recuperación de errores | Graceful degradation |

### 2.5 Mantenibilidad

| ID | Descripción | Criterio |
|----|-------------|----------|
| RNF-MANT-01 | Convenciones Rails | Seguir guías oficial |
| RNF-MANT-02 | Documentación | Código documentado + docs |
| RNF-MANT-03 | Tests | Coverage mínimo 70% (objetivo) |

---

## 3. Reglas de Negocio

| ID | Regla | Validación |
|----|-------|-----------|
| RN-01 | El slug de categorías y herramientas debe ser único | Uniqueness |
| RN-02 | Un usuario no puede favoritear la misma herramienta dos veces | Uniqueness scope: user_id |
| RN-03 | Un usuario no puede favoritear el mismo curso dos veces | Uniqueness scope: user_id |
| RN-04 | El progreso de video es único por usuario y episodio | Uniqueness scope: user_id + course_episode_id |
| RN-05 | El video se marca completado cuando seconds_watched / duration >= 0.9 | Calculation |
| RN-06 | El YouTube ID se extrae automáticamente de la URL | Parser en before_save |
| RN-07 | Solo admins pueden acceder al panel de administración | Authorization check |
| RN-08 | Las categorías no se eliminan si tienen herramientas asociadas | dependent: :restrict_with_error |

---

## 4. Restricciones

| ID | Restricción | Notas |
|----|-------------|-------|
| REST-01 | PostgreSQL 14+ | Base de datos |
| REST-02 | Ruby 3.3.0 | Lenguaje |
| REST-03 | Rails 7.1.3 | Framework |
| REST-04 | Solo frontend web | No app móvil inicialmente |
| REST-05 | Solo español | Idioma de interfaz |

---

## 5. Suposiciones

| ID | Suposición |
|----|------------|
| SUP-01 | Los usuarios tienen conexión a internet |
| SUP-02 | Los usuarios saben usar YouTube |
| SUP-03 | El contenido de YouTube es accesible |
| SUP-04 | Los estudiantes tienen dispositivos modernos |
| SUP-05 | No se requiere offline mode |

---

*Versión 1.0 - Blackstone*
