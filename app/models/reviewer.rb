class Reviewer < ApplicationRecord
    has_secure_password
    validates_presence_of :password, on: :create
    validates :name, uniqueness: true, presence: true
    has_many :books
end