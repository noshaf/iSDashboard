class FakeTicketsController < ApplicationController

  def new
  end

  def edit
  end

  def update
  end

  def index
  end

  def show
  end

  def destroy
  end

  protected

  def authenticate
    authenticate_or_request_with_http_basic do |username, password|
      username == "isadmin" && password == "gracefulbreeze"
    end
  end

end
