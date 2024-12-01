# app/jobs/update_comment_broadcast_job.rb
class UpdateCommentBroadcastJob < ApplicationJob
  queue_as :default

  def perform(comment)
    # Perform the regular update broadcast
    Turbo::StreamsChannel.broadcast_replace_to(
      comment.post,
      target: comment,
      partial: 'comments/comment',
      locals: { comment: comment }
    )
  end
end
