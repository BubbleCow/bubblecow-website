// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import "trix"
import "@rails/actiontext"
import * as bootstrap from "bootstrap"

// This code is loading after turbo. ust add new code, don't forget the ;

document.addEventListener("turbo:load", () => {

    // Test code
    // console.log('test is working');
  
    // Bootstrap
    var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'))
    var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
    return new bootstrap.Tooltip(tooltipTriggerEl)
    });

    //Google
    ga('send', 'pageview', window.location.pathname);
    // call events - ga('send', "event", category, action, label, count);

})