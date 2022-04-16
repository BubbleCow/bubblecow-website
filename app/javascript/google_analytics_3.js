// GA 3
document.addEventListener("turbo:load", function(event) {
    window.dataLayer = window.dataLayer || []
    function gtag(){dataLayer.push(arguments)}
    gtag('js', new Date())
    gtag('config', 'UA-743011-30', {'page_location': event.detail.url})
  }, false)


  