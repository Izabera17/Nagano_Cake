class Genre < ApplicationRecord
  has_many :items, dependent: :destroy
  
  enum valid_invalid_status: { 有効: 0, 無効: 1}
  
  validates :name, presence: true 

end
