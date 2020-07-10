class EmbedsController < ApplicationController
    def update
      embed = Embed.new(id: params[:content])
      content = ApplicationController.render(partial: 'embeds/embed',
                                             locals: { embed: embed },
                                             formats: :html)
      render json: { content: content, sgid: embed.attachable_sgid }
    end
  end