namespace :data do
  desc 'seed diploma'
  task 'seed:diploma', [:file_name] => :environment do |_, args|
    csv_text = File.read(Rails.root.join(args[:file_name] || 'result.csv'))

    Diploma.load_csv(csv_text, true)
  end
end
