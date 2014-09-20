require 'csv'

def gen_csv(name)
  CSV.parse(File.read(Rails.root + "db/seeds/#{name}.csv"))
end

def seed_mecha(row)
  cost, full_name, nickname, abbrev_name = row.map(&:strip)
  cost = cost.to_i

  full_name, nickname, abbrev_name =
    [full_name, nickname, abbrev_name].map{|name|
    MechaName.find_by_name(name) || MechaName.create!(name: name)
  }
  full_name_id, nickname_id, abbrev_name_id = [full_name, nickname, abbrev_name].map(&:id)

  mecha = Mecha.find_by_name(full_name) || Mecha.create!(cost: cost, full_name_id: full_name_id, nickname_id: nickname_id)

  mecha.update_attribute(:nickname_id, nickname_id)
  mecha.update_attribute(:abbrev_name_id, abbrev_name_id)

  [full_name, nickname, abbrev_name].each do |name|
    name.update_attribute(:mecha_id, mecha.id)
  end
end

ActiveRecord::Base.transaction do
  gen_csv('mecha').each(&method(:seed_mecha))

  # [TODO] make idenpotent
  if false
    Pilot.delete_all

    csv = gen_csv('pilot')
    csv.each do |row|
      group = row[0]
      pilots = row[1..-1]
      pilots.each do |p|
        Pilot.create!(name: p, group: group)
      end
    end
  end

  # [TODO] make idenpotent
  if false
    csv = gen_csv('wiki_url')
    csv.each do |row|
      name, url = row[0], row[1]
      puts name
      mecha = MechaName.find_by_name(name).mecha
      mecha.update_attribute(:external_url, url)
    end
  end
end
