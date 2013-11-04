class Mecha < ActiveRecord::Base
  has_many :mecha_names
  has_many :videos
end
