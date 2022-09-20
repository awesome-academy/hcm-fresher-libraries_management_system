module BooksHelper
  def check_img? book, file_img
    book.image.attached? ? book.image : file_img
  end

  def same_au books
    books.any? ? books : "layouts/no_same_au"
  end
end
