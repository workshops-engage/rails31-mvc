class ApplicationController < ActionController::Base
  protect_from_forgery
  protected
  helper_method :current_client
  def current_client
    @current_client ||= Client.find(session[:client_id]) rescue nil
  end
  before_filter :auth
  def auth
    redirect_to new_session_path unless current_client
  end
  helper_method :current_order
  def current_order
    @current_order ||= current_client.orders.find(session[:order_id])
  rescue => e
    @current_order = current_client.orders.create
    session[:order_id] = @current_order.id
    @current_order
  end
end
