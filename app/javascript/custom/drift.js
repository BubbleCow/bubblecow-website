document.addEventListener('turbolinks:load',
  () => {
    if (window.drift.ready) {
      window.drift.unload();
      window.drift.load('mdgc5huhubck');
    }
  })