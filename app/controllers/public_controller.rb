class PublicController < ApplicationController
  def home
    @minimum_password_length = User.password_length.min
  end
end
