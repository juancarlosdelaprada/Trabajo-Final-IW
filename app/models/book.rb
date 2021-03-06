class Book < ApplicationRecord
  belongs_to :reviewer
  has_many :notes, dependent: :destroy
  
  validates :name, presence: true
  validates :author, presence: true
  has_attached_file :image, styles: {medium: "300x300>", thumb: "100x100>" }, default_url: "no-image.jpg"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
end