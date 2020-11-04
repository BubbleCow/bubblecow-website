module WriterArea
    class WriterPagesController < WriterArea::ApplicationController

        def dashboard
            @page_title = "Writer Area: Dashboard"
            @developmental_edits = current_user.developmental_edits.order(created_at: :desc)
            @sample_developmental_edits = current_user.sample_developmental_edits.order(created_at: :desc)
        end

    end
end