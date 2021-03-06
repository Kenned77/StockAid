class ItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: [:edit, :update]
  def index
    @items = Item.all
    @categories = Category.all

    if params[:category_id].present?
      @items = Item.where(category_id: params[:category_id])
      @category = Category.find(params[:category_id])
    end
  end

  def edit
  end

  def update
    @item.description = items_params[:description]
    @item.current_quantity = items_params[:current_quantity]
    if @item.save
      redirect_to items_path(category_id: @item.category.id)
    else
      redirect_to :back, alert: @item.errors.full_messages.to_sentence
    end
  end

  def create
    item = Item.new items_params
    item.save

    redirect_to action: :index
  end

  private

  def items_params
    params.require(:item).permit(:description, :current_quantity, :category_id)
  end

  def set_item
    @item = Item.find(params[:id])
  end
end
