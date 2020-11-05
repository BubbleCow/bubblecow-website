class ServicePrice < ApplicationRecord

    # scope
    scope :developmental_edit, -> { where(service_type: "Developmental Editing") }
    scope :developmental_edit_uk_price, -> { developmental_edit.where(currency: "gbp") }
    scope :developmental_edit_us_price, -> { developmental_edit.where(currency: "usd") }
    scope :developmental_edit_euro_price, -> { developmental_edit.where(currency: "euro") }
    scope :developmental_edit_oz_price, -> { developmental_edit.where(currency: "aud") }
end
