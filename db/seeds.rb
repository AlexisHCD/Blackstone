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
  { title: "Curso de Node.js desde cero", cat: "Desarrollo", series: true, desc: "Aprendé Node.js paso a paso con este curso completo para principiantes." },
  { title: "Curso de Git y GitHub desde cero", cat: "Desarrollo", series: true, desc: "Dominá el control de versiones y colaborá en proyectos open source." },
]

courses_data.each do |data|
  cat = Category.find_by!(name: data[:cat])
  Course.find_or_create_by!(title: data[:title]) do |c|
    c.category  = cat
    c.is_series = data[:series]
    c.description = data[:desc]
  end
end
puts "   ✅ #{Course.count} cursos"

puts "✅ Seeds completadas."
