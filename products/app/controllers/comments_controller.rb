class CommentsController < ApplicationController
def index
  	@products = Product.joins(:category).select('products.*, categories.name AS cat')
  end

  def show
  	@product = Product.joins(:category).select('products.*, categories.name AS cat').find(params[:id])
    @comment = Comment.new
    @comments = Product.find(params[:id]).comments
  end

  def new
  	@product = Product.new
  	@errors = flash[:errors]
  end

  def edit
  	@product = Product.joins(:category).select('products.*, categories.name AS cat, categories.id AS cat_id').find(params[:id])
  	@errors = flash[:errors]
  end

  def create
  	@product = Product.new( product_params )
  	if @product.valid?
  		@product.save
  		redirect_to '/products'
  	else
  		flash[:errors] = @product.errors.full_messages
  		redirect_to '/products/new'
  	end
  end

  def update
  	@product = Product.find(params[:id]).update( product_params )
  	puts product_params
  	if @product
  		redirect_to '/products/'+params[:id]
  	else
  		flash[:errors] = ['All fields must be filled out']
  		redirect_to '/products/'+params[:id]+'/edit'
  	end
  end

  def destroy
  	@product = Product.find(params[:id]).destroy
  	redirect_to '/products'
  end

  private
	def product_params
	  	params.require(:product).permit(:category_id, :name, :description, :pricing)
	end
end
