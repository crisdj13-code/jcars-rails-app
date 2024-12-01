class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:create]
  before_action :set_post

  def create
    puts "***#############********************** Current User Info: #{current_user.inspect} ***##############**********************&&&****" #debugging to see if current user is set 
    @comment = @post.comments.create! params.required(:comment).permit(:content)
    if @comment.save
      # mailer is not coonfigured yet
      #CommentsMailer.submitted(@comment).deliver_later
      redirect_to @post
    else 
    end
  end

  private
    def set_post
      @post = Post.find(params[:post_id])
    end
end
