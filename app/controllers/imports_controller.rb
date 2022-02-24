class ImportsController < ActionController::Base
  def new
    render template: 'imports/new'
  end
end