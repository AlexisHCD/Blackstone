# ADR-003: Autenticación con Devise

## Status

Aceptado

## Context

Necesitamos implementar autenticación de usuarios. Opciones evaluadas:

- **Devise** (Rails gem)
- **Sorcery** (Rails gem más ligera)
- **Authlogic** (Rails gem)
- **OmniAuth** (OAuth only)
- **Custom implementation**

## Decision

**Usar Devise con módulos seleccionados**

## Reasons

| Razón | Detalle |
|-------|--------|
| **Madurez** | 15+ años en producción, código auditado |
| **Features completos** | Login, registro, reset password, remember me |
| **Integración Rails** | generators, views, mailers listos para usar |
| **Flexible** | Módulos opcionales, customizable |
| **Comunidad** | Documentación extensa, soporte widespread |

## Modules Enabled

```ruby
devise :database_authenticatable, :registerable,
       :recoverable, :rememberable, :validatable
```

| Módulo | Uso |
|--------|-----|
| `database_authenticatable` | Email + password con hash BCrypt |
| `registerable` | Registro de nuevos usuarios |
| `recoverable` | Reset de contraseña por email |
| `rememberable` | Sesión persistente con "recordarme" |
| `validatable` | Validaciones de email/password |

## Modules Disabled

| Módulo | Razón |
|--------|-------|
| `confirmable` | No tenemos mailer configurado todavía |
| `lockable` | No es crítico para MVP |
| `timeoutable` | Puede ser molesto para usuarios |
| `trackable` | No tenemos necesidad de tracking de login |
| `omniauthable` | OAuth viene en versión future |

## Consequences

### Positive

- Autenticación robusta lista en horas
- Views pre-construidas con diseño básico
- Security auditado por la comunidad

### Negative

- Gem pesada (muchas dependencias)
- Views necesitan customización para matchear design system
- Some opinionated behaviors to override

### Risks

- Vulnerabilidades en gemas dependientes (mitigado: dependabot)
- Possible breaking changes en updates (usar version pinning)

## Password Policy

- Mínimo 6 caracteres
- Validatable configurable
- BCrypt con cost factor 12

---

*Decisión tomada: 2024-05-10*
