class Video < ActiveRecord::Base
  belongs_to :event
  belongs_to :mecha
  # belongs_to mecha for each fours
  has_attached_file :thumbnail,
    :storage => :s3,
    :s3_credentials => "#{Rails.root}/config/s3.yml",
    :path => "videos/:attachment/:id/:style.:extension"

end
