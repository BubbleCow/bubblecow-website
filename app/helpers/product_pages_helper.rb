module ProductPagesHelper

  def calculate_price(price_with_symbol)
    price = price_with_symbol.gsub(/[^0-9.]/, '').to_f
    price * 80
  end
  
  def display_cost(price_with_symbol, country)
    total_price = calculate_price(price_with_symbol)
    country_code = country.downcase.to_sym
    currency_key = if ProductPricing::EU_COUNTRIES.include?(country_code)
                     :eur
                   else
                     ProductPricing::COUNTRY_TO_CURRENCY[country_code] || :usd  # default to USD
                   end
    currency = ProductPricing::CURRENCY_SYMBOLS[currency_key]
    number_to_currency(total_price, unit: currency, format: "%u%n", precision: 0)
  end
  


end
