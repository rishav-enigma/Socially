class User < ApplicationRecord
  mount_uploader :image, ImageUploader
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  validate :image_size
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  def feed
    posts_on_feed = Array(Post.where(visibility: "everyone"))
    posts.each do |post|
      posts_on_feed << post
    end
    post_on_feed = posts_on_feed.uniq.sort_by {|a| a.created_at}.reverse
  end

  def likes?(post)
    post.likes.where(user_id: id).any?
  end
  
  private
  def image_size
    errors.add(:image, "should be less than 5MB") if image.size >5.megabytes
  end
end
