require "csv"
namespace :book do
  desc "export book to csv file"
  task export: :environment do
    time_stamp = Time.zone.now.strftime("%Y%m%dT%H%M")
    file_name = "export_book_#{time_stamp}.csv"

    data = Book.file_csv
    File.write(file_name, data)
  end
end
