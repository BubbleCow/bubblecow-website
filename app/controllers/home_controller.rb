class HomeController < ApplicationController
  layout :resolve_layout

  def index
  end

  def about
  end

  def terms
  end

  def privacy
  end

  private

  def resolve_layout
    case action_name
    when "index"
      "template_no_container"
    else
      "application"
    end
  end

end
