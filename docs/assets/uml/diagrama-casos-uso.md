# Diagrama de Casos de Uso

```plantuml
@startuml

title Diagrama de Casos de Uso - Blackstone

left to right direction

actor ":Usuario Anónimo" as anonimo
actor ":Usuario Registrado" as usuario
actor ":Administrador" as admin

rectangle "Sistema Blackstone" {
  usecase "UC-01: Registrarse" as UC01
  usecase "UC-02: Iniciar Sesión" as UC02
  usecase "UC-03: Cerrar Sesión" as UC03
  usecase "UC-04: Explorar Categorías" as UC04
  usecase "UC-05: Ver Herramientas" as UC05
  usecase "UC-06: Ver Detalle de Herramienta" as UC06
  usecase "UC-07: Ver Cursos" as UC07
  usecase "UC-08: Ver Episodio de Curso" as UC08
  usecase "UC-09: Reproducir Video" as UC09
  usecase "UC-10: Agregar a Favoritos (Herramienta)" as UC10
  usecase "UC-11: Agregar a Favoritos (Curso)" as UC11
  usecase "UC-12: Ver Mis Favoritos" as UC12
  usecase "UC-13: Quitar de Favoritos" as UC13
  usecase "UC-14: Trackear Progreso de Video" as UC14
  usecase "UC-15: Marcar Video Completado" as UC15
  usecase "UC-16: Enviar Mensaje de Contacto" as UC16
  usecase "UC-17: Gestionar Categorías (CRUD)" as UC17
  usecase "UC-18: Gestionar Herramientas (CRUD)" as UC18
  usecase "UC-19: Gestionar Cursos (CRUD)" as UC19
  usecase "UC-20: Gestionar Episodios (CRUD)" as UC20
  usecase "UC-21: Gestionar Mensajes" as UC21
  usecase "UC-22: Gestionar Usuarios" as UC22
  usecase "UC-23: Subir Logo de Herramienta" as UC23
}

anonimo --> UC01
anonimo --> UC02
anonimo --> UC04
anonimo --> UC05
anonimo --> UC06
anonimo --> UC07
anonimo --> UC08
anonimo --> UC09

usuario --> UC03
usuario --> UC04
usuario --> UC05
usuario --> UC06
usuario --> UC07
usuario --> UC08
usuario --> UC09
usuario --> UC10
usuario --> UC11
usuario --> UC12
usuario --> UC13
usuario --> UC14
usuario --> UC15
usuario --> UC16

admin --> UC03
admin --> UC04
admin --> UC05
admin --> UC06
admin --> UC07
admin --> UC08
admin --> UC09
admin --> UC16
admin --> UC17
admin --> UC18
admin --> UC19
admin --> UC20
admin --> UC21
admin --> UC22
admin --> UC23

note right of UC01
  El usuario proporciona: nombre, email, password
end note

note right of UC14
  Sistema guarda progreso cada 15 segundos
end note

note right of UC15
  Se marca completado cuando >= 90%
end note

note right of UC23
  Usa Active Storage para upload
end note

@enduml
```

## Actores

| Actor | Descripción | Permisos |
|-------|-------------|----------|
| **Usuario Anónimo** | Visitante sin cuenta | Ver contenido público, explorar categorías y herramientas |
| **Usuario Registrado** | Cuenta con email/password | Favoritos, progreso de video, contacto |
| **Administrador** | Cuenta con admin=true | CRUD completo, gestión de usuarios y mensajes |

## Casos de Uso por Paquete

### Autenticación
- UC-01: Registrarse
- UC-02: Iniciar Sesión
- UC-03: Cerrar Sesión

### Contenido Público
- UC-04: Explorar Categorías
- UC-05: Ver Herramientas
- UC-06: Ver Detalle de Herramienta
- UC-07: Ver Cursos
- UC-08: Ver Episodio de Curso
- UC-09: Reproducir Video

### Favoritos y Progreso
- UC-10: Agregar a Favoritos (Herramienta)
- UC-11: Agregar a Favoritos (Curso)
- UC-12: Ver Mis Favoritos
- UC-13: Quitar de Favoritos
- UC-14: Trackear Progreso de Video
- UC-15: Marcar Video Completado

### Contacto
- UC-16: Enviar Mensaje de Contacto

### Administración
- UC-17: Gestionar Categorías (CRUD)
- UC-18: Gestionar Herramientas (CRUD)
- UC-19: Gestionar Cursos (CRUD)
- UC-20: Gestionar Episodios (CRUD)
- UC-21: Gestionar Mensajes
- UC-22: Gestionar Usuarios
- UC-23: Subir Logo de Herramienta
