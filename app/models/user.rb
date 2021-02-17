class User < ApplicationRecord
  mount_uploader :image, ImageUploader
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  validate :image_size
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  private
  def image_size
    errors.add(:image, "should be less than 5MB") if image.size >5.megabytes
  end
end
