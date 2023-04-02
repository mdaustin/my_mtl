import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="hovercard"
export default class extends Controller {
  static targets = [ "card" ];
  static values = { url: String };

  show() {
    if (this.hasCardTarget) {
      this.cardTarget.classList.remove("hidden")
    } else {
      fetch(this.urlValue)
        .then((response) => response.text())
        .then((html) => {
          const fragment = document.createRange().createContextualFragment(html);

          this.element.appendChild(fragment);
      });
    }
  }

  hide() {
    if (this.hasCardTarget) {
      this.cardTarget.classList.add("hidden")
    }
  }

  disconnect() {
    if (this.hasCardTarget) {
      this.cardTarget.remove();
    }
  }
}
