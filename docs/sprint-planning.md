# Sprint Planning - Blackstone

## 1. Visión General

Blackstone planifica el desarrollo en **sprints de 2 semanas** siguiendo principios ágiles adaptados a un equipo pequeño.

---

## 2. Historial de Sprints

### Sprint 0 - Fundamentos (Completado)
**Período:** Preparación
**Goal:** Establecer la base del proyecto

| Feature | Story Points | Estado |
|---------|--------------|--------|
| Setup inicial Rails | 2 | ✅ |
| Configurar PostgreSQL | 1 | ✅ |
| Diseño del schema | 2 | ✅ |
| Implementar autenticación Devise | 3 | ✅ |
| **Total** | **8 SP** | |

---

### Sprint 1 - Core Features (Completado)
**Período:** 2 semanas
**Goal:** CRUD completo de categorías y herramientas

| Feature | Story Points | Estado |
|---------|--------------|--------|
| CRUD Categorías (admin) | 3 | ✅ |
| CRUD Herramientas (admin) | 5 | ✅ |
| Validaciones de modelos | 2 | ✅ |
| Active Storage para logos | 3 | ✅ |
| Vista pública de categorías | 2 | ✅ |
| Vista pública de herramientas | 2 | ✅ |
| **Total** | **17 SP** | |

---

### Sprint 2 - Cursos y Video (Completado)
**Período:** 2 semanas
**Goal:** Sistema de cursos con episodios

| Feature | Story Points | Estado |
|---------|--------------|--------|
| CRUD Cursos (admin) | 3 | ✅ |
| CRUD Episodios (admin) | 5 | ✅ |
| Extracción automática YouTube ID | 2 | ✅ |
| Reproductor YouTube embebido | 3 | ✅ |
| Tracking de progreso (auto-save 15s) | 5 | ✅ |
| Marca de completado al 90% | 2 | ✅ |
| **Total** | **20 SP** | |

---

### Sprint 3 - Favoritos y Contacto (Completado)
**Período:** 2 semanas
**Goal:** Sistema de favoritos y feedback

| Feature | Story Points | Estado |
|---------|--------------|--------|
| Sistema de favoritos (herramientas) | 3 | ✅ |
| Sistema de favoritos (cursos) | 3 | ✅ |
| Página Mis Favoritos | 2 | ✅ |
| Formulario de contacto | 3 | ✅ |
| Gestión de mensajes (admin) | 2 | ✅ |
| **Total** | **13 SP** | |

---

## 3. Sprint Actual

### Sprint 4 - UI/UX y Polish
**Período:** 2 semanas (en curso)
**Goal:** Mejorar diseño y experiencia de usuario

| Feature | Prioridad | Story Points | Estado |
|---------|-----------|--------------|--------|
| Dark theme premium (Resend-style) | P1 | 5 | 🔄 En progreso |
| Animaciones sutiles | P2 | 3 | ⏳ Pendiente |
| Responsive design | P1 | 3 | ⏳ Pendiente |
| Featured item diario | P2 | 2 | ⏳ Pendiente |
| Carousel de categorías | P2 | 3 | ⏳ Pendiente |
| **Total** | | **16 SP** | |

---

## 4. Backlog Priorizado

### P0 - Crítico (Release Blocker)

| Feature | Descripción | SP |
|---------|-------------|-----|
| (Ninguno) | - | - |

*Todos los features críticos están completados.*

---

### P1 - Alta Prioridad

| Feature | Descripción | SP | Estado |
|---------|-------------|-----|--------|
| Mejoras de diseño | Design system completo | 8 | 🔄 |
| Búsqueda full-text | Buscador de herramientas | 5 | ⏳ |
| Filtros avanzados | Filtros en lista de herramientas | 3 | ⏳ |

---

### P2 - Media Prioridad

| Feature | Descripción | SP | Estado |
|---------|-------------|-----|--------|
| Notificaciones | Notificar al admin de nuevos mensajes | 3 | ⏳ |
| User profiles | Perfil de usuario con estadísticas | 5 | ⏳ |
| Historial de progreso | Ver videos completados | 3 | ⏳ |
| Compartir | Compartir herramientas en redes | 2 | ⏳ |

---

### P3 - Baja Prioridad

| Feature | Descripción | SP | Estado |
|---------|-------------|-----|--------|
| Tests automatizados | Coverage al 70% | 13 | ⏳ |
| API REST | Exponer API pública | 8 | ⏳ |
| OAuth | Login con Google/GitHub | 5 | ⏳ |
| Dashboard analytics | Stats de uso | 5 | ⏳ |

---

## 5. Definition of Done

Un feature se considera **completado** cuando:

- [ ] Código escrito
- [ ] Validaciones manuales pasando
- [ ] No hay errores de lint
- [ ] Diseño responsive funcionando
- [ ] Documentación actualizada

---

## 6. Métricas

| Métrica | Sprint 0 | Sprint 1 | Sprint 2 | Sprint 3 |
|---------|----------|----------|----------|----------|
| SP completados | 8 | 17 | 20 | 13 |
| Bugs reportados | 0 | 2 | 1 | 0 |
| Bugs resueltos | 0 | 2 | 1 | 0 |
| Velocity | 8 | 17 | 20 | 13 |

---

*Versión 1.0 - Blackstone*
