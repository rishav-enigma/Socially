class Post < ApplicationRecord
  enum visibility: {personal: 0, friends: 1, everyone: 2}
  belongs_to :user
end
