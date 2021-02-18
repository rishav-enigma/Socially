class CommentsController < ApplicationController
  def new
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      redirect_to root_path
    else
      flash.now[:danger] = "Couldnot Save your comment. Try again"
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:post_id, :content)
  end
end
