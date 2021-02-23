class Post < ApplicationRecord
  enum visibility: {personal: 0, friends: 1, everyone: 2}
  belongs_to :user
  has_many :comments, dependent: :destroy
  accepts_nested_attributes_for :comments, allow_destroy: true
  has_many :likes, dependent: :destroy
  validates :content, presence: true, length: {minimum: 2, maximum: 250}
end
