class Mecha < ActiveRecord::Base
  has_many :mecha_names
  has_many :videos

  def self.find_by_name(name)
    case name
    when String
      MechaName.find_by_name(name).try(:mecha)
    when MechaName
      MechaName.find_by_name(name.name).try(:mecha)
    end
  end

  def to_param
    full_name
  end

  def full_name
    MechaName.find(full_name_id).name
  end

  def nickname
    MechaName.find(nickname_id).name
  end

  def abbrev_name
    MechaName.find(abbrev_name_id).name
  end

  def sorted_videos
    Rails.cache.fetch("mechas_sorted_videos_#{id}", expires_in: 30.minutes){
      videos.sort
    }
  end
end
