# Descripción de Lenguajes y Tecnologías Utilizadas

## Informe de Avance de Proyecto - Blackstone

---

## 1. Ruby: El lenguaje que impulsa Rails

Ruby es un lenguaje de programación interpretado, dinámico y orientado a objetos, creado por Yukihiro Matsumoto en 1995. Lo que hace a Ruby especial es su filosofía de diseño centrada en la productividad del desarrollador, con una sintaxis intuitiva y expresiva que busca minimizar el trabajo repetitivo.

Durante el desarrollo de Blackstone, aprendí que Ruby no es solo un lenguaje, sino un ecosistema completo. Bundler se encarga de gestionar las dependencias del proyecto, asegurándose de que cada gema esté en su versión correcta y sea compatible con las demás. Esto fue crucial cuando configuré Devise para la autenticación, ya que requería múltiples gemas que debían trabajar juntas sin conflictos.

Una de las características más poderosas que descubrí son los **bloques** y **procs**. Estas closures permiten pasar fragmentos de código como argumentos a métodos, habilitando patrones como iteradores limpios:

```ruby
# Ejemplo real de Blackstone - Iterar sobre categorías
categories.each do |category|
  puts category.name
end
```

También aprendí a appreciate la diferencia entre **símbolos** y **strings** en Ruby. Los símbolos son inmutables y se almacenan una sola vez en memoria, lo que los hace ideales para claves de hashes y identificadores:

```ruby
# Symbols vs Strings - memory efficiency
:category  # Un solo objeto en memoria
"category" # Nuevo objeto cada vez
```

La comunidad Ruby tiene una frase: *"Ruby fue diseñado para hacer feliz al programador"*. Tras meses de desarrollo, entiendo lo que esto significa: la sintaxis permite escribir código que se lee casi como inglés, reduciendo la carga cognitiva.

---

## 2. HTML/ERB: La estructura del contenido

HTML (HyperText Markup Language) es el lenguaje de marcado estándar para crear páginas web. Aunque no es un lenguaje de programación en sentido estricto, es la columna vertebral de toda aplicación web.

En Blackstone utilicé **ERB** (Embedded Ruby), un sistema de templates que permite incrustar código Ruby directamente en archivos HTML. Esto fue fundamental para renderizar contenido dinámico:

```erb
<!-- Ejemplo de Blackstone - Loop en ERB -->
<% @categories.each do |category| %>
  <div class="category-card">
    <h3><%= category.name %></h3>
    <p><%= category.description %></p>
  </div>
<% end %>
```

Aprendí que la semántica HTML es crucial para la accesibilidad. Usar etiquetas como `<main>`, `<nav>`, `<article>` en lugar de simplemente `<div>` mejora el SEO y la accesibilidad para lectores de pantalla.

También descubrí la importancia de **data attributes** para comunicar entre HTML y JavaScript via Stimulus:

```html
<!-- Blackstone - Conectar video player con data attributes -->
<div data-controller="video-player"
     data-video-player-youtube-id-value="<%= episode.youtube_id %>"
     data-video-player-episode-id-value="<%= episode.id %>">
</div>
```

---

## 3. CSS: El arte del diseño visual

CSS (Cascading Style Sheets) es el lenguaje que controla la presentación visual de las páginas web. Aunque al principio lo subestimé, aprendí que crear una interfaz coherente y atractiva requiere planificación y disciplina.

Para Blackstone, adopté un **design system** inspirado en Resend y Linear, empresas known for their premium dark UIs. Descubrí que un buen CSS no se trata de usar muchos colores, sino de usar pocos colores de manera estratégica:

```css
/* Blackstone - Tokens de diseño (variables CSS) */
:root {
  --color-void-black: #000000;      /* Fondo principal */
  --color-graphite-rail: #292d30;  /* Bordes */
  --color-frost: #f0f0f0;          /* Texto principal */
  --color-electric-blue: #3b9eff;  /* Acciones/CTA */
}
```

