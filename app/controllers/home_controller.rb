class HomeController < ApplicationController
  def help
    markdown = File.read(File.join(Rails.root, 'HELP.md'))
    @help_content = Kramdown::Document.new(markdown).to_html
  end
end
