class Video < ActiveRecord::Base
  belongs_to :event
  # belongs_to mecha for each fours
end
