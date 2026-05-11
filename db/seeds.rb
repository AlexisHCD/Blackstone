# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.

puts "🌱 Iniciando seeds..."

# ─── Categories ───
puts "📂 Creando categorías..."
cats = {
  "Desarrollo"               => "Herramientas esenciales para escribir, probar y organizar código. Incluye editores, frameworks, APIs, testing y utilidades que forman la base del desarrollo moderno.",
  "Ciberseguridad & Redes"   => "Recursos y herramientas para entender la seguridad informática y el funcionamiento de redes. Incluye pentesting básico, análisis de tráfico y utilidades usadas en entornos reales.",
  "Inteligencia Artificial"  => "Herramientas de IA aplicadas a programación y productividad. Desde asistentes de código hasta plataformas que automatizan tareas y potencian el aprendizaje.",
  "DevOps, Hosting & Datos"  => "Tecnologías para desplegar aplicaciones, gestionar infraestructura y trabajar con datos. Incluye hostings, bases de datos, contenedores y herramientas clave del flujo profesional.",
  "Diseño & Productividad"   => "Herramientas para diseñar interfaces, organizar ideas y mejorar el flujo de trabajo. Incluye recursos visuales, diagramación y apps de productividad para desarrolladores.",
  "Aprendizaje & Carrera"    => "Plataformas, recursos y herramientas para aprender programación y avanzar profesionalmente. Incluye cursos, roadmap, portafolio y optimización de perfil laboral."
}

cats.each do |name, desc|
  Category.find_or_create_by!(name: name) { |c| c.description = desc }
end
puts "   ✅ #{Category.count} categorías"

