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

  CURRENCY_VALUES = {
    usd: { 
      developmental_editing: 25, 
      manuscript_assessment: 20, 
      copy_editing: 15, 
      ebook_conversion: 1 
    },
    gbp: { 
      developmental_editing: 20, 
      manuscript_assessment: 16, 
      copy_editing: 12, 
      ebook_conversion: 1 
    },
    eur: { 
      developmental_editing: 25, 
      manuscript_assessment: 20, 
      copy_editing: 15, 
      ebook_conversion: 1 
    },
    cad: { 
      developmental_editing: 35, 
      manuscript_assessment: 26, 
      copy_editing: 20, 
      ebook_conversion: 1 
    },
    aud: { 
      developmental_editing: 37, 
      manuscript_assessment: 30, 
      copy_editing: 22, 
      ebook_conversion: 1 
    },
    nzd: { 
      developmental_editing: 40, 
      manuscript_assessment: 32, 
      copy_editing: 24, 
      ebook_conversion: 1 
    }
  }.freeze

  CURRENCY_SYMBOLS = {
    usd: "$",
    gbp: "£",
    eur: "€",
    cad: "C$",
    aud: "A$",
    nzd: "NZ$"
  }.freeze

  attr_reader :country, :product, :currency

  def initialize(country, product)
    @country = country.downcase.to_sym
    @currency = if EU_COUNTRIES.include?(@country)
                  :eur
                else
                  COUNTRY_TO_CURRENCY[@country]
                end
    @product = product.downcase.gsub(' ', '_').to_sym
  end

  def display_product_cost
    "#{CURRENCY_SYMBOLS[currency]}#{CURRENCY_VALUES[currency][product]}"
  end

  def calculate_price(word_count)
    word_count.to_i * CURRENCY_VALUES[currency][product]
  end

end
