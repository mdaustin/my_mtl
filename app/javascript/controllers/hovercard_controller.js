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
      this.place()
    } else {
      fetch(this.urlValue)
        .then((response) => response.text())
        .then((html) => {
          const fragment = document.createRange().createContextualFragment(html);

          this.element.appendChild(fragment);
          this.place();
      });
    }
    }, 500);
  }

  // Open above the poster, or below it when there isn't room under the sticky header
  place() {
    if (!this.hasCardTarget) return

    const card = this.cardTarget
    const headerHeight = document.querySelector("header")?.offsetHeight || 0
    const roomAbove = this.element.getBoundingClientRect().top - headerHeight
    const below = roomAbove < card.offsetHeight + 16

    card.classList.toggle("bottom-full", !below)
    card.classList.toggle("mb-3", !below)
    card.classList.toggle("top-full", below)
    card.classList.toggle("mt-3", below)
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
