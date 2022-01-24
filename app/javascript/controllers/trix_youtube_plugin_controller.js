import { Controller } from "@hotwired/stimulus"
import Trix from 'trix'
import Rails from '@rails/ujs'

export default class extends Controller {
  connect() {
    this.addTrixButton()
    this.addTrixDialog()
    this.eventListenerForMediaButton()
    this.eventListenerForAddButton()
  }

  addTrixButton() {
    const buttonHTML = '<button type="button" class="trix-button" data-trix-attribute="embed" data-trix-action="embed" title="Embed" tabindex="-1">Media</button>'
    const buttonGroup = this.element.toolbarElement.querySelector(".trix-button-group--block-tools")
    buttonGroup.insertAdjacentHTML("beforeend", buttonHTML)
  }

  addTrixDialog() {
    const dialogHTML = `<div class="trix-dialog trix-dialog--link" data-trix-dialog="embed" data-trix-dialog-attribute="embed">
                          <div class="trix-dialog__link-fields">
                            <input type="text" name="embed" class="trix-input trix-input--dialog" placeholder="Paste your URL" aria-label="embed code" required="" data-trix-input="" disabled="disabled">
                            <div class="trix-button-group">
                              <input type="button" class="trix-button trix-button--dialog" data-trix-custom="add-embed" value="Add">
                            </div>
                          </div>
                        </div>`
    const dialogGroup = this.element.toolbarElement.querySelector(".trix-dialogs")
    dialogGroup.insertAdjacentHTML("beforeend", dialogHTML)
  }

  eventListenerForMediaButton() {
    document.querySelector('[data-trix-action="embed"]').addEventListener("click", event => {
      const dialog = document.querySelector('[data-trix-dialog="embed"]')
      const embedInput = document.querySelector('[name="embed"]')
      if (event.target.classList.contains("trix-active")) {
        event.target.classList.remove("trix-active");
        dialog.classList.remove("trix-active");
        delete dialog.dataset.trixActive;
        embedInput.setAttribute("disabled", "disabled");
      } else {
        event.target.classList.add("trix-active");
        dialog.classList.add("trix-active");
        dialog.dataset.trixActive = "";
        embedInput.removeAttribute("disabled");
        embedInput.focus();
      }
    })
  }

  eventListenerForAddButton() {
    document.querySelector('[data-trix-custom="add-embed"]').addEventListener("click", event => {
      const content = document.querySelector("[name='embed']").value
      if (content) {
        let _this = this
        let formData = new FormData()
        formData.append("content", content)
        Rails.ajax({
          type: 'PATCH',
          url: '/embed.json',
          data: formData,
          success: ({content, sgid}) => {
            const attachment = new Trix.Attachment({content, sgid})
            _this.element.editor.insertAttachment(attachment)
            _this.element.editor.insertLineBreak()
          }
        })
      }
    })
  }
}