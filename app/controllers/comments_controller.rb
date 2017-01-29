class CommentsController < ApplicationController
  before_filter :require_login, except: [:create]

  def create
    @comment = Comment.new(comment_params)
    @comment.article_id = params[:article_id]

    @comment.save

    flash.notice = "Comment created."

    redirect_to article_path(@comment.article)
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    redirect_to (article_path(@comment.article) + "#comments")
  end

  private

  def comment_params
    params.require(:comment).permit(:author_name, :body)
  end
end
