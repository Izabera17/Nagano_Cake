class Item < ApplicationRecord
  has_one_attached :image
  has_many :cart_items, dependent: :destroy
  has_many :order_details, dependent: :destroy
  
  belongs_to :genre, optional: true
  
  validates :name, presence: true
  validates :introduction, presence: true
  validates :price, presence: true
  
    def self.search(search)
        if search
          where(['name LIKE ?', "%#{search}%"]) 
        else
          all 
        end
    end
end
  