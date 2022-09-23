10.times do |n|
  Author.create!(
    name: Faker::Name.name,
    dob: Faker::Date.between(from: "1965-01-01", to: "1999-12-31"),
    info: Faker::Quote.famous_last_words,
  )
end

authors = Author.all

5.times do |n|
  authors.each do |author|
    book = author.books.create!(
    name: Faker::Book.title,
    describe: Faker::Quote.robin,
    category: rand(0..4),
    publisher: Faker::Book.publisher,
    quantity: rand(10..50)
    )
    book.image.attach({io: File.open(Rails.root.join("app", "assets", "images", "book_image.jpg")),
      filename: "book_image.jpg",
      content_type: "image/jpg"})
    book.image.variant(resize: "450x300")
  end
end

book_first = Book.first
book_first.update(
  name: "Dế mèn phiêu lưu ký",
  describe: "Tác phẩm miêu tả cuộc phiêu lưu của một chú Dế Mèn qua thế giới loài vật và loài người.",
  category: 0,
  publisher: "NXB Kim Đồng",
)
book_first.image.attach({io: File.open(Rails.root.join("app", "assets", "images", "demen.jpg")),
  filename: "demen.jpg",
  content_type: "image/jpg"})
book_first.image.variant(resize: "450x300")

author_first = Author.first
author_first.update(
  name: "Tô Hoài",
  info: "Tô Hoài (tên khai sinh: Nguyễn Sen; 27 tháng 9 năm 1920 – 6 tháng 7 năm 2014)[1] là một nhà văn Việt Nam. Một số tác phẩm đề tài thiếu nhi của ông được dịch ra ngoại ngữ."
)
