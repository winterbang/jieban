class TravelOther < ApplicationRecord
  serialize :destination
  has_many :reply_others
end
