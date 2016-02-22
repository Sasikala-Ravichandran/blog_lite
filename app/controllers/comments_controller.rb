class CommentsController < ApplicationController

  before_action :authenticate_user!
  
  def create
    @post = Post.find(params[:id])
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user
    @comment.save 
    redirect_to @post 
  end

  def destroy
    @comment = Comment.find(params[:id])
    @post.comments.destroy(@comment)
    redirect_to user_post_path(current_user, @post)
  end

  private

    def comment_params
      params.require(:comment).permit(:content)
    end

end