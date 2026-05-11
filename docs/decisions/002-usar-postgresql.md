# ADR-002: Usar PostgreSQL como Base de Datos

## Status

Aceptado

## Context

Necesitamos elegir una base de datos para Blackstone. Se evaluaron:

- **PostgreSQL**
- **MySQL/MariaDB**
- **SQLite** (para desarrollo)
- **MongoDB** (NoSQL)

## Decision

**Usar PostgreSQL 14+**

## Reasons

| Razón | Detalle |
|-------|--------|
| **数据类型丰富** | Soporte nativo para JSON, ARRAY, HSTORE |
| **Constraints** | Foreign keys robustas, check constraints, unique constraints |
| **Full-text search** | Búsqueda textual integrada (futuro) |
| **Rendimiento** | Índices poderosos, query planning avanzado |
| **Herencia de tablas** | Para patrones como multi-tenancy (futuro) |
| **Rails + PostgreSQL** | Integración nativa excelente con ActiveRecord |

## Consequences

### Positive

- Datos estructurados y normalizados
- Índices eficientes para relaciones
- JSON support para flexibilidad futura
- Transacciones ACID confiables

### Negative

- Requiere instalación separate (no embedded)
- Configuración de producción más compleja que SQLite
- Uso de memoria mayor que SQLite

### Risks

- Migration de datos más compleja si se necesita cambiar DB
- Connection pooling requiere configuración adicional

## Alternatives Considered

| Alternativa | Razón de rechazo |
|-------------|------------------|
| MySQL | Menor soporte de tipos avanzados |
| SQLite | No apropiado para producción, solo desarrollo |
| MongoDB | Overkill para datos altamente estructurados |

## Notes

- En desarrollo local, PostgreSQL corre en Docker o instalación directa
- Credentials en `config/database.yml` (verificar en producción)

---

*Decisión tomada: 2024-05-10*
