class WelcomeController < ApplicationController
  def index
    redirect_to hosts_path
  end
end
