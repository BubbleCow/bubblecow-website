class DevelopmentalEditMailer < ApplicationMailer

    # Sends when new devleopmental edit is created
    def new_developmental_edit(user)
        @user = user
        mail( :to => user.email,
        :from => "gary@bubblecow.com",
        :subject => 'You have successfully submitted your book for developmental editing' )
    end
    
end

