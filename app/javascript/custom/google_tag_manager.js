


// GTM
document.addEventListener("turbo:load", function(event) {
  window.dataLayer = window.dataLayer || []
  function gtag(){dataLayer.push(arguments)}
  gtm('js', new Date())
  gtm('config', 'GTM-K67GGW9', {'page_location': event.detail.url})
}, false)