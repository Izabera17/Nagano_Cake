class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :item

  enum crafting_status: {impossible: 0, wait: 1, production: 2, complete: 3}
end
