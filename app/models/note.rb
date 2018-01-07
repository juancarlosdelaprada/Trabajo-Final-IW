class Note < ApplicationRecord
  belongs_to :book
  
  validates :title, presence: true
  validates :note, presence: true
end
