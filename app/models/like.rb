class Like < ActiveRecord::Base
  belongs_to :user
  belongs_to :blog

  # this will ensure that the user_id / blog_id combination is unique
  validates :blog_id, uniqueness: {scope: :user_id}
end
