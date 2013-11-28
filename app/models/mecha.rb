class Mecha < ActiveRecord::Base
  has_many :mecha_names
  has_many :videos, foreign_key: :mecha_viewpoint_id

  def self.find_by_name(name)
    MechaName.find_by_name(name).mecha
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

end
