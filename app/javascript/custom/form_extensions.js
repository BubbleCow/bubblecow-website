// Automatically sets the size of the text area.
document.addEventListener("turbo:load", function() {
    document.querySelectorAll('textarea').forEach(textarea => {
      // Set initial height based on scrollHeight
      textarea.style.height = textarea.scrollHeight + 'px';
      textarea.style.overflowY = 'hidden';
  
      // Adjust height on input
      textarea.addEventListener('input', function() {
        this.style.height = 'auto';
        this.style.height = this.scrollHeight + 'px';
      });
    });
  });
  