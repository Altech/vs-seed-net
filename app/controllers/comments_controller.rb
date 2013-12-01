# -*- coding: utf-8 -*-
class CommentsController < ApplicationController
  def create
    # [TODO] forbid duplicate of triple: (player_id, video_id, text)
    if (1..30).include? params[:comment][:text].size and current_player
      comment = Comment.new comment_params
      comment.player_id = current_player.id
      comment.save
      expire_fragment view_context.event_path(Video.find(params[:comment][:video_id]).event)
      render json: {result: 'success', comment: comment.attributes}
    else
      render json: {result: 'failure', message: 'コメントは1文字以上60文字以内です'}
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text,:video_id,:time)
  end
end
