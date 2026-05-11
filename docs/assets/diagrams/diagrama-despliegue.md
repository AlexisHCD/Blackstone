# Diagrama de Despliegue

```plantuml
@startuml

title Diagrama de Despliegue - Blackstone Production

node "Load Balancer" as lb {
  [Nginx\n(port 80/443)] as nginx
}

node "Application Server" as app_server {
  artifact "Blackstone App" as app_artifact
  [Puma Web Server\n(Workers: 4)] as puma
  [Rails Application\n(Ruby 3.3.0)] as rails
  [Sidekiq (Optional)\n(Background Jobs)] as sidekiq
}

node "Database Server" as db_server {
  [PostgreSQL 14+\n(Primary)] as postgres_primary
  [PostgreSQL 14+\n(Replica - Read Only)] as postgres_replica
}

node "Object Storage" as storage {
  [AWS S3 Bucket\n(Active Storage)] as s3
  [CloudFront CDN\n(Assets)] as cloudfront
}

node "Client" as client {
  [Web Browser\n(HTML/CSS/JS)] as browser
}

node "External Services" as external {
  [YouTube Servers\n(Video CDN)] as youtube
  [Google Fonts CDN] as google_fonts
}

' Conexiones
nginx --> puma : HTTP/1.1
puma --> rails : Rack
puma --> sidekiq : Async Jobs
rails --> postgres_primary : SQL Queries
postgres_primary --> postgres_replica : Replication
rails --> s3 : File Upload/Download
s3 --> cloudfront : CDN
cloudfront --> browser : Static Assets
browser --> youtube : Video Streaming
browser --> google_fonts : Fonts

' Notas
note right of nginx
  SSL Termination
  Load Balancing
  Static File Caching
end note

note right of puma
  Preloading App
  Connection Pooling
  Threads per Worker: 5
end note

note right of postgres_primary
  WAL Streaming
  Backups: Daily
end note

note right of s3
  Multipart Upload
  Versioning Enabled
  Lifecycle Policy
end note

@enduml
```

## Infraestructura de Producción

### Load Balancer (Nginx)
- SSL Termination
- Load Balancing (round-robin)
- Static File Caching
- Puerto 80/443

### Application Server
| Componente | Configuración |
|-----------|---------------|
| **Puma Web Server** | Workers: 4, Threads: 5 |
| **Rails Application** | Ruby 3.3.0, Rails 7.1.3 |
| **Sidekiq (Opcional)** | Background jobs |

### Database Server
| Componente | Función |
|-----------|---------|
| **PostgreSQL Primary** | Escrituras y lecturas principales |
| **PostgreSQL Replica** | Lecturas (read replica) |

### Object Storage
| Componente | Función |
|-----------|---------|
| **AWS S3 Bucket** | Active Storage para logos y archivos |
| **CloudFront CDN** | Distribución de assets estáticos |

### External Services
| Servicio | Uso |
|----------|-----|
| **YouTube Servers** | Streaming de videos de cursos |
| **Google Fonts CDN** | Tipografía (Inter, DM Serif Display, JetBrains Mono) |

## Comunicación Entre Componentes

| De | A | Protocolo |
|----|---|-----------|
| Browser | Nginx | HTTPS |
| Nginx | Puma | HTTP/1.1 |
| Rails | PostgreSQL | SQL (TCP) |
| Rails | S3 | HTTPS |
| S3 | CloudFront | Internal |
| Browser | YouTube | HTTPS |

## Configuración Recomendada

### Nginx
```nginx
upstream blackstone {
  server 127.0.0.1:3000;
}

server {
  listen 443 ssl;
  ssl_certificate /path/to/cert.pem;
  ssl_certificate_key /path/to/key.pem;

  location / {
    proxy_pass http://blackstone;
  }
}
```

### Puma
```ruby
workers 4
threads 5
```

### PostgreSQL
```sql
-- Indexes para performance
CREATE INDEX idx_video_progress_user_episode
ON video_progresses (user_id, course_episode_id);
```
