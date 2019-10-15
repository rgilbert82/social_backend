class Like < ApplicationRecord
  belongs_to :user
  belongs_to :image, optional: true
  belongs_to :post, optional: true
end
