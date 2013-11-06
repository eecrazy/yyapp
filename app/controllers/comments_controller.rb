# -*- coding: utf-8 -*-
class CommentsController < ApplicationController
  authorize_resource
  def create
    @app = App.find(params[:app_id])
    @comment = @app.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      flash[:success] = "评论成功"
    end
    redirect_to @app
  end

  private
  def comment_params
    params.require(:comment).permit(:comment)
  end

end
