require 'csv'

namespace :data do
  desc 'seed diploma'
  task 'seed:diploma', [:file_name] => :environment do |_, args|
    csv_text = File.read(Rails.root.join(args[:file_name] || 'sample.csv'))
    csv = CSV.parse(csv_text, headers: true)

    csv.each do |row|
      puts row.inspect
      diploma = Diploma.find_or_initialize_by(name: row['Name1']) do |instance|
        instance.name = row['Name1']
        instance.rank = row['Rank']
        instance.course = row['Course']
        instance.club= row['Club1']
        instance.cardnumber = row['Card Number']
        instance.start = row['Start Time']
        instance.finish = row['Finish Time']
        instance.result = row['Result']
        instance.category = row['Category']
        instance.gameclass = row['Class']
      end
      result = diploma.save

      next if result

      puts '------- v 저장 실패 v -------'
      puts diploma.errors.inspect if diploma.errors.any?
      puts '------- ^ 저장 실패 ^ -------'
    end
  end
end
