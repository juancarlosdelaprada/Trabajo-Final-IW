class NotesController < ApplicationController
    before_action :set_book, only: [:create, :destroy]
    
    def create
        @note = @book.notes.new(note_params)
        if @note.save
            flash[:success] = "Note was successfully created."
            redirect_to @book
        else
            flash[:danger] = "Unable to add Note! Complete all fields."
            redirect_to @book
        end
    end
    
    def destroy
        @note = @book.notes.find(params[:id])
        @note.destroy
        flash[:success] = "Note was succesfully destroyed."
        redirect_to @book
    end
    
    private
        def set_book
            @book = Book.find(params[:book_id])
        end
        
        def note_params
            params.require(:note).permit(:title, :note)
        end
end