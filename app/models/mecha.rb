class Mecha < ActiveRecord::Base
  has_many :mecha_names
  has_many :videos
  
  def full_name
    MechaName.find(full_name_id).name
  end

  def nickname
    MechaName.find(nickname_id).name
  end

end
