require 'csv'

class Diploma < ApplicationRecord

  def self.truncate
    ActiveRecord::Base.connection.execute("Delete from diplomas")
    ActiveRecord::Base.connection.execute("DELETE FROM SQLITE_SEQUENCE WHERE name='diplomas'")
  end

  def self.load_csv(csv_text, truncate)
    csv = CSV.parse(csv_text, headers: true)
    
    self.truncate if truncate

    csv.each do |row|
      puts row.inspect
      diploma = Diploma.find_or_initialize_by(name: row['Name1']) do |instance|
        instance.number = row['Number']
        instance.name = row['Name1']
        instance.rank = row['Rank']
        instance.course = row['Course']
        instance.club= row['Club1']
        instance.cardnumber = row['Card Number']
        instance.start = row['Start Time']
        instance.finish = row['Finish Time']
        instance.result = row['Result']
        instance.gameclass = row['Class']
      end
      result = diploma.save

      next if result

      puts diploma.errors.inspect if diploma.errors.any?
    end
  end

  def club_and_name
    text = "#{name} #{club}"
    text.length >= 12 ? name : text
  end
end