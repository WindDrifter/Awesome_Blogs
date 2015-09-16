class Comment < ActiveRecord::Base

belongs_to :blog
belongs_to :user

validates :body, presence: {message: "Comment is required"},
                   # comment body is unique per blog
                   uniqueness: {scope: :blog_id}
def self.latest_first
  order("created_at DESC")
end

def user_name
   if user
     user.full_name
   else
     "Anonymous"
   end
end
end
