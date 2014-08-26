ActiveRecord::Base.transaction do
  if false
    Mecha.delete_all
    MechaName.delete_all

    require 'csv'
    csv = CSV.parse(File.read(Rails.root + 'db/seeds/mecha.csv'))

    csv.each do |row|
      cost, full_name, nickname = row[0].to_i, row[1].strip, row[2].strip
      abbrev_names = row[3..-1].map(&:strip)
      ids = []
      
      ids << MechaName.create!(name: full_name).id
      if full_name == nickname
        ids << ids.first
      else
        ids << MechaName.create!(name: nickname).id
      end
      abbrev_names.each do |abbrev_name|
        next if abbrev_name == full_name or abbrev_name == nickname
        ids << MechaName.create!(name: abbrev_name).id
      end
      mecha = Mecha.create!(cost: cost, full_name_id: ids[0], nickname_id: ids[1])
      ids.each do |id|
        MechaName.find(id).update_attribute(:mecha_id, mecha.id)
      end
    end
  end

  if false
    Pilot.delete_all

    require 'csv'
    csv = CSV.parse(File.read(Rails.root + 'db/seeds/pilot.csv'))
    csv.each do |row|
      group = row[0]
      pilots = row[1..-1]
      pilots.each do |p|
        Pilot.create!(name: p, group: group)
      end
    end
  end

  if false
    require 'csv'
    csv = CSV.parse(File.read(Rails.root + 'db/seeds/wiki_url.csv'))
    csv.each do |row|
      name, url = row[0], row[1]
      puts name
      mecha = MechaName.find_by_name(name).mecha
      mecha.update_attribute(:external_url, url)
    end
  end
end
