class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:create]
  before_action :set_post

  def create
    puts "Params: #{params.inspect}"
    puts "***#############********************** Current User Info: #{current_user.inspect} ***##############**********************&&&****" #debugging to see if current user is set 
    @comment = @post.comments.create!(comment_params)
    if @comment.save
      # mailer is not coonfigured yet
      #CommentsMailer.submitted(@comment).deliver_later
      redirect_to @post
    else 
    end
  end
  def comment_params
    params.require(:comment).permit(:content)
  end
  private
    def set_post
      @post = Post.find(params[:post_id].to_i)
    end
end
