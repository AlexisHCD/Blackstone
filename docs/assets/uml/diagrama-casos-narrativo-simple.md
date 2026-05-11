# Diagrama de Casos de Uso Narrativo - Historia de Usuario

## Historia: El Estudiante y los Favoritos

### Narrativa

> **Maria**, estudiante de 22 anos, quiere organizar su aprendizaje.
> Un dia descubre **Blackstone** mientras busca herramientas para programar.
> Se registra, explora categorias, guarda favoritos y sigue un curso de Ruby.
> Esta es su historia.

---

### Actor Principal

| Actor | Descripcion |
|-------|-------------|
| **Maria** | Estudiante universitaria de Ingenieria en Sistemas, 22 anos |

### Actores Secundarios

| Actor | Descripcion |
|-------|-------------|
| **Sistema Blackstone** | La plataforma que provee contenido y funcionalidades |
| **YouTube** | Servidor externo que provee los videos de los cursos |

---

## Caso de Uso: Descubrimiento y Registro

### Narrativa Simple

```
Maria estaba buscando herramientas para aprender Ruby on Rails.
 encontro Blackstone en Google y decidio probarlo.
 Se registro con su email y comenzo a explorar.
```

### Diagrama de Actores

```plantuml
@startuml
skinparam actorFontSize 12
skinparam noteFontSize 10

title Historia de Maria - Descubrimiento y Registro

actor Maria
actor ":Sistema Blackstone" as sistema

== Registro ==

Maria -> sistema : Visit www.blackstone.dev
sistema --> Maria : Pagina de inicio (sin auth)
Maria -> sistema : Click en "Registrarse"
sistema --> Maria : Formulario de registro
Maria -> sistema : Completa: nombre, email, password
sistema --> Maria : Crea cuenta, envia a home
Maria -> sistema : Explora categorias

note right of sistema
  Devise crea usuario con admin=false
end note

== Navegacion ==

Maria -> sistema : Explora carousel de categorias
sistema --> Maria : Muestra 6 categorias
Maria -> sistema : Click en "Desarrollo Web"
sistema --> Maria : Lista 8 herramientas
Maria -> sistema : Click en "Rails"
sistema --> Maria : Detalle de herramienta

@enduml
```

---

## Caso de Uso: Agregar a Favoritos

### Narrativa Simple

```
Maria encontro una herramienta que le gusto.
 La agregue a favoritos para no olvidarla.
 Ahora puede verla anytime en "Mis Favoritos".
```

### Diagrama de Actores

```plantuml
@startuml
skinparam actorFontSize 12
skinparam noteFontSize 10

title Historia de Maria - Sistema de Favoritos

actor Maria
actor ":Sistema Blackstone" as sistema

== Agregar a Favoritos ==

Maria -> sistema : En herramienta, click "Agregar a Favoritos"
sistema -> sistema : Verifica autenticacion
alt No autenticada
  sistema --> Maria : Redirect a login
else Autenticada
  sistema -> sistema : Verifica duplicado
  alt Ya esta en favoritos
    sistema --> Maria : Alerta "ya esta en tus favoritos"
  else No esta en favoritos
    sistema -> sistema : Crea FavoriteTool
    sistema --> Maria : Notificacion "Agregada"
  end
end

== Ver Favoritos ==

Maria -> sistema : Click en "Mis Favoritos"
sistema --> Maria : Lista herramientas + cursos favoritos
Maria -> sistema : Ve su coleccion

note right of sistema
  Un solo lugar para herramientas y cursos
end note

@enduml
```

---

## Caso de Uso: Seguir un Curso

### Narrativa Simple

```
Maria encontro un curso de Git en video.
 Lo vio por 20 minutos (se guardo progreso).
 Al dia siguiente, retomo donde quedo.
 Completion al 90%, video marcado como completado.
```

### Diagrama de Actores

```plantuml
@startuml
skinparam actorFontSize 12
skinparam noteFontSize 10

title Historia de Maria - Progreso de Video

actor Maria
actor ":YouTube" as youtube
actor ":Sistema Blackstone" as sistema

== Iniciar Curso ==

Maria -> sistema : Click en curso "Git Fundamentals"
sistema --> Maria : Muestra episodios (ordenados por position)
Maria -> sistema : Click en Episodio 1
youtube --> sistema : Carga video YouTube embed
sistema --> Maria : Reproductor listo

== Reproduccion ==

Maria -> youtube : Presiona Play
youtube --> Maria : Video comienza
youtube -> sistema : getCurrentTime() cada 15s
sistema -> sistema : saveProgress(seconds_watched)
sistema --> youtube : Guardado confirmado

== Completar Video ==

alt 90% visto
  youtube -> sistema : seconds_watched / duration >= 0.9
  sistema -> sistema : Marcar completed = true
  sistema --> Maria : Checkmark verde en episodio
end

== Retomar ==

Maria -> sistema : Vuelve al dia siguiente
sistema --> Maria : Episodio 1 marcado "Completado"
Maria -> sistema : Click en Episodio 2
youtube --> Maria : Continua aprendizaje

note right of sistema
  Progreso persiste entre sesiones
end note

@enduml
```

---

## Caso de Uso: Feedback

### Narrativa Simple

```
Maria encontro un link roto en una herramienta.
 Abrio el modal de contacto en el footer.
 Selecciono "link_roto" y envio el mensaje.
 El admin lo recibio y lo corrigio.
```

### Diagrama de Actores

```plantuml
@startuml
skinparam actorFontSize 12
skinparam noteFontSize 10

title Historia de Maria - Sistema de Contacto

actor Maria
actor ":Administrador" as admin
actor ":Sistema Blackstone" as sistema

== Enviar Mensaje ==

Maria -> sistema : Click en modal de contacto (footer)
sistema --> Maria : Formulario de contacto
Maria -> sistema : Selecciona tipo "link_roto"
Maria -> sistema : Escribe mensaje
sistema -> sistema : Valida campos
sistema -> sistema : Crea ContactMessage
sistema --> Maria : "Mensaje enviado"

== Admin Gestiona ==

admin -> sistema : Accede a /admin/contact_messages
sistema --> admin : Lista mensajes pendientes
admin -> sistema : Lee mensaje de Maria
sistema -> sistema : Marca read = true
admin -> sistema : Corrige link
admin -> sistema : Elimina mensaje

note right of sistema
  MESSAGE_TYPES = [sugerencia, reclamo, link_roto, otro]
end note

@enduml
```

---

## Resumen de Historia

| Etapa | Actor | Accion | Resultado |
|-------|-------|--------|-----------|
| 1. Descubrimiento | Maria | Se registra | Cuenta creada |
| 2. Exploracion | Maria | Navega categorias | Encuentra herramientas |
| 3. Favoritos | Maria | Agrega herramienta | Guardada en favoritos |
| 4. Aprendizaje | Maria + YouTube | Ve video curso | Progreso guardado |
| 5. Feedback | Maria | Reporta link roto | Admin corrige |

---

## Lecciones Aprendidas

1. **Autenticacion**: Devise maneja registro/login transparently
2. **Favoritos**: Uniqueness constraint previene duplicados
3. **Progreso**: Auto-save cada 15s permite retomar luego
4. **Feedback**: Sistema de contacto mejora calidad del contenido
