# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

workbook = Spreadsheet::ParseExcel.parse("#{Dir.getwd}/public/states_dump.xls")

workbook.worksheet(0).each(1) { |row|
  p "wwwwwwwwwwwwwwwwww",row.at(0).inspect
}