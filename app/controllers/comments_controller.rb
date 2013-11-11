# -*- coding: utf-8 -*-
class CommentsController < ApplicationController
  def create
    if (1..60).include? params[:comment][:text].size
      Comment.create! comment_params
      render json: {comment_post: 'success'}
    else
      render json: {comment_post: 'failure', message: 'コメントは1文字以上60文字以内です'}
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text,:video_id,:player_id,:time)
  end
end
