class StartersController < ApplicationController
  include Secured

  before_action :get_starters

  # POST /starters/copy
  def copy
    card_data = @starters['cards'][params[:index].to_i]
    Card.copy_starter(card_data, profile)
    redirect_to cards_url
  end

  private

  def get_starters
    @starters = YAML.load_file(File.join(Rails.root, 'db', 'starters.yml'))
  end
end
