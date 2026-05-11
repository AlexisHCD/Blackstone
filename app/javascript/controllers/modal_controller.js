import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["dialog"]

  open(event) {
    event.preventDefault()
    this.dialogTarget.classList.add("is-open")
  }

  close(event) {
    if (event) event.preventDefault()
    this.dialogTarget.classList.remove("is-open")
  }

  clickOutside(event) {
    if (event.target === this.dialogTarget) {
      this.close()
    }
  }
}
