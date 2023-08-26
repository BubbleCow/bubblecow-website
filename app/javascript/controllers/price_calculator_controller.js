import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["wordCount", "result", "productPrice", "currencySymbol"];

  calculate() {
    const wordCount = parseFloat(this.wordCountTarget.value) || 0;
    const pricePerWord = parseFloat(this.productPriceTarget.dataset.price);
    
    if (wordCount < 15000) {
      this.resultTarget.textContent = "Below minimum word count";
      this.currencySymbolTarget.style.display = 'none';  // Hide currency symbol
      return;  // return early from the function
    } else {
      this.currencySymbolTarget.style.display = '';  // Show currency symbol
    }
    
    let result = (wordCount / 1000) * pricePerWord;

    // Round up
    result = Math.ceil(result);

    this.resultTarget.textContent = `${result}`;
  }
}
