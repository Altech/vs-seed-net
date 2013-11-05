# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Mecha and MechaNames
ActiveRecord::Base.transaction do 
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
