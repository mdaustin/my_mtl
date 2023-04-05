import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="hovercard"
export default class extends Controller {
  static targets = [ "card" ];
  static values = { url: String };

  show() {
    // Clear any existing timeout
    if (this.timeoutId) { clearTimeout(this.timeoutId); }

    // Set a timeout with the desired delay 
    this.timeoutId = setTimeout(() => {
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
    }, 500);
  }

  hide() {

    // Clear any existing timeout
    if (this.timeoutId) { clearTimeout(this.timeoutId); }

    if (this.hasCardTarget) {
      this.cardTarget.classList.add("hidden")
    }
  }

  disconnect() {
    // Clear any existing timeout
    if (this.timeoutId) { clearTimeout(this.timeoutId); }

    if (this.hasCardTarget) {
      this.cardTarget.remove();
    }
  }
}
