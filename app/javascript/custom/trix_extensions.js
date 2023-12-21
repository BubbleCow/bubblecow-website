// https://stackoverflow.com/questions/58805984/add-buttons-to-rails-actiontext-toolbar
//  https://stackoverflow.com/questions/71712319/how-to-customize-the-trix-toolbar-in-rails-7-when-using-importmaps
document.addEventListener('trix-initialize', function() {
  extendTrixToolbar();
});

function extendTrixToolbar() {
  Trix.config.textAttributes.underline = { tagName: 'u', inheritable: true };
  Trix.config.blockAttributes.heading1 = { tagName: 'h1', terminal: true, breakOnReturn: true };
  Trix.config.blockAttributes.heading2 = { tagName: 'h2', terminal: true, breakOnReturn: true };
  Trix.config.blockAttributes.heading3 = { tagName: 'h3', terminal: true, breakOnReturn: true };
  Trix.config.blockAttributes.heading4 = { tagName: 'h4', terminal: true, breakOnReturn: true };

  const toolbarElement = document.querySelector("trix-toolbar");
  const buttonHTML = buildButtonHTML();
  toolbarElement.innerHTML = toolbarElement.innerHTML + buttonHTML;
}

function buildButtonHTML() {
  const lang = Trix.config.lang; // Assuming Trix.config.lang is defined and has the necessary properties
  return `
    <!-- Add your custom button HTML here -->
    <button type="button" class="trix-button" data-trix-attribute="heading1">H1</button>
    <button type="button" class="trix-button" data-trix-attribute="heading2">H2</button>
    <!-- ... other buttons ... -->
  `;
}
