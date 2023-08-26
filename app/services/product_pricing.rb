class ProductPricing

  COUNTRY_TO_CURRENCY = {
    us: :usd,
    gb: :gbp,
    ca: :cad,
    au: :aud,
    nz: :nzd
  }.freeze

  EU_COUNTRIES = [
    :at, :be, :bg, :cy, :cz, :de, :dk, :ee, :es, :fi, 
    :fr, :gr, :hr, :hu, :ie, :it, :lt, :lu, :lv, :mt, 
    :nl, :po, :pt, :ro, :se, :si, :sk
  ].freeze

  CURRENCY_SYMBOLS = {
    usd: "$",
    gbp: "£",
    eur: "€",
    cad: "C$",
    aud: "A$",
    nzd: "NZ$"
  }.freeze

  attr_reader :country, :product, :currency

  def initialize(country, product_name)
    @country = country.downcase.to_sym
    @currency = if EU_COUNTRIES.include?(@country)
                  :eur
                else
                  COUNTRY_TO_CURRENCY[@country]
                end
    @product = Product.find_by(name: product_name)
    raise ArgumentError, "Product not found with name: #{product_name}" unless @product
  end

  def display_product_cost
    "#{CURRENCY_SYMBOLS[currency]}#{formatted_price(product_price)}"
  end

  def calculate_price(word_count)
    word_count.to_i * product_price
  end

  def product_price
    @product_price ||= @product.send("price_#{currency}")
  end

  private

  def formatted_price(price)
    price % 1 == 0 ? price.to_i : price
  end
end
