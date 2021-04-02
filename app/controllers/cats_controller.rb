class CatsController < ApplicationController

  def index
    cats = Cat.all
    render json: cats
  end

  def create
    cat = Cat.create(cat_params)
    (cat.valid?) ? (render json: cat) : (render json: cat.errors, status: :unprocessable_entity)
  end

  def update
    cat = Cat.find(params[:id])
    cat.update(cat_params)
    (cat.valid?) ? (render json: cat) : (render json: cat.errors, status: 422)
  end

  def destroy
    cat = Cat.find(params[:id])
    (cat.destroy) ? (render json: cat) : (render json: cat.errors, status: 422)
  end

  private
  def cat_params
    params.require(:cat).permit(:name, :age, :enjoys)
  end
end
