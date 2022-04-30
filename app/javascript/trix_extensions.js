// https://stackoverflow.com/questions/58805984/add-buttons-to-rails-actiontext-toolbar
//  https://stackoverflow.com/questions/71712319/how-to-customize-the-trix-toolbar-in-rails-7-when-using-importmaps

import Trix from 'trix';

window.Trix = Trix; // Don't need to bind to the window, but useful for debugging.
Trix.config.toolbar.getDefaultHTML = toolbarDefaultHTML;

// trix-before-initialize runs too early.
// We only need to do this once. Everything after initialize will get the
// defaultHTML() call automatically.
document.addEventListener('trix-initialize', updateToolbars, { once: true });

function updateToolbars(event) {
  const toolbars = document.querySelectorAll('trix-toolbar');
  const html = Trix.config.toolbar.getDefaultHTML();
  toolbars.forEach((toolbar) => (toolbar.innerHTML = html));
}

Trix.config.textAttributes.underline = {
  tagName: 'u'
}
Trix.config.blockAttributes.heading1 = {
  tagName: 'h1'
}
Trix.config.blockAttributes.heading2 = {
  tagName: 'h2'
}
Trix.config.blockAttributes.heading3 = {
  tagName: 'h3'
}
Trix.config.blockAttributes.heading3 = {
  tagName: 'h4'
}
const {lang} = Trix.config;
/**
 * This is the default Trix toolbar. Feel free to change / manipulate it how you would like.
 * see https://github.com/basecamp/trix/blob/main/src/trix/config/toolbar.coffee
 */
function toolbarDefaultHTML() {
  const {lang} = Trix.config;
  return `
  <div class="trix-button-row">
     <span class="trix-button-group trix-button-group--text-tools" data-trix-button-group="text-tools">
       <button type="button" class="trix-button trix-button--icon trix-button--icon-bold" data-trix-attribute="bold" data-trix-key="b" title="${lang.bold}" tabindex="-1">#{lang.bold}</button>
       <button type="button" class="trix-button trix-button--icon trix-button--icon-italic" data-trix-attribute="italic" data-trix-key="i" title="${lang.italic}" tabindex="-1">${lang.italic}</button>
       <button type="button" class="trix-button trix-button--icon trix-button--icon-link" data-trix-attribute="href" data-trix-action="link" data-trix-key="k" title="${lang.link}" tabindex="-1">${lang.link}</button>
     </span>
     <span class="trix-button-group trix-button-group--block-tools" data-trix-button-group="block-tools">
        <button type="button" class="trix-button" data-trix-attribute="heading1" title="h1" tabindex="-1">H1</button>
        <button type="button" class="trix-button" data-trix-attribute="heading2" title="h2" tabindex="-1">H2</button>
        <button type="button" class="trix-button" data-trix-attribute="heading3" title="h3" tabindex="-1">H3</button>
        <button type="button" class="trix-button" data-trix-attribute="heading4" title="h3" tabindex="-1">H4</button>
        <button type="button" class="trix-button trix-button--icon trix-button--icon-quote" data-trix-attribute="quote" title="${lang.quote}" tabindex="-1">${lang.quote}</button>
        <button type="button" class="trix-button trix-button--icon trix-button--icon-bullet-list" data-trix-attribute="bullet" title="${lang.bullets}" tabindex="-1">${lang.bullets}</button>
        <button type="button" class="trix-button trix-button--icon trix-button--icon-number-list" data-trix-attribute="number" title="${lang.numbers}" tabindex="-1">${lang.numbers}</button>
        <button type="button" class="trix-button trix-button--icon trix-button--icon-decrease-nesting-level" data-trix-action="decreaseNestingLevel" title="${lang.outdent}" tabindex="-1">${lang.outdent}</button>
        <button type="button" class="trix-button trix-button--icon trix-button--icon-increase-nesting-level" data-trix-action="increaseNestingLevel" title="${lang.indent}" tabindex="-1">${lang.indent}</button>
     </span>
     <span class="trix-button-group trix-button-group--file-tools" data-trix-button-group="file-tools">
       <button type="button" class="trix-button trix-button--icon trix-button--icon-attach" data-trix-action="attachFiles" title="${lang.attachFiles}" tabindex="-1">${lang.attachFiles}</button>
     </span>
     <span class="trix-button-group-spacer"></span>
     <span class="trix-button-group trix-button-group--history-tools" data-trix-button-group="history-tools">
       <button type="button" class="trix-button trix-button--icon trix-button--icon-undo" data-trix-action="undo" data-trix-key="z" title="${lang.undo}" tabindex="-1">${lang.undo}</button>
       <button type="button" class="trix-button trix-button--icon trix-button--icon-redo" data-trix-action="redo" data-trix-key="shift+z" title="${lang.redo}" tabindex="-1">${lang.redo}</button>
     </span>
   </div>
`;
}