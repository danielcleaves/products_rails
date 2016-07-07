class ProductsController < ApplicationController
  def index
    @products = Product.joins("LEFT JOIN 'categories' on categories.id = products.category_id").select('products.*,categories.name AS cat')
  end

  def show
    @product = Product.joins("LEFT JOIN 'categories' ON categories.id = products.category_id").select('products.*, categories.name AS cat').find(params[:id])
  end

  def new
    @products = Product.joins("LEFT JOIN 'categories' on categories.id = products.category_id").select('products.*,categories.name AS cat')
    @errors = flash[:errors]
    @category = Category.all
  end

  def edit
    @product = Product.find(params[:id])
    @category = Category.all
  end

  def create
    # this needs strong parameters!
    @product = Product.create( product_params )
    @product.category = Category.find(params[:category])
    if @product.save
      redirect_to "/products"
    else
      render :text => "something went wrong!"
    end
  end

  def update
    @product = Product.find(params[:id]).update( name: params[:name], description: params[:description], pricing: params[:pricing])
    redirect_to '/products'
  end

  def destroy
    @destroy  = Product.find(params[:id]).destroy
    redirect_to '/products'
  end

  private 
  def product_params
   params.require(:product).permit(:name, :description, :pricing)
  end
end
