class Comment < ActiveRecord::Base
  belongs_to :video
  belongs_to :player

  default_scope { order('time asc') }
end