Aprendí el poder de **CSS Custom Properties** (variables) para mantener consistencia. Antes de usarlas, cambiar el color de un botón requería buscar y reemplazar en múltiples lugares. Con variables, solo cambio el valor en `:root`.

La propiedad `backdrop-filter` fue un descubrimiento importante para lograr efectos de glassmorphism en el header y modales:

```css
/* Blackstone - Glassmorphism effect */
.modal-overlay {
  background: rgba(0, 0, 0, 0.8);
  backdrop-filter: blur(25px);
}
```

También aprendí que **no todo debe ser una librería**. CSS puro, escrito con convenciones, es más mantenible que añadir Tailwind o Bootstrap para proyectos de este tamaño.

---

## 4. JavaScript: La interactividad del cliente

JavaScript es el único lenguaje de programación que funciona natively en los navegadores. Aunque modern Rails con Hotwire reduce la necesidad de escribir JavaScript manualmente, seguía siendo necesario para funcionalidades específicas.

En Blackstone, utilicé **Stimulus**, un framework JavaScript creado por Basecamp para complementar Turbo. A diferencia de React o Vue, Stimulus no controlа el DOM completo, sino que mejora elementos específicos:

```javascript
// Blackstone - Video Player Controller (Stimulus)
export default class extends Controller {
  static values = {
    youtubeId: String,
    episodeId: Number
  };

  connect() {
    this.player = new YT.Player(this.element, {
      videoId: this.youtubeIdValue,
      events: {
        onStateChange: this.onPlayerStateChange.bind(this)
      }
    });
  }

  onPlayerStateChange(event) {
    if (event.data === YT.PlayerState.PLAYING) {
      this.startProgressTracking();
    }
  }
}
```

Aprendí que el patrón de **targets** y **values** de Stimulus es elegante: los elementos del DOM se marcan con `data-action`, `data-target` o `data-value`, y Stimulus los conecta automáticamente. Esto reduce drásticamente el acoplamiento entre HTML y JavaScript.

También descubrí **YouTube IFrame API**, que permite controlar videos de YouTube programáticamente. Fue necesario para implementar el tracking de progreso:

```javascript
// Blackstone - Guardar progreso cada 15 segundos
startProgressTracking() {
  this.interval = setInterval(() => {
    if (this.player.getPlayerState() === YT.PlayerState.PLAYING) {
      const seconds = Math.floor(this.player.getCurrentTime());
      this.saveProgress(seconds);
    }
  }, 15000);
}
```

---

## 5. SQL y PostgreSQL: Persistencia de datos

SQL (Structured Query Language) es el lenguaje estándar para comunicarse con bases de datos relacionales. PostgreSQL es un sistema de gestión de bases de datos ORDBMS (Object-Relational Database Management System) que extiende SQL con características avanzadas.

Aprendí que Rails abstrae la mayor parte del SQL gracias a ActiveRecord, pero entender las consultas subyacentes es crucial para optimizar:

```sql
-- Consulta real generada por ActiveRecord
SELECT "tools".* FROM "tools"
WHERE "tools"."category_id" = $1
ORDER BY "tools"."name" ASC

-- Blackstone - Query con JOIN para obtener herramientas destacadas
SELECT
  tools.*,
  categories.name as category_name,
  featured_items.featured_on
FROM tools
INNER JOIN categories ON tools.category_id = categories.id
LEFT JOIN featured_items ON tools.id = featured_items.tool_id
WHERE categories.slug = 'desarrollo-web'
ORDER BY tools.name;
```

PostgreSQL tiene tipos de datos avanzados que descubrí durante el proyecto:

- **JSONB**: Para almacenar metadatos flexibles (Active Storage lo usa internamente)
- **Array**: Para listas dentro de columnas
- **Full-text search**: Para búsquedas futuras

Aprendí la importancia de los **índices** para performance. Sin índices, cada consulta escanea todas las filas:

```sql
-- Blackstone - Índices para evitar full table scans
CREATE INDEX idx_video_progress_user_episode
ON video_progresses (user_id, course_episode_id);

CREATE INDEX idx_featured_items_date
ON featured_items (featured_on);
```

