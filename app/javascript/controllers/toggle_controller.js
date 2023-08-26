import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "icon", "trigger" ]

  switch(event) {
    if (this.triggerTarget.getAttribute("aria-expanded") === "true") {
      this.iconTarget.classList.replace("bi-arrow-down", "bi-arrow-up");
    } else {
      this.iconTarget.classList.replace("bi-arrow-up", "bi-arrow-down");
    }
  }
}
