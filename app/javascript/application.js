// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import * as bootstrap from "bootstrap"

document.addEventListener("turbo:load", () => {
    var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'))
    var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
    return new bootstrap.Tooltip(tooltipTriggerEl)
    })
})



// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

// require("@rails/ujs").start()
// require("turbolinks").start()
// require("@rails/activestorage").start()

// require("local-time").start()
// require("custom/google_analytics")
// require("custom/drift")
// require("custom/custom_test")
// import "../stylesheets/application"

// import "./channels"
// import "./controllers"

// window.Rails = Rails

// import 'bootstrap'
// import 'data-confirm-modal'

// $(document).on("turbolinks:load", () => {
//   $('[data-toggle="tooltip"]').tooltip()
//   $('[data-toggle="popover"]').popover()
// })

// require("trix")
// require("@rails/actiontext")
// import "controllers"
// import * as bootstrap from "bootstrap"
