# encoding: UTF-8
class OrderItemsController < ApplicationController

  def create
    @order_item = current_order.order_items.find_by_product_id(params[:order_item][:product_id])
    if @order_item
      @order_item.update_attributes(params[:order_item])
      notice = 'Produto atualizado com sucesso.'
    else
      current_order.order_items.create(params[:order_item])
      notice = 'Produto incluído com sucesso.'
    end

    redirect_to current_order, notice: notice
  end

  def destroy
    @order_item = current_order.order_items.find(params[:id])
    @order_item.destroy

    redirect_to current_order, notice: 'Produto excluído com sucesso.'
  end
end
