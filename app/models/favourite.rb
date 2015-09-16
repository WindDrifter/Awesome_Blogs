class Favourite < ActiveRecord::Base
  belongs_to :user
  belongs_to :blog

  validates :blog_id, uniqueness: {scope: :user_id}
end
