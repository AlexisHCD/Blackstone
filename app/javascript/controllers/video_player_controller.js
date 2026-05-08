import { Controller } from "@hotwired/stimulus"

// Conecta con data-controller="video-player" en el HTML
export default class extends Controller {
  static values = {
    episodeId: Number,
    youtubeId: String,
    startAt: Number,
    csrfToken: String
  }

  connect() {
    this.player = null
    this.saveInterval = null
    this.loadYouTubeAPI()
  }

  disconnect() {
    if (this.saveInterval) clearInterval(this.saveInterval)
  }

  loadYouTubeAPI() {
    // Si la API ya está cargada, inicializar directamente
    if (window.YT && window.YT.Player) {
      this.initPlayer()
      return
    }

    // Cargar el script de la API de YouTube
    if (!document.querySelector('script[src*="youtube.com/iframe_api"]')) {
      const tag = document.createElement("script")
      tag.src = "https://www.youtube.com/iframe_api"
      document.head.appendChild(tag)
    }

    // Esperar a que la API esté lista
    window.onYouTubeIframeAPIReady = () => {
      // Inicializar todos los players pendientes
      document.querySelectorAll('[data-controller="video-player"]').forEach(el => {
        const controller = this.application.getControllerForElementAndIdentifier(el, "video-player")
        if (controller && !controller.player) {
          controller.initPlayer()
        }
      })
    }
  }

  initPlayer() {
    const container = this.element.querySelector(".yt-player-container")
    if (!container) return

    this.player = new YT.Player(container, {
      videoId: this.youtubeIdValue,
      playerVars: {
        start: this.startAtValue || 0,
        rel: 0,
        modestbranding: 1
      },
      events: {
        onStateChange: this.onPlayerStateChange.bind(this)
      }
    })
  }

  onPlayerStateChange(event) {
    // YT.PlayerState.PLAYING === 1
    if (event.data === 1) {
      // Guardar progreso cada 15 segundos mientras está reproduciéndose
      this.saveInterval = setInterval(() => {
        this.saveProgress()
      }, 15000)
    } else {
      // Pausado, finalizado, etc — guardar una última vez y detener el intervalo
      if (this.saveInterval) {
        clearInterval(this.saveInterval)
        this.saveInterval = null
      }
      this.saveProgress()
    }
  }

  saveProgress() {
    if (!this.player || typeof this.player.getCurrentTime !== "function") return

    const currentTime = Math.floor(this.player.getCurrentTime())
    if (currentTime <= 0) return

    const token = this.csrfTokenValue || document.querySelector('meta[name="csrf-token"]')?.content

    fetch("/video_progress", {
      method: "PATCH",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": token
      },
      body: JSON.stringify({
        course_episode_id: this.episodeIdValue,
        seconds_watched: currentTime
      })
    })
    .then(response => response.json())
    .then(data => {
      // Actualizar la barra de progreso visual si existe
      const bar = this.element.querySelector(".progress-bar__fill")
      if (bar && data.seconds_watched) {
        const duration = parseInt(this.element.dataset.duration) || 1
        const percent = Math.min((data.seconds_watched / duration) * 100, 100)
        bar.style.width = percent + "%"
      }
      // Marcar como completado
      if (data.completed) {
        const badge = this.element.querySelector(".episode-completed-badge")
        if (badge) badge.style.display = "inline-block"
      }
    })
    .catch(() => {})
  }
}
