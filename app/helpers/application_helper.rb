module ApplicationHelper
  # SEO Helper Methods
  
  def page_title(title = nil)
    if title
      content_for(:title) { "#{title} | Blackstone" }
    else
      content_for?(:title) ? content_for(:title) : "Blackstone — Directorio de Herramientas y Cursos para Desarrolladores"
    end
  end

  def page_description(description = nil)
    if description
      content_for(:description) { description }
    else
      content_for?(:description) ? content_for(:description) : "Blackstone es un directorio de herramientas de desarrollo y cursos para estudiantes de programación. Explora herramientas por categoría, guarda favoritos y trackea tu progreso de aprendizaje."
    end
  end

  def page_keywords(keywords = nil)
    if keywords
      content_for(:keywords) { keywords }
    else
      content_for?(:keywords) ? content_for(:keywords) : "herramientas desarrollo, cursos programación, desarrollo web, ciberseguridad, devops, inteligencia artificial, ruby on rails, python, javascript, open source, free tier"
    end
  end

  def page_image(image_url = nil)
    if image_url
      content_for(:image) { image_url }
    else
      content_for?(:image) ? content_for(:image) : "#{request.base_url}/og-image.png"
    end
  end

  def canonical_url
    content_for?(:canonical) ? content_for(:canonical) : request.original_url
  end

  def structured_data(type, data = nil)
    json = case type
    when :organization
      {
        "@context": "https://schema.org",
        "@type": "Organization",
        "name": "Blackstone",
        "url": request.base_url,
        "description": "Directorio de herramientas de desarrollo y cursos para estudiantes de programación",
        "logo": "#{request.base_url}/logo.png",
        "sameAs": []
      }.to_json
    when :website
      {
        "@context": "https://schema.org",
        "@type": "WebSite",
        "name": "Blackstone",
        "url": request.base_url,
        "description": page_description,
        "potentialAction": {
          "@type": "SearchAction",
          "target": "#{request.base_url}/tools?q={search_term_string}",
          "query-input": "required name=search_term_string"
        }
      }.to_json
    when :breadcrumb
      {
        "@context": "https://schema.org",
        "@type": "BreadcrumbList",
        "itemListElement": data.map.with_index(1) { |item, index|
          {
            "@type": "ListItem",
            "position": index,
            "name": item[:name],
            "item": item[:url]
          }
        }
      }.to_json
    when :software_application
      {
        "@context": "https://schema.org",
        "@type": "SoftwareApplication",
        "name": data[:name],
        "description": data[:description],
        "url": data[:url],
        "applicationCategory": "DeveloperApplication",
        "operatingSystem": data[:platform],
        "offers": data[:free_tier] ? {
          "@type": "Offer",
          "price": "0",
          "priceCurrency": "USD"
        } : nil,
        "aggregateRating": nil
      }.compact.to_json
    when :course
      {
        "@context": "https://schema.org",
        "@type": "Course",
        "name": data[:title],
        "description": data[:description],
        "url": data[:url],
        "provider": {
          "@type": "Organization",
          "name": "Blackstone",
          "sameAs": request.base_url
        }
      }.to_json
    end

    return nil unless json
    %(<script type="application/ld+json">\n#{json}\n</script>).html_safe
  end
end
