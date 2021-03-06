class BooksController < ApplicationController
  skip_before_action :ensure_login, only: [:index, :show]
  before_action :set_book, only: [:show, :edit, :update, :destroy]

  # GET /books
  # GET /books.json
  def index
    if !logged_in?
      @books = Book.all
    else 
      @books = current_user.books.all
    end
  end

  # GET /books/1
  # GET /books/1.json
  def show
  end

  # GET /books/new
  def new
    # @book = Book.new
    @book = current_user.books.new
  end

  # GET /books/1/edit
  def edit
  end

  # POST /books
  # POST /books.json
  def create
    # @book = Book.new(book_params)
    @book = current_user.books.new(book_params)

    respond_to do |format|
      if @book.save
        format.html { 
          flash[:success] = "Book was successfully created."
          redirect_to @book
        }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /books/1
  # PATCH/PUT /books/1.json
  def update
    respond_to do |format|
      if @book.update(book_params)
        format.html { 
          flash[:success] = "Book was successfully updated."
          redirect_to @book
        }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    @book.destroy
    respond_to do |format|
      format.html { 
        flash[:success] = "Book was successfully destroyed."
        redirect_to books_url
      }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      if !logged_in?
        @book = Book.find(params[:id])
      else
        @book = current_user.books.find(params[:id])
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def book_params
      params.require(:book).permit(:image, :name, :author)
    end
end