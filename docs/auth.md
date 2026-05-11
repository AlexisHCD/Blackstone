# Autenticación - Blackstone

## 1. Sistema de Autenticación

Blackstone utiliza **Devise** como sistema de autenticación, el estándar de facto para Rails.

### 1.1 Configuración

```ruby
# app/models/user.rb
class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :video_progresses, dependent: :destroy
  has_many :favorite_tools, dependent: :destroy
  has_many :favorite_courses, dependent: :destroy
end
```

### 1.2 Módulos Devise Activos

| Módulo | Descripción | Estado |
|--------|-------------|--------|
| `database_authenticatable` | Login con email/password | ✅ Activo |
| `registerable` | Registro de nuevos usuarios | ✅ Activo |
| `recoverable` | Reset de contraseña | ✅ Activo |
| `rememberable` | "Recordarme" checkbox | ✅ Activo |
| `validatable` | Validaciones de email/password | ✅ Activo |
| `confirmable` | Confirmación por email | ❌ Inactivo |
| `lockable` | Bloqueo por intentos fallidos | ❌ Inactivo |
| `timeoutable` | Timeout de sesión | ❌ Inactivo |
| `trackable` | Tracking de login | ❌ Inactivo |
| `omniauthable` | OAuth (Google, GitHub) | ❌ Inactivo |

---

## 2. Modelo de Usuario

### 2.1 Campos

| Campo | Tipo | Descripción |
|-------|------|-------------|
| `id` | `bigint` | Identificador único |
| `email` | `string` | Email único (requerido) |
| `encrypted_password` | `string` | Password encriptado |
| `reset_password_token` | `string` | Token para reset |
| `reset_password_sent_at` | `datetime` | Fecha de envío token |
| `remember_created_at` | `datetime` | Fecha "recordarme" |
| `name` | `string` | Nombre del usuario |
| `admin` | `boolean` | ¿Es administrador? (default: false) |
| `created_at` | `datetime` | Fecha de registro |
| `updated_at` | `datetime` | Última modificación |

### 2.2 Índices

```ruby
add_index :users, :email, unique: true
add_index :users, :reset_password_token, unique: true
```

---

## 3. Rutas de Autenticación

### 3.1 Rutas Generadas por Devise

| Ruta | Método | Descripción |
|------|--------|-------------|
| `/users/sign_up` | GET, POST | Registro |
| `/users/sign_in` | GET, POST | Login |
| `/users/sign_out` | DELETE | Logout |
| `/users/password/new` | GET, POST | Solicitar reset |
| `/users/password/edit` | GET, PATCH | Reset password |
| `/users/edit` | GET | Editar perfil |

### 3.2 After Login Path

```ruby
# app/controllers/application_controller.rb
def after_sign_in_path_for(resource)
  root_path
end
```

---

## 4. Vistas de Autenticación

### 4.1 Ubicación

```
app/views/devise/
├── confirmations/
│   └── new.html.erb
├── mailer/
│   ├── password_change.html.erb
│   ├── reset_password_instructions.html.erb
│   └── unlock_instructions.html.erb
├── passwords/
│   ├── edit.html.erb
│   └── new.html.erb
├── registrations/
│   ├── edit.html.erb
│   └── new.html.erb
├── sessions/
│   └── new.html.erb
├── shared/
│   └── _links.html.erb
└── unlocks/
    └── new.html.erb
```

### 4.2 Campos Personalizados

```ruby
# app/controllers/application_controller.rb
before_action :configure_permitted_parameters, if: :devise_controller?

private

def configure_permitted_parameters
  devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  devise_parameter_sanitizer.permit(:account_update, keys: [:name])
end
```

---

## 5. Autorización (Roles)

### 5.1 Roles de Usuario

| Rol | Campo `admin` | Permisos |
|-----|----------------|----------|
| **Usuario Regular** | `false` | Registro, login, favoritos, progreso, contacto |
| **Administrador** | `true` | Todo lo anterior + acceso a `/admin/*` |

### 5.2 Protecciones

```ruby
# app/controllers/admin/base_controller.rb
class Admin::BaseController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin!

  private

  def authenticate_admin!
    unless current_user&.admin?
      redirect_to root_path, alert: "⛔ Acceso denegado..."
    end
  end
end
```

### 5.3 Helper Methods

```ruby
# app/helpers/application_helper.rb
module ApplicationHelper
  def current_admin?
    current_user&.admin?
  end
end
```

---

## 6. Passwords

### 6.1 Validaciones Devise

| Validación | Regla |
|-----------|-------|
| Longitud password | Mínimo 6 caracteres |
| Formato | Cualquier caracter |
| Confirmación | Debe coincidir con password |

### 6.2 Encriptación

- Algoritmo: **BCrypt** (cost factor 12)
- Storage: `encrypted_password` en base de datos

---

## 7. Sesiones

### 7.1 Tipos de Sesión

| Tipo | Descripción | Duración |
|------|-------------|----------|
| **Session Cookie** | Cookie normal | Hasta cerrar navegador |
| **Remember Me** | Cookie persistente | 2 semanas |

### 7.2 Configuración

```ruby
# config/initializers/devise.rb
config.rememberable = true
config.cookie_expiration = 2.weeks
```

---

## 8. Reset de Contraseña

### 8.1 Flujo

```
USUARIO                        EMAIL
    │                             │
    │  POST /users/password/new    │
    │─────────────────────────────►│
    │                             │
    │  [Email con link]            │
    │◄─────────────────────────────│
    │                             │
    │  GET /users/password/edit    │
    │  ?reset_password_token=xxx   │
    │─────────────────────────────►│
    │                             │
    │  PATCH /users/password       │
    │  (con nuevo password)        │
    │─────────────────────────────►│
    │                             │
    │  Password actualizado ✓     │
```

---

## 9. Consideraciones de Seguridad

### 9.1 Protecciones Incluidas

| Protección | Implementación |
|------------|----------------|
| **CSRF** | Token en todos los forms |
| **Password Hashing** | BCrypt |
| **SQL Injection** | ActiveRecord sanitize |
| **Mass Assignment** | Strong parameters |
| **Session Fixation** | Regeneración de session ID |

### 9.2 Recomendaciones Futuras

| Mejora | Prioridad |
|--------|----------|
| Habilitar `confirmable` | Alta |
| Habilitar `lockable` | Media |
| 2FA (Two-Factor Auth) | Baja |
| OAuth con Google/GitHub | Media |

---

*Versión 1.0 - Blackstone*
