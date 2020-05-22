$(document).on("turbolinks:load", () => {
    ga('send', 'pageview', window.location.pathname);
    // call events - ga('send', "event", category, action, label, count);
})