class DevelopmentalEditMailer < ApplicationMailer

    # Sends when new devleopmental edit is created
    def new_developmental_edit(user)
        @user = user
        mail( :to => user.email,
        :from => "gary@bubblecow.com",
        :subject => 'You have successfully submitted your book for developmental editing' )
    end

    # Sends when new devleopmental edit is rejected
    def developmental_edit_rejected(user, developmental_edit)
        @user = user
        @developmental_edit = developmental_edit
        mail( :to => user.email,
        :from => "gary@bubblecow.com",
        :subject => "Developmental edit for #{developmental_edit.title.titleize}" )
    end
    
end

