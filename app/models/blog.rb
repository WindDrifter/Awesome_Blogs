class Blog < ActiveRecord::Base

  belongs_to :category
  belongs_to :user

  #  has_many :comments assumes that you have a model Comment that has a reference
# to theis model (Blog) called blog_id (Integer)
# the dependent option is needed because we've added a foreign key Contraint
# to our database so the dependent records (in this case comments) must do
# something before deleting a blog that they reference. the options are:
# :destroy -> will delete all the comments referencing this blog before
#             deleting the blog
# :nullify -> will make comments_id field null in the database before deleting
#             the blog
  has_many :comments, dependent: :destroy

  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings


  has_many :likes, dependent: :destroy
  has_many :users, through: :likes

  has_many :favourites, dependent: :destroy
  has_many :favouriting_users, through: :favourites, source: :user

  has_many :votes, dependent: :destroy
  has_many :voters, through: :votes, source: :user

  validates :title, presence:true,
                    uniqueness:true,
                    length:    {minimum: 2}

  validates :body, presence:true


  validate :no_monkey

  before_save :capitalize_title

  #delegate :name, to: :category, prefix: true
  def category_name
    category.name
  end

  def user_name
     if user
       user.full_name
     else
       "Anonymous"
     end
  end

  def votes_count
    votes.select {|v| v.up? }.count - votes.select {|v| v.down? }.count
  end
  private

    def no_monkey
      if title.present? && title.downcase.include?("monkey")
        # this will add to the errors object attached to the current object.
        # if the errors object is not an empty Hash then rails treats the
        # record as invalid
        errors.add(:title, "can't have monkey!")
      end
    end

    def capitalize_title
    # self.title.capitalize!
    self.title = title.capitalize
  end



end
