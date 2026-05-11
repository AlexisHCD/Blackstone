# Flujos de Autenticación - Blackstone

## Diagramas

| Diagrama | Descripción |
|----------|-------------|
| **Flujo de registro** | Proceso de creación de cuenta con Devise |
| **Flujo de login** | Autenticación con email/password |
| **Flujo OAuth Google** | Login con Google (configurado) |
| **Flujo OAuth Microsoft** | Login con Microsoft (pendiente de credenciales) |
| **Flujo de reset password** | Recuperación de contraseña |

## Proveedores de autenticación

| Proveedor | Estado | Configuración |
|-----------|--------|---------------|
| **Email/Password** | ✅ Activo | Devise database_authenticatable |
| **Google OAuth** | ✅ Activo | omniauth-google-oauth2 |
| **Microsoft OAuth** | ⏳ Pendiente | omniauth-microsoft_graph (falta credenciales) |

## Roles de usuario

| Rol | Campo | Permisos |
|-----|-------|----------|
| **Usuario regular** | `admin: false` | Favoritos, progreso, contacto |
| **Administrador** | `admin: true` | CRUD completo, gestión de usuarios |
