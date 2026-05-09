import { Controller } from "@hotwired/stimulus"

// Conecta con data-controller="modal" en el HTML
export default class extends Controller {
  static targets = ["dialog"]

  open() {
    this.dialogTarget.style.display = "flex"
    document.body.style.overflow = "hidden"
  }

  close() {
    this.dialogTarget.style.display = "none"
    document.body.style.overflow = ""
  }

  // Cerrar al hacer click fuera del modal
  clickOutside(event) {
    if (event.target === this.dialogTarget) {
      this.close()
    }
  }
}
