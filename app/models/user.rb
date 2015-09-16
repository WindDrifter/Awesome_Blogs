class User < ActiveRecord::Base

  has_secure_password

  # we chose :nullify because we want when a user is deleted to just
  # have the user_id in the blogs table record become null instead
  # deleting the blogs
  has_many :blogs, dependent: :nullify
  has_many :comments, dependent: :nullify

  has_many :likes, dependent: :destroy
  has_many :liked_blogs, through: :likes, source: :blog

  has_many :favourites, dependent: :destroy
  has_many :favourited_blogs, through: :favourites, source: :blog

  has_many :votes, dependent: :destroy
  has_many :voted_blogs, through: :votes, source: :blog

  validates :email, presence: {message: "must be present"}, uniqueness: true,
            format: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

  def full_name
    "#{first_name} #{last_name}".strip
  end

  def liked_blog?(blog)
    liked_blogs.include?(blog)
  end

  def favourited_blog?(blog)
    favourited_blogs.include?(blog)
  end


end
