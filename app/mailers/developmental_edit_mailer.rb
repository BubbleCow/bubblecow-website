class DevelopmentalEditMailer < ApplicationMailer
    layout 'mailer' # use mailer.(html|text).erb as the layout
    default from: 'gary@bubblecow.com'
    
    # Sends when new developmental edit is created
    def new_developmental_edit(user, developmental_edit)
        @user = user
        @developmental_edit = developmental_edit
        mail( :to => user.email,
        :subject => "You have successfully submitted #{developmental_edit.title.titleize} for developmental editing" )
    end

    # Sends when new developmental edit is created
    def new_developmental_edit_admin(user, developmental_edit)
        @user = user
        @developmental_edit = developmental_edit
        mail( :to => "gary@bubblecow.com",
        :subject => "#{developmental_edit.title.titleize} has been submitted for developmental editing" )
    end    

    # Sends when developmental edit is rejected
    def developmental_edit_rejected(user, developmental_edit)
        @user = user
        @developmental_edit = developmental_edit
        mail( 
            :to => user.email,
            :subject => "Developmental edit for #{developmental_edit.title.titleize}",
        )
    end

    # Sends when developmental edit is accepted
    def developmental_edit_accepted(user, developmental_edit)
        @user = user
        @developmental_edit = developmental_edit
        mail( :to => user.email,
        :subject => "Developmental edit for #{developmental_edit.title.titleize}" )
    end

    # Sends when developmental edit invoice is sent
    def developmental_edit_invoice_sent(user, developmental_edit)
        @user = user
        @developmental_edit = developmental_edit
        mail( :to => user.email,
        :subject => "Invoice for #{developmental_edit.title.titleize}" )
    end 

    # Sends when developmental edit invoice is paid
    def developmental_edit_invoice_paid(user, developmental_edit)
        @user = user
        @developmental_edit = developmental_edit
        mail( :to => user.email,
        :subject => "Invoice for #{developmental_edit.title.titleize} has been paid" )
    end 

    # Sends when developmental edit is returned
    def developmental_edit_returned(user, developmental_edit)
        @user = user
        @developmental_edit = developmental_edit
        mail( :to => user.email,
        :subject => "The feedback for #{developmental_edit.title.titleize} is ready for you to download" )
    end 
    
end

