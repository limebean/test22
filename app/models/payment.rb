class Payment < ApplicationRecord
  belongs_to :parent
  belongs_to :teacher
  belongs_to :enrollment
end