# ─── Tools ───
puts "🛠️ Creando herramientas..."
tools_data = [
  { name: "Docker",                    cat: "DevOps, Hosting & Datos",  platform: "Multiplataforma", level: "Intermedio",     oss: true,  free: true,  url: "https://www.docker.com/" },
  { name: "Visual Studio Code",        cat: "Desarrollo",               platform: "Multiplataforma", level: "Principiante",   oss: true,  free: true,  url: "https://code.visualstudio.com" },
  { name: "Visual Studio Community",   cat: "Desarrollo",               platform: "Windows",         level: "Normal",         oss: false, free: true,  url: "https://visualstudio.microsoft.com/es/vs/community/" },
  { name: "Notion",                    cat: "Diseño & Productividad",   platform: "Web",             level: "Principiante",   oss: false, free: true,  url: "https://www.notion.com" },
  { name: "Git",                       cat: "Desarrollo",               platform: "Multiplataforma", level: "Normal",         oss: true,  free: true,  url: "https://git-scm.com/" },
  { name: "Kubernetes",                cat: "DevOps, Hosting & Datos",  platform: "Multiplataforma", level: "Intermedio",     oss: true,  free: true,  url: "https://kubernetes.io/" },
  { name: "Node.js",                   cat: "Desarrollo",               platform: "Multiplataforma", level: "Intermedio",     oss: true,  free: true,  url: "https://nodejs.org/es/" },
  { name: "IntelliJ IDEA Community",   cat: "Desarrollo",               platform: "Multiplataforma", level: "Intermedio",     oss: false, free: false, url: "https://www.jetbrains.com/idea/" },
  { name: "Postman",                   cat: "Desarrollo",               platform: "Multiplataforma", level: "Principiante",   oss: false, free: false, url: "https://www.postman.com" },
  { name: "Jenkins",                   cat: "DevOps, Hosting & Datos",  platform: "Multiplataforma", level: "Intermedio",     oss: true,  free: true,  url: "https://www.jenkins.io/" },
  { name: "Nmap",                      cat: "Ciberseguridad & Redes",   platform: "Multiplataforma", level: "Intermedio",     oss: true,  free: true,  url: "https://nmap.org/" },
  { name: "Wireshark",                 cat: "Ciberseguridad & Redes",   platform: "Multiplataforma", level: "Intermedio",     oss: true,  free: true,  url: "https://www.wireshark.org" },
  { name: "Claude Code",               cat: "Inteligencia Artificial",  platform: "Multiplataforma", level: "Intermedio",     oss: false, free: true,  url: "https://claude.ai/" },
  { name: "Metasploit Framework",      cat: "Ciberseguridad & Redes",   platform: "Multiplataforma", level: "Intermedio",     oss: true,  free: true,  url: "https://www.metasploit.com" },
  { name: "Terraform",                 cat: "DevOps, Hosting & Datos",  platform: "Multiplataforma", level: "Intermedio",     oss: true,  free: true,  url: "https://www.terraform.io" },
  { name: "OWASP ZAP",                 cat: "Ciberseguridad & Redes",   platform: "Multiplataforma", level: "Principiante",   oss: true,  free: true,  url: "https://www.zaproxy.org/" },
  { name: "Trello",                    cat: "Diseño & Productividad",   platform: "Web",             level: "Principiante",   oss: false, free: true,  url: "https://trello.com" },
  { name: "PostgreSQL",                cat: "DevOps, Hosting & Datos",  platform: "Multiplataforma", level: "Intermedio",     oss: true,  free: true,  url: "https://www.postgresql.org" },
  { name: "Figma",                     cat: "Diseño & Productividad",   platform: "Web",             level: "Principiante",   oss: false, free: true,  url: "https://www.figma.com" },
  { name: "Jira",                      cat: "Diseño & Productividad",   platform: "Web",             level: "Principiante",   oss: false, free: true,  url: "https://www.atlassian.com/es/software/jira" },
  { name: "Blender",                   cat: "Diseño & Productividad",   platform: "Multiplataforma", level: "Intermedio",     oss: true,  free: true,  url: "https://www.blender.org" },
  { name: "GIMP",                      cat: "Diseño & Productividad",   platform: "Multiplataforma", level: "Principiante",   oss: true,  free: true,  url: "https://www.gimp.org" },
  { name: "Google Gemini",             cat: "Inteligencia Artificial",  platform: "Web",             level: "Principiante",   oss: false, free: true,  url: "https://gemini.google.com" },
  { name: "Github",                    cat: "Desarrollo",               platform: "Web",             level: "Principiante",   oss: false, free: true,  url: "https://www.github.com" },
  { name: "ChatGPT",                   cat: "Inteligencia Artificial",  platform: "Web",             level: "Principiante",   oss: false, free: true,  url: "https://www.openai.com/chatgpt" },
  { name: "NotebookLM",                cat: "Inteligencia Artificial",  platform: "Web",             level: "Principiante",   oss: false, free: true,  url: "https://notebooklm.google/" },
  { name: "OpenCode",                  cat: "Inteligencia Artificial",  platform: "Multiplataforma", level: "Intermedio",     oss: true,  free: true,  url: "https://opencode.ai/" },
]

tools_data.each do |data|
  cat = Category.find_by!(name: data[:cat])
  Tool.find_or_create_by!(name: data[:name]) do |t|
    t.category  = cat
    t.platform  = data[:platform]
    t.level     = data[:level]
    t.open_source = data[:oss]
    t.free_tier   = data[:free]
    t.website_url = data[:url]
    t.description = "#{data[:name]} — #{cat.name}"
  end
end
puts "   ✅ #{Tool.count} herramientas"

