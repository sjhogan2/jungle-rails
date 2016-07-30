class ReviewsController < ApplicationController

  def create
      @product = Product.find params[:product_id]
      @review = Review.new(review_params)
      @user = current_user

      @review.user = @user
      @review.product = @product
      @review.save!

    if @review.save
      redirect_to [@product]
    else
      redirect_to [@product]
    end
  end

  def destroy
    @review = Review.find params[:id]
    @product = Product.find params[:product_id]
    @review.destroy
    redirect_to [@product], notice: 'Category deleted!'
  end

  private

  def review_params
    params.require(:review).permit(:rating, :description)
  end
end
