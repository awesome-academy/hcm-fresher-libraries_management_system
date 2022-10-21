class Api::V1::BooksController < ApplicationController
  before_action :load_book, only: :show

  def index
    books = Book.order_name
    @books = ActiveModelSerializers::SerializableResource.new(books, {})
    render json: {status: true, data: {books: @books}}, status: :ok
  end

  def show
    @book = ActiveModelSerializers::SerializableResource.new(@book, {})
    render json: {status: true, data: {book: @book}}, status: :ok
  end

  private

  def load_book
    @book = Book.find_by id: params[:id]
    return if @book

    render json: {status: false, data: {}}, status: :not_found
  end
end
