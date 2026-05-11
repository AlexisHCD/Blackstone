# Blackstone - Documentación General

> Directorio de herramientas de desarrollo y cursos para estudiantes de programación.

## Tabla de Contenidos

1. [Introducción](#1-introducción)
2. [Problemática](#2-problemática)
3. [Objetivos](#3-objetivos)
4. [Propuesta](#4-propuesta)
5. [Usuarios](#5-usuarios)
6. [Factibilidad](#6-factibilidad)
7. [Metodología](./metodologia.md)
8. [Arquitectura](./arquitectura.md)
9. [Autenticación](./auth.md)
10. [Design System](./design.md)
11. [Diccionario de Datos](./diccionario-datos.md)
12. [API](./api.md)
13. [Sprint Planning](./sprint-planning.md)
14. [Decisiones Técnicas](./decisions/)

---

## 1. Introducción

### 1.1 Descripción del Proyecto

**Blackstone** es una plataforma web desarrollada en Rails 7.1.3 que funciona como un directorio/cátalogo de herramientas de desarrollo y cursos en video para estudiantes de programación. La aplicación permite explorar herramientas categorizadas, visualizar cursos en YouTube, guardar favoritos y trackear el progreso de video con persistencia en base de datos.

### 1.2 Alcance General

| Módulo | Descripción |
|--------|-------------|
| **Herramientas** | Directorio curado de herramientas de desarrollo categorizadas |
| **Cursos** | Catálogo de cursos en video con episodes ordenados |
| **Favoritos** | Sistema para guardar herramientas y cursos |
| **Progreso** | Tracking de видео con auto-save cada 15s |
| **Admin** | Panel completo para gestionar contenidos |
| **Contacto** | Sistema de feedback para usuarios |

### 1.3 Stack Tecnológico

| Componente | Tecnología | Versión |
|------------|------------|---------|
| Framework | Rails | 7.1.3 |
| Lenguaje | Ruby | 3.3.0 |
| Base de datos | PostgreSQL | 14+ |
| Frontend | Hotwire (Turbo + Stimulus) | - |
| Autenticación | Devise | 4.x |
| Storage | Active Storage | (bundled) |
| Video | YouTube IFrame API | - |
| CSS | Custom (dark theme) | - |

---

## 2. Problemática

### 2.1 Situación Actual

Los estudiantes de programación enfrentan varios problemas:

| Problema | Descripción |
|----------|-------------|
| **Información dispersa** | Las herramientas se encuentran en múltiples sitios sin catálogo centralizado |
| **Dificultad de evaluación** | No existe sistema estandarizado para filtrar por plataforma, nivel, precio |
| **Pérdida de progreso** | Los estudiantes ven cursos pero no tienen forma de continuar donde dejaron |
| **Favoritos fragmentados** | Deben usar bookmarks del navegador, inaccesibles desde otros dispositivos |
| **Sin feedback** | No hay canal directo para reportar errores o sugerir contenido |

### 2.2 Business Process Model (BPMN)

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                     PROCESO ACTUAL (SIN BLACKSTONE)                        │
└─────────────────────────────────────────────────────────────────────────────┘

[INICIO] → Buscar herramientas en Google/YouTube
                ↓
         Explorar múltiples sitios
                ↓
         Guardar en bookmarks del navegador
                ↓
         Ver videos de cursos (sin tracking)
                ↓
         Perder progreso al cerrar navegador
                ↓
         [FIN - Experiencia fragmentada]

┌─────────────────────────────────────────────────────────────────────────────┐
│                    PROCESO CON BLACKSTONE IMPLEMENTADO                     │
└─────────────────────────────────────────────────────────────────────────────┘

[USUARIO ANÓNIMO]
[INICIO] → Visitar homepage → Ver herramienta destacada → Navegar categorías
                ↓
         Explorar herramientas por categoría
                ↓
         Ver detalle de herramienta
                ↓
        [FIN - Solo lectura]

[USUARIO AUTENTICADO]
[INICIO] → Registrarse/Iniciar sesión
                ↓
         Explorar y buscar contenido
                ↓
         AGREGAR A FAVORITOS ─────────────────────────┐
                ↓                                    │
         Guardar progreso de video                   │
         (auto-save cada 15s, marca completo 90%)     │
                ↓                                    │
         Enviar mensaje de contacto                  │
                ↓                                    │
        [FIN - Experiencia personalizada]           │
        ←────────────────────────────────────────────┘

[ADMIN]
[INICIO] → Acceder a /admin
                ↓
         CRUD categorías, herramientas, cursos
                ↓
         Gestionar episodios de cursos
                ↓
         Revisar mensajes de contacto
                ↓
         [FIN - Gestión completa]
```

---

## 3. Objetivos

### 3.1 Objetivo General

Proporcionar un catálogo de referencia para herramientas de desarrollo y cursos para estudiantes de programación de habla hispana, con una experiencia moderna y personalizada que facilite el aprendizaje continuo.

### 3.2 Objetivos Específicos

| ID | Objetivo | Prioridad |
|----|----------|----------|
| OE-01 | Proporcionar directorio navegable de herramientas categorizadas | Alta |
| OE-02 | Ofrecer cursos en video con tracking de progreso | Alta |
| OE-03 | Permitir a usuarios guardar favoritos para acceso rápido | Alta |
| OE-04 | Mantener contenido actualizado via sistema de contacto | Media |
| OE-05 | Proveer panel de administración completo | Alta |

### 3.3 KPIs

| Métrica | Meta |
|---------|------|
| Tiempo promedio en el sitio | > 5 min/sesión |
| Herramientas en catálogo | > 50 |
| Cursos disponibles | > 20 |
| Tasa de usuarios que usan favoritos | > 30% |
| Tasa de completion de videos | > 40% |

---

## 4. Propuesta

### 4.1 Visión

> "Ser el catálogo de referencia para herramientas de desarrollo y cursos para estudiantes de programación de habla hispana."

### 4.2 Diferenciadores

| Aspecto | Competidores | Blackstone |
|---------|--------------|------------|
| **Enfoque** | Generalistas | Estudiantes de programación (nicho específico) |
| **Progreso de video** | No integrado | Auto-save cada 15s, marca completo 90% |
| **Favoritos unificados** | No | Herramientas + cursos en un solo lugar |
| **Contenido curado** | User-generated | Admin-curado + sistema de contacto |
| **Design** | Típico SaaS | Dark theme premium estilo Resend/Linear |

### 4.3 Funcionalidades Principales

1. **Home con Featured Item Diario**: Herramienta aleatoria destacada automáticamente
2. **Navegación por Categorías**: Carousel visual para explorar contenido
3. **Detalle de Herramientas**: Filtros por plataforma, nivel, open source, free tier
4. **Detalle de Cursos**: Episodios ordenados con reproductor YouTube integrado
5. **Sistema de Favoritos**: Unificados para herramientas y cursos
6. **Progreso de Video**: Persistencia con auto-save y marca de completion
7. **Panel Admin**: CRUD completo de todos los contenidos
8. **Sistema de Contacto**: Tipos categorizados (sugerencia, reclamo, link_roto)

---

## 5. Usuarios

### 5.1 User Personas

| Persona | Edad | Rol | Necesidades |
|---------|------|-----|-------------|
| **María** | 22 | Estudiante de Ingeniería en Sistemas | Encontrar herramientas gratuitas, guardar favoritas |
| **Carlos** | 30 | Career changer (finanzas → dev) | Cursos para aprender desde cero, trackear progreso |
| **Alex** | 19 | Desarrollador autodidacta | Explorar por categoría, saber cuáles son open source |
| **Sofía** | 28 | Gestora de contenido | Curar y gestionar el catálogo, responder mensajes |

### 5.2 User Flows

#### Flow 1: Descubrimiento
```
Home → Ver herramienta destacada → Explorar categorías → Ver categoría → Ver tool → [Opcional: Favorito]
```

#### Flow 2: Aprendizaje
```
Cursos → Ver curso → Seleccionar episodio → Ver video (auto-save) → Continuar luego → Retomar donde quedó
```

#### Flow 3: Feedback
```
Herramienta → Reportar problema → Llenar form contacto → Admin recibe → [Opcional: Admin contacta]
```

### 5.3 Roles

| Rol | Permisos |
|-----|----------|
| **Usuario Anónimo** | Ver contenido, explorar herramientas y cursos |
| **Usuario Registrado** | Favoritos, tracking de video, envío de mensajes |
| **Administrador** | CRUD contenido, gestión de usuarios y mensajes |

---

## 6. Factibilidad

### 6.1 Factibilidad Técnica

| Aspecto | Estado | Notas |
|---------|--------|-------|
| Stack tecnológico | ✅ | Rails 7.1.3 + Ruby 3.3.0 - estable |
| Base de datos | ✅ | PostgreSQL - funcional |
| Autenticación | ✅ | Devise - funcional |
| Video integration | ✅ | YouTube API - funcional |
| Active Storage | ✅ | Local - funcional |
| Hotwire | ✅ | Turbo + Stimulus - funcional |
| Tests | ⚠️ | Directorio vacío |

### 6.2 Factibilidad Operacional

| Aspecto | Estado | Notas |
|---------|--------|-------|
| Panel admin | ✅ | CRUD completo implementado |
| Sistema de contacto | ✅ | Mensajes funcionales |
| Favoritos | ✅ | Únicos por usuario+item |
| Progreso video | ✅ | Auto-save 15s |

### 6.3 Factibilidad Económica

| Aspecto | Estado | Notas |
|---------|--------|-------|
| Costes hosting | ✅ | Rails + PostgreSQL - económico |
| Mantenimiento | ✅ | Stack simple, sin dependencias pesadas |
| Escalabilidad | ⚠️ | Sin cache, sin CDN (área de mejora) |

### 6.4 Áreas de Mejora Identificadas

- No hay datos de semilla (seeds.rb vacío)
- No hay búsqueda/full-text search
- No hay tests automatizados
- Credenciales en texto plano en database.yml
- Sin cache ni optimización de performance

---

## 7. Metodología

Ver documento: [Metodología](./metodologia.md)

## 8. Arquitectura

Ver documento: [Arquitectura](./arquitectura.md)

## 9. Autenticación

Ver documento: [Autenticación](./auth.md)

## 10. Design System

Ver documento: [Design System](./design.md)

## 11. Diccionario de Datos

Ver documento: [Diccionario de Datos](./diccionario-datos.md)

## 12. API

Ver documento: [API](./api.md)

## 13. Sprint Planning

Ver documento: [Sprint Planning](./sprint-planning.md)

## 14. Decisiones Técnicas

Ver carpeta: [Decisiones Técnicas](./decisions/)

---

## Glosario

| Término | Definición |
|---------|-----------|
| **BPMN** | Business Process Model and Notation - notación para modelar procesos de negocio |
| **CRUD** | Create, Read, Update, Delete - operaciones básicas de datos |
| **FK** | Foreign Key - llave foránea en base de datos |
| **Hotwire** | Metodología de Rails que usa Turbo y Stimulus para interactividad |
| **Slug** | Versión URL-friendly de un texto (ej: "Desarrollo Web" → "desarrollo-web") |
| **Stimulus** | Framework JavaScript de Hotwire |
| **Turbo** | Parte de Hotwire que acelera páginas sin JavaScript pesado |

---

*Versión 1.0 - Blackstone*
