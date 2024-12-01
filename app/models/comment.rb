=begin class Comment < ApplicationRecord
  belongs_to :post
  broadcasts_to :post
  validates_presence_of :content
end 
=end 

class Comment < ApplicationRecord
  belongs_to :post

  # Append a new comment with the "new" indicator
  after_create_commit -> { broadcast_append_to post, partial: 'comments/new_comment', locals: { comment: self } }

 
 # Schedule an update broadcast after a delay
 after_update_commit -> { UpdateCommentBroadcastJob.set(wait: 10.seconds).perform_later(self) }
   # Replace or update an existing comment
 #after_update_commit -> { broadcast_replace_to post, partial: 'comments/comment', locals: { comment: self } }
end
