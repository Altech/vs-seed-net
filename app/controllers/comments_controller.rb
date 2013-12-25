# -*- coding: utf-8 -*-
class CommentsController < ApplicationController
  def create
    if (1..30).include? params[:comment][:text].size
      comment = Comment.new comment_params
      comment.save
      expire_fragment view_context.event_path(Video.find(params[:comment][:video_id]).game.event)
      render json: {result: 'success', comment: comment.attributes}
    else
      render json: {result: 'failure', message: 'コメントは1文字以上30文字以内です'}
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text,:video_id,:time)
  end
end
