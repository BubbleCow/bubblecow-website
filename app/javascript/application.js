// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
// import "./test"
import "./bs_extra"
import * as bootstrap from "bootstrap"
import "trix"
import "@rails/actiontext"
import "chartkick/chart.js"


document.addEventListener("turbo:load", function(event) {
    window.dataLayer = window.dataLayer || []
    function gtag(){dataLayer.push(arguments)}
    gtag('js', new Date())
    gtag('config', 'G-CN4JXE1772', {'page_location': event.detail.url})
  }, false)