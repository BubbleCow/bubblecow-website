import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    this.addTrixButton();
    this.addTrixDialog();
  }

  addTrixButton() {
    const buttonHTML = '<button type="button" class="trix-button" data-trix-attribute="embed" data-trix-action="embed" title="Embed" tabindex="-1">Media</button>';
    const buttonGroup = this.element.toolbarElement.querySelector(".trix-button-group--block-tools");
    buttonGroup.insertAdjacentHTML("beforeend", buttonHTML);
  }

  addTrixDialog() {
    const dialogHTML = `...`; // same as before
    const dialogGroup = this.element.toolbarElement.querySelector(".trix-dialogs");
    dialogGroup.insertAdjacentHTML("beforeend", dialogHTML);
  }

  // Use event delegation for dynamically added elements
  // Assume 'trix-toolbar' is a static parent element
  ['click->addMedia'](event) {
    if (event.target.matches('[data-trix-action="embed"]')) {
      // Your logic for media button click
    }
  }

  ['click->addEmbed'](event) {
    if (event.target.matches('[data-trix-custom="add-embed"]')) {
      // Your logic for add button click
    }
  }
}
