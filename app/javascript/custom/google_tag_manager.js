document.addEventListener("turbo:load", function(event) {
  window.dataLayer = window.dataLayer || [];
  
  function gtag() {
    dataLayer.push(arguments);
  }

  gtag('js', new Date());
  gtag('config', 'GTM-K67GGW9', {
    'page_path': event.detail.url
  });
}, false);