---

## 6. Ruby on Rails: El framework completo

Rails es un framework de desarrollo web escrito en Ruby, creado por David Heinemeier Hansson en 2004. Es conocido por sus principios de **Convention Over Configuration** y **Don't Repeat Yourself (DRY)**.

Lo que más me impresionó fue cómo Rails estructura una aplicación completa. Después de aprender las convenciones, crear un CRUD completo toma minutos en lugar de horas:

```bash
# Generar scaffold completo con Rails
rails generate scaffold Tool name:string description:text website_url:string slug:string open_source:boolean free_tier:boolean platform:string level:string category:references
```

Rails sigue el patrón **MVC** (Model-View-Controller):

- **Model**: Representa los datos y la lógica de negocio (ActiveRecord)
- **View**: Presenta los datos (ERB templates)
- **Controller**: Maneja las requests y coordina models y views

Aprendí a appreciate la magia de **ActiveRecord**:
- Validaciones automáticas basadas en el schema
- Relaciones definidas con métodos simples (`has_many`, `belongs_to`)
- Callbacks para ejecutar lógica en momentos específicos del ciclo de vida

```ruby
# Blackstone - Ejemplo de modelo con relaciones y validaciones
class Tool < ApplicationRecord
  has_one_attached :logo
  belongs_to :category, optional: false
  has_many :favorite_tools, dependent: :destroy

  before_validation :generate_slug

  validates :name, presence: true
  validates :slug, presence: true, uniqueness: true
  validates :description, length: { maximum: 300 }
end
```

**Migraciones** fueron otro descubrimiento clave. Permiten versionar el schema de la base de datos como código:

```ruby
# Blackstone - Migración para crear tabla de herramientas
class CreateTools < ActiveRecord::Migration[7.1]
  def change
    create_table :tools do |t|
      t.string :name
      t.text :description
      t.string :website_url
      t.string :slug
      t.boolean :open_source
      t.boolean :free_tier
      t.string :platform
      t.string :level
      t.references :category, null: false, foreign_key: true
      t.timestamps
    end
  end
end
```

---

## 7. Hotwire: El futuro de Rails (y del frontend)

Hotwire es una metodología de desarrollo web de Basecamp que shipping con Rails 7. Reemplaza el JavaScript pesado con HTML sobre el wire, reduciendo significativamente la cantidad de JavaScript necesario.

**Turbo** acelera las páginas sin necesidad de JavaScript custom:
- **Drive**: Cada link maneja history del navegador automáticamente
- **Frames**: Actualiza partes específicas de la página
- **Streams**: Actualizaciones en tiempo real via WebSockets

**Stimulus** mejora elementos HTML existentes con comportamiento JavaScript.

La combinación permite crear SPAs (Single Page Applications) con código mostly HTML y muy poco JavaScript. En Blackstone, el JavaScript custom se limita a:
- Video Player Controller (~100 líneas)
- Modal Controller (~50 líneas)

Sin Hotwire, estimé que hubieran sido necesarias 500+ líneas de JavaScript vanilla o un framework completo como React.

---

## 8. Conclusión: Lo que aprendí

Este proyecto me enseñó que el desarrollo web moderno no es sobre elegir el framework más nuevo o la tecnología más hype, sino sobre elegir las herramientas correctas para el problema específico.

Rails + Hotwire demostró ser una combinación poderosa para un catálogo de contenido como Blackstone: rápido de desarrollar, fácil de mantener, y con excelente experiencia de usuario sin JavaScript excesivo.

Lo más importante fue entender que cada tecnología tiene su propósito:
- **Ruby** para lógica de backend limpia y expresiva
- **PostgreSQL** para datos persistentes y organizados
- **HTML/ERB** para estructura semántica
- **CSS** para diseño consistente y mantenible
- **JavaScript/Stimulus** para interactividad cuando es necesaria
- **Hotwire** para minimizar boilerplate sin sacrificar funcionalidad

---

*Informe elaborado durante el desarrollo del proyecto Blackstone*
*Fecha: Mayo 2026*
