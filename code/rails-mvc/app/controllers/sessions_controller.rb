# encoding: UTF-8
class SessionsController < ApplicationController
  skip_before_filter :auth
  def new
    @client = Client.new
  end

  def create
    @client = Client.auth(params[:client])

    if @client
      session[:client_id] = @client.id
      return redirect_to root_path
    else
      return redirect_to new_session_path, notice: "Usuário ou senha inválidos"
    end
  end

  def destroy
    session.delete(:client_id)
    return redirect_to new_session_path
  end
end
