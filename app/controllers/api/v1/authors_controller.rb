class Api::V1::AuthorsController < ApplicationController
  before_action :load_author, only: %i(show update destroy)

  def index
    authors = Author.order_by_name
    @authors = authors.map{|author| AuthorSerializer.new(author)}
    render json: {data: {authors: @authors}}, status: :ok
  end

  def show
    @author = AuthorSerializer.new(@author)
    render json: {data: {author: @author}}, status: :ok
  end

  def create
    @author = Author.new author_params
    if @author.save
      @author = AuthorSerializer.new(@author)
      render json: {data: {author: @author}}, status: :created
    else
      render json: {error: @author.errors}, status: :unprocessable_entity
    end
  end

  def update
    if @author.update author_params
      @author = AuthorSerializer.new(@author)
      render json: {data: {author: @author}}, status: :created
    else
      render json: {error: @author.errors}, status: :unprocessable_entity
    end
  end

  def destroy
    if @author.destroy
      render json: {data: {}}, status: :ok
    else
      render json: {error: @author.errors}, status: :unprocessable_entity
    end
  end

  private

  def author_params
    params.require(:author).permit(Author::PERMIT_ATTRS)
  end

  def load_author
    @author = Author.find_by id: params[:id]
    return if @author

    render json: {data: {}}, status: :not_found
  end
end
