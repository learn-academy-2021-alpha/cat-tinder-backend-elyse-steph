class CatsController < ApplicationController

  def index
    cats = Cat.all
    render json: cats
  end

  def create
    cat = Cat.create(cat_params)
    (cat.valid?) ? (render json: cat) : (render json: cat.errors, status: :unprocessable_entity)
  end

  private
  def cat_params
    params.require(:cat).permit(:name, :age, :enjoys)
  end
end
