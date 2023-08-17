import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["wordCount", "price"]

  updatePrice() {
    let wordCount = this.wordCountTarget.value
    let product = this.data.get("product")

    if (wordCount !== "") {
      fetch(`/calculate_price?word_count=${wordCount}&product=${product}`, {
        headers: { "Accept": "application/json" },
      })
        .then(response => response.json())
        .then(data => {
          this.priceTarget.innerHTML = data.price
        })
    } else {
      this.priceTarget.innerHTML = "Please enter a word count"
    }
  }
}
