class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :blog

  validates :user_id, uniqueness: {scope: :blog_id}

  def down?
    !up?
  end

end
