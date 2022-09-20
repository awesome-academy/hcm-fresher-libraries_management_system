# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
10.times do |n|
  Author.create!(
    name: Faker::Name.name,
    dob: Faker::Date.between(from: "1965-01-01", to: "1999-12-31"),
    info: Faker::Quote.famous_last_words,
  )
end

authors = Author.all

3.times do |n|
  authors.each do |author|
    book = author.books.create!(
    name: Faker::Book.title,
    describe: Faker::Quote.robin,
    category: Faker::Quote.robin,
    publisher: Faker::Book.publisher,
    quantity: rand(10..50)
    )
    book.image.attach({io: File.open(Rails.root.join("app", "assets", "images", "book_image.jpg")),
      filename: "book_image.jpg",
      content_type: "image/jpg"})
    book.image.variant(resize: "450x300")
  end
end
