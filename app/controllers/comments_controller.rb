class CommentsController < ApplicationController
  load_and_authorize_resource only: [:edit, :new, :update, :create, :destroy]
  def new
  end

  def edit
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
  end

  def update
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to @post, notice: "Comment was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      flash[:notice] = "Your comment was saved successfully"
      redirect_to @post
    else
      flash.now[:danger] = "Couldnot Save your comment. Try again"
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
    @comment.destroy
    flash[:alert] = "Your comment was deleted successfully"
    redirect_to @post
  end


  private
  def comment_params
    params.require(:comment).permit(:post_id, :content)
  end
end
