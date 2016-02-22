class CommentsController < ApplicationController

  before_action :authenticate_user!
  
  def create
    @post = Post.find(params[:comment][:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user
    @comment.save 
    respond_to do |format|
      format.html { redirect_to @post }
      format.js
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @post = @comment.post
    @comment.destroy
    redirect_to post_path(@post)
  end

  private

    def comment_params
      params.require(:comment).permit(:content)
    end

end