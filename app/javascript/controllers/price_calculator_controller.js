import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["wordCount", "result", "productPrice", "currencySymbol"];  // <-- added "currencySymbol"

  calculate() {
    const wordCount = parseFloat(this.wordCountTarget.value) || 0;
    const pricePerWord = parseFloat(this.productPriceTarget.dataset.price);
    
    let result = (wordCount / 1000) * pricePerWord;
  
    // Round up
    result = Math.ceil(result);

    // Get the currency symbol directly from the currencySymbol target
    const currencySymbol = this.currencySymbolTarget.textContent;
    this.resultTarget.textContent = `${result}`;
  }
}
