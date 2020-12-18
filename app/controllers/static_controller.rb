class StaticController < ApplicationController
  def home
    redirect_to controller: 'appointments', action: 'index' if logged_in?
  end
end
