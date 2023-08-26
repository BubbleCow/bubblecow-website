module CustomerPagesHelper

      def calculate_price(price_with_symbol)
    price = price_with_symbol.gsub(/[^0-9.]/, '').to_f
    price * 80
  end
  
  def display_cost(price_with_symbol, country)
    total_price = calculate_price(price_with_symbol)
    currency = ProductPricing::CURRENCY_SYMBOLS[ProductPricing::COUNTRY_TO_CURRENCY[country.downcase.to_sym] || (ProductPricing::EU_COUNTRIES.include?(country.downcase.to_sym) ? :eur : nil)]
    number_to_currency(total_price, unit: currency, format: "%u%n", precision: 0)
  end


end
