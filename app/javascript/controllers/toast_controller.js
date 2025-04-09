import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  handleAnimationEnd(event) {
    if (event.animationName === 'slideOut') {
      this.element.remove()
    }
  }

  dismiss() {
    this.element.remove()
  }
}
