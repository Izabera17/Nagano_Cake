class Address < ApplicationRecord
   belongs_to :customer, optional: true
   
   validates :postal_code, :address, :name, presence: true
   
   def address_display
    '〒' + postal_code + ' ' + address + ' ' + name
  end
end
