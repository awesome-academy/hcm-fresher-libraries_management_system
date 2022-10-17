class StaticPagesController < ApplicationController
  def home
    @books = Book.take(12)
  end
end
