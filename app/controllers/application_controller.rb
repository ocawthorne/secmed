class ApplicationController < ActionController::Base
   before_action :require_login, only: :home
end
