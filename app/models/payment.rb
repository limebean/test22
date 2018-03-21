class Payment < ApplicationRecord
  belongs_to :parent
  belongs_to :tecaher
end