# ─── Tool Logos ───
puts "🖼️ Adjuntando logos..."
logos = {
  "docker" => "docker.svg",
  "visual-studio-code" => "visual-studio-code.svg",
  "visual-studio-community" => "visual-studio.svg",
  "notion" => "notion.svg",
  "git" => "git.svg",
  "kubernetes" => "kubernetes.svg",
  "node-js" => "nodedotjs.svg",
  "intellij-idea-community" => "intellijidea.svg",
  "postman" => "postman.svg",
  "jenkins" => "jenkins.svg",
  "nmap" => "nmap_icon_132152.svg",
  "wireshark" => "wireshark.svg",
  "claude-code" => "claude.svg",
  "metasploit-framework" => "metasploit.svg",
  "terraform" => "terraform.svg",
  "owasp-zap" => "zap.svg",
  "trello" => "trello.svg",
  "postgresql" => "postgresql.svg",
  "figma" => "figma.svg",
  "jira" => "jira.svg",
  "blender" => "blender.svg",
  "gimp" => "gimp.svg",
  "google-gemini" => "googlegemini.svg",
  "github" => "github.svg",
  "chatgpt" => "openai.svg",
  "notebooklm" => "notebooklm.svg",
  "opencode" => "opencode-logo-light.svg"
}

logos.each do |slug, filename|
  tool = Tool.find_by(slug: slug)
  next unless tool
  next if tool.logo.attached?

  path = Rails.root.join("db", "seeds", "logos", filename)
  if File.exist?(path)
    tool.logo.attach(io: File.open(path), filename: filename)
    puts "   ✅ #{slug}"
  else
    puts "   ⚠️  #{filename} not found"
  end
end

# ─── Courses ───
puts "🎬 Creando cursos..."
courses_data = [
  { title: "Curso de Node.js desde cero", slug: "curso-de-node-js-desde-cero", cat: "Desarrollo", series: true, desc: "Aprendé Node.js paso a paso con este curso completo para principiantes.",
    episodes: [{ title: "Introducción a Node.js", youtube_id: "BhvLIzVL8_o", pos: 1, dur: 600 }] },
  { title: "Curso de GIT y GITHUB desde CERO", slug: "curso-de-git-y-github-desde-cero", cat: "Desarrollo", series: true, desc: "Dominá el control de versiones y colaborá en proyectos open source.",
    episodes: [{ title: "Curso de GIT y GITHUB DESDE CERO", youtube_id: "niPExbK8lSw", pos: 1, dur: 7800 }] },
  { title: "Curso COMPLETO de HTML GRATIS desde cero", slug: "curso-completo-de-html-gratis-desde-cero", cat: "Desarrollo", series: true, desc: "Aprendé HTML desde lo más básico hasta crear tus propias páginas web.",
    episodes: [{ title: "Curso COMPLETO de HTML GRATIS desde cero", youtube_id: "3nYLTiY5skU", pos: 1, dur: 7200 }] },
  { title: "Aprende SQL ahora! curso completo", slug: "aprende-sql-ahora-curso-completo", cat: "DevOps, Hosting & Datos", series: true, desc: "Dominá SQL desde cero con este curso práctico.",
    episodes: [{ title: "Aprende SQL ahora! HOLA MUNDO", youtube_id: "uUdKAYl-F7g", pos: 1, dur: 7200 }] },
  { title: "Curso COMPLETO Python ahora!", slug: "curso-completo-python-ahora", cat: "Desarrollo", series: true, desc: "Aprendé Python desde cero para principiantes con este curso completo 2025.",
    episodes: [{ title: "Curso COMPLETO de Python DESDE CERO para Principiantes 2025", youtube_id: "TkN2i-_4N4g", pos: 1, dur: 36000 }] },
]

courses_data.each do |data|
  cat = Category.find_by!(name: data[:cat])
  course = Course.find_or_create_by!(title: data[:title]) do |c|
    c.category  = cat
    c.is_series = data[:series]
    c.description = data[:desc]
  end

  data[:episodes].each do |ep|
    CourseEpisode.find_or_create_by!(course: course, position: ep[:pos]) do |e|
      e.title = ep[:title]
      e.youtube_id = ep[:youtube_id]
      e.youtube_url = "https://www.youtube.com/watch?v=#{ep[:youtube_id]}"
      e.duration_seconds = ep[:dur]
    end
  end
end
puts "   ✅ #{Course.count} cursos"

puts "✅ Seeds completadas."
