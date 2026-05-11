# Wireframes - Blackstone

## Índice de Wireframes

| Wireframe | Archivo | Descripción |
|-----------|---------|-------------|
| **Home - Hero** | Hero premium con herramienta destacada |
| **Herramientas** | Vista de herramientas por categoría |

## Wireframe: Página de Usuario (Perfil)

### Descripción

La página de perfil del usuario muestra información personal, estadísticas de uso, favoritos y progreso de cursos.

### Estructura del Layout

```
┌─────────────────────────────────────────────────────────────────────────────┐
│  HEADER                                                                     │
│  ⬛ Blackstone          Herramientas  Cursos  ⭐ Favoritos  [Nombre]  Salir  │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│  ┌─────────────────────────────────────────────────────────────────────┐   │
│  │  PERFIL DE USUARIO                                                  │   │
│  │                                                                     │   │
│  │  ┌─────────┐  Nombre: María García                                 │   │
│  │  │  👤     │  Email: maria@email.com                               │   │
│  │  │  Avatar │  Miembro desde: Abril 2026                            │   │
│  │  └─────────┘  Rol: Estudiante                                       │   │
│  │                                                                     │   │
│  │  [Editar Perfil]                                                    │   │
│  └─────────────────────────────────────────────────────────────────────┘   │
│                                                                             │
│  ┌─────────────────────────────────────────────────────────────────────┐   │
│  │  ESTADÍSTICAS                                                       │   │
│  │                                                                     │   │
│  │  ┌──────────┐  ┌──────────┐  ┌──────────┐  ┌──────────┐           │   │
│  │  │    12    │  │    8     │  │   45h    │  │    6     │           │   │
│  │  │Favoritos │  │Cursos    │  │Vistos    │  │Completos │           │   │
│  │  │          │  │Inscritos │  │          │  │          │           │   │
│  │  └──────────┘  └──────────┘  └──────────┘  └──────────┘           │   │
│  └─────────────────────────────────────────────────────────────────────┘   │
│                                                                             │
│  ┌─────────────────────────────────────────────────────────────────────┐   │
│  │  MIS FAVORITOS                                                      │   │
│  │                                                                     │   │
│  │  ┌─────────────────┐  ┌─────────────────┐  ┌─────────────────┐     │   │
│  │  │  ⬛ VS Code      │  │  ⬛ Git          │  │  ⬛ Docker       │     │   │
│  │  │  Editor de código│  │  Control versiones│  │  Contenedores   │     │   │
│  │  │  [Open Source]   │  │  [Free Tier]    │  │  [Multiplataforma]│    │   │
│  │  │  [Ver →]         │  │  [Ver →]        │  │  [Ver →]        │     │   │
│  │  └─────────────────┘  └─────────────────┘  └─────────────────┘     │   │
│  │                                                                     │   │
│  │  [Ver todos los favoritos →]                                        │   │
│  └─────────────────────────────────────────────────────────────────────┘   │
│                                                                             │
│  ┌─────────────────────────────────────────────────────────────────────┐   │
│  │  PROGRESO DE CURSOS                                                 │   │
│  │                                                                     │   │
│  │  ┌─────────────────────────────────────────────────────────────┐   │   │
│  │  │  📚 Git Fundamentals                                        │   │   │
│  │  │  ████████████████████████░░░░░░  75%                        │   │   │
│  │  │  Ep. 3 de 4 completados                                     │   │   │
│  │  │  [Continuar →]                                              │   │   │
│  │  └─────────────────────────────────────────────────────────────┘   │   │
│  │                                                                     │   │
│  │  ┌─────────────────────────────────────────────────────────────┐   │   │
│  │  │  📚 Ruby on Rails para principiantes                        │   │   │
│  │  │  ████████████████████████████████  100% ✅                  │   │   │
│  │  │  6 de 6 episodios completados                               │   │   │
│  │  │  [Ver curso →]                                              │   │   │
│  │  └─────────────────────────────────────────────────────────────┘   │   │
│  │                                                                     │   │
│  │  [Ver todos los cursos →]                                           │   │
│  └─────────────────────────────────────────────────────────────────────┘   │
│                                                                             │
├─────────────────────────────────────────────────────────────────────────────┤
│  FOOTER                                                                     │
│  Blackstone © 2026 — Directorio de herramientas para estudiantes           │
│  ¿Encontraste un error? Contáctanos                                         │
└─────────────────────────────────────────────────────────────────────────────┘
```

### Componentes del Wireframe

#### 1. Header
- Logo Blackstone (izquierda)
- Navegación: Herramientas, Cursos, Favoritos
- Perfil del usuario con nombre y botón de salir

#### 2. Sección de Perfil
- Avatar del usuario (círculo, 80px)
- Nombre completo
- Email
- Fecha de registro
- Rol (Estudiante/Desarrollador/Admin)
- Botón "Editar Perfil"

#### 3. Sección de Estadísticas
- 4 tarjetas con métricas:
  - Favoritos totales
  - Cursos inscritos
  - Horas de video vistas
  - Cursos completados

#### 4. Sección de Favoritos
- Grid de 3 columnas con tarjetas de herramientas
- Cada tarjeta muestra:
  - Logo de la herramienta
  - Nombre
  - Descripción corta
  - Badges (Open Source, Free Tier, Plataforma)
  - Botón "Ver"
- Link "Ver todos los favoritos"

#### 5. Sección de Progreso de Cursos
- Lista de cursos con barra de progreso
- Cada curso muestra:
  - Título del curso
  - Barra de progreso visual (porcentaje)
  - Episodios completados vs totales
  - Badge de completado (✅) si es 100%
  - Botón "Continuar" o "Ver curso"
- Link "Ver todos los cursos"

#### 6. Footer
- Copyright
- Link de contacto

### Colores y Estilos

| Elemento | Color | Token |
|----------|-------|-------|
| Fondo principal | `#000000` | `--color-void-black` |
| Tarjetas | `#0b0e14` | `--surface-card-surface` |
| Bordes | `#292d30` | `--color-graphite-rail` |
| Texto principal | `#f0f0f0` | `--color-frost` |
| Texto secundario | `#a1a4a5` | `--color-fog` |
| Barra de progreso | `#3b9eff` | `--color-electric-blue` |
| Completado | `#3ad389` | `--color-delivered-green` |
| Botones | Outline azul | `--color-electric-blue` |

### Tipografía

| Elemento | Fuente | Tamaño | Peso |
|----------|--------|--------|------|
| Títulos de sección | Space Grotesk | 24px | 500 |
| Nombre de usuario | Inter | 18px | 600 |
| Estadísticas | JetBrains Mono | 32px | 400 |
| Texto de tarjetas | Inter | 14px | 400 |
| Badges | JetBrains Mono | 12px | 400 |

### Responsive

| Breakpoint | Comportamiento |
|------------|----------------|
| Desktop (>1200px) | Grid de 3 columnas para favoritos |
| Tablet (768-1200px) | Grid de 2 columnas |
| Mobile (<768px) | 1 columna, estadísticas en scroll horizontal |
