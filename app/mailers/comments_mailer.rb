class CommentsMailer < ApplicationMailer

  def notify_blog_owner(comment)
    @comment        = comment
    @blog      = comment.blog
    @blog_user = @blog.user
    mail(to: @blog_user.email, subject: "You've got a comment!")
  end

end
