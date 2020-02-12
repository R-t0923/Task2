class BookCommentsController < ApplicationController
  def create
    @book = Book.find(params[:book_id])
    comment = current_user.book_comments.new(book_comment_params)
    comment.book_id = @book.id
    @book_commnet = @book.book_comments
    comment.save
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @book_comment = BookComment.find(params[:id])
    @book_comment.destroy
  end

  private
  def book_comment_params
      params.require(:book_comment).permit(:user_id,:book_id,:comment)
  end
end
