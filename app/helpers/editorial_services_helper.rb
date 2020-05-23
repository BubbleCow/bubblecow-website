module EditorialServicesHelper

    def proposed_date
        time = Date.today + 37.days
        time.strftime('%B %d')
    end



end