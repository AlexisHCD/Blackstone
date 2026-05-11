# Metodología de Desarrollo - Blackstone

## 1. Enfoque Metodológico

Blackstone utiliza un enfoque **ágil iterativo** con sprints de 2 semanas, adaptando principios de **Scrum** y **Kanban** a las necesidades de un proyecto de desarrollo web con un equipo reducido.

### 1.1 Principios Aplicados

| Principio | Aplicación |
|-----------|------------|
| **Desarrollo iterativo** | Funcionalidades en increments pequeños |
| **Priorización por valor** | Features de mayor impacto primero |
| **Feedback temprano** | Testing constante durante desarrollo |
| **Adaptación al cambio** | Repriorización entre sprints según feedback |
| **Colaboración** | Documentación compartida y código revisado |

---

## 2. Ciclo de Desarrollo

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                           CICLO DE SPRINT (2 semanas)                     │
└─────────────────────────────────────────────────────────────────────────────┘

┌─────────────┐    ┌─────────────┐    ┌─────────────┐    ┌─────────────┐
│  PLANNING   │ ─► │    BUILD    │ ─► │   TEST      │ ─► │   REVIEW    │
│  (Día 1)    │    │  (Días 2-9) │    │  (Día 10)   │    │  (Día 11)   │
└─────────────┘    └─────────────┘    └─────────────┘    └─────────────┘
                                                              │
                                                              ▼
                                                       ┌─────────────┐
                                                       │   RETRO     │
                                                       │  (Día 12)   │
                                                       └─────────────┘
                                                              │
                                                              ▼
                                                       ┌─────────────┐
                                                       │ NEXT SPRINT │
                                                       │  (Día 13)   │
                                                       └─────────────┘
```

---

## 3. Roles

| Rol | Responsabilidades |
|-----|-------------------|
| **Product Owner** | Define prioridades, valida features |
| **Developer** | Implementa funcionalidades, escribe código |
| **Designer** | Diseño UI/UX, design system |
| **QA** | Testing, validaciones (compartido con dev) |

*En un equipo de 1-2 personas, estos roles se comparten.*

---

## 4. Sprint Planning

### 4.1 Actividades de Planning

1. **Revisión del backlog** - Priorizar features pendientes
2. **Selección de sprint goal** - Definir objetivo del sprint
3. **Estimación** - Asignar story points (1, 2, 3, 5, 8)
4. **Descomposición** - Dividir features en tareas técnicas
5. **Definition of Done** - Establecer criterios de completado

### 4.2 Criterios de Prioridad

| Prioridad | Descripción | Criteria |
|-----------|-------------|----------|
| **P0 - Crítico** | Funcionalidad sin la cual el sistema no funciona | Bug crítico, auth, CRUD base |
| **P1 - Alta** | Core features para release inicial | Favoritos, progreso video, admin |
| **P2 - Media** | Features importantes pero no blocker | Buscador, filtros, notificaciones |
| **P3 - Baja** | Nice-to-have para versiones futuras | Optimizaciones, features secundarias |

### 4.3 Story Points

| Puntos | Complejidad | Tiempo | Ejemplos |
|--------|------------|--------|----------|
| 1 | Simple | < 2h | Agregar campo a formulario |
| 2 | Moderada | 2-4h | Validación compleja |
| 3 | Intermedia | 4-8h | CRUD con relaciones |
| 5 | Compleja | 8-16h | Sistema de favoritos completo |
| 8 | Muy compleja | 16-32h | Panel admin completo |
| 13 | Huge | > 32h | Sistema de pagos (no aplica) |

---

## 5. Gestión del Backlog

### 5.1 Estructura del Backlog

```
BACKLOG
├── P0 - Crítico
│   ├── [Auth] Login/registro de usuarios
│   └── [Core] CRUD categorías
├── P1 - Alta
│   ├── [Herramientas] CRUD herramientas con logo
│   ├── [Cursos] CRUD cursos y episodios
│   ├── [Favoritos] Sistema de favoritos
│   └── [Progreso] Tracking de video
├── P2 - Media
│   ├── [UI] Mejoras de diseño
│   ├── [Contact] Formulario de contacto
│   └── [Admin] Gestión de mensajes
└── P3 - Baja
    ├── [Search] Implementar buscador
    └── [Tests] Escribir tests automatizados
```

### 5.2 User Stories

| Formato | Ejemplo |
|---------|---------|
| **Como** | usuario registrado |
| **Quiero** | agregar herramientas a favoritos |
| **Para que** | pueda acceder fácilmente después |
| **Criterios de aceptación** | 1. Botón visible en detail, 2. Confirmación visual, 3. Aparece en /mis-favoritos |

---

## 6. Testing

### 6.1 Niveles de Testing

| Nivel | Descripción | Herramientas |
|-------|-------------|-------------|
| **Unitario** | Métodos y clases aisladas | Minitest |
| **Integración** | Flujos completos entre componentes | Rails system tests |
| **Funcional** | Features desde perspectiva del usuario | Capybara |

### 6.2 Estrategia de Testing

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                           PIRÁMIDE DE TESTING                             │
└─────────────────────────────────────────────────────────────────────────────┘

                                    ┌───────────┐
                                   │   E2E     │  ← Pocos, críticos
                                  │  (Capybara) │
                                   └───────────┘
                                  ┌───────────┐
                                 │ INTEGRACIÓN│  ← Medios, flujos
                                │ (System)    │
                                 └───────────┘
                                ┌───────────┐
                               │   UNIT     │  ← Muchos, rápidos
                              │ (Minitest)  │
                               └───────────┘
```

### 6.3 Cobertura Mínima

| Componente | Cobertura Mínima |
|------------|-------------------|
| Modelos | 80% |
| Controladores (acciones públicas) | 90% |
| Validaciones | 100% |
| Métodos de negocio | 85% |

---

## 7. Revisión y Feedback

### 7.1 Sprint Review

- Demo de funcionalidades completadas
- Revisión con stakeholders
- Validación de criterios de aceptación
- Retroalimentación para próximo sprint

### 7.2 Sprint Retrospective

- ¿Qué salió bien?
- ¿Qué se puede mejorar?
- ¿Qué acciones tomaremos?

### 7.3 Feedback Channels

| Canal | Uso |
|-------|-----|
| **Contacto in-app** | Feedback de usuarios sobre contenido |
| **GitHub Issues** | Bugs y feature requests |
| **Docencia** | Validación con usuarios reales |

---

## 8. Herramientas de Desarrollo

| Herramienta | Propósito |
|-------------|-----------|
| **Git** | Control de versiones |
| **GitHub** | Repositorio y project board |
| **Rails** | Framework backend |
| **Hotwire** | Interactividad frontend |
| **PostgreSQL** | Base de datos |
| **Stimulus** | Controladores JavaScript |

---

## 9. Definition of Done (DoD)

Una funcionalidad se considera **completada** cuando:

- [ ] Código escrito y formateado
- [ ] Tests unitarios pasando
- [ ] Validaciones manuales completadas
- [ ] Documentación actualizada
- [ ] No hay warnings de lint
- [ ] Deploy a staging (si aplica)

---

*Versión 1.0 - Blackstone*
