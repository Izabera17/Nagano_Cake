class Item < ApplicationRecord
  has_one_attached :image
  has_many :cart_items, dependent: :destroy
  has_many :order_details, dependent: :destroy
  belongs_to :genres, optional: true
  
  enum genre_id: { baked_sweets: 0, cake: 1, pudding: 2, candy: 3}
  
  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit: [width, height]).processed
    end
  end
  