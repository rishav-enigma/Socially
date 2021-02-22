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
  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships
  has_many :received_friendships, class_name: 'Friendship', foreign_key: 'friend_id'
  has_many :received_friends, through: :received_friendships, source: 'user'

  def friend_requests
    received_friends - active_friends
  end
  
  def active_friends
    friends.select{ |friend| friend.friends.include?(self) }  
  end

  def pending_friends
    friends.select{ |friend| !friend.friends.include?(self) }  
  end

  def public_posts
    Post.where(visibility: "everyone")
  end

  def feed
    posts_on_feed = public_posts.or(posts)
    active_friends.each do |friend|
      posts_on_feed = posts_on_feed.or(friend.posts.where(visibility: "friends"))
    end
    post_on_feed = posts_on_feed.order(created_at: :desc)
  end

  def likes?(post)
    post.likes.where(user_id: id).any?
  end
  
  def self.search(searchstring)
  	searchstring.strip!
    where("email like ?","%#{searchstring}%").or(where("name like ?","%#{searchstring}%").or(where("username like ?","%#{searchstring}%")))
  end

  private
  def image_size
    errors.add(:image, "should be less than 5MB") if image.size >5.megabytes
  end
end
