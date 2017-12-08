class CommentsController < ApplicationController
  
  def create
    @comment = Comment.new(comments_params)
    @comment.faq = Faq.friendly.find params[:faq_id]
    if @comment.save
      
    else
      
    end
    redirect_to faq_path(@comment.faq, :anchor => "comments")
  end

  protected

  def comments_params
    params.require(:comment).permit(:body, :hometown, :name)
  end
  
end
