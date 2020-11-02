class SampleDevelopmentalEditMailer < ApplicationMailer
    layout 'mailer' # use mailer.(html|text).erb as the layout
    default from: 'gary@bubblecow.com'
    
    # Sends to user when new sample developmental edit is created
    def new_sample_developmental_edit(user, sample_developmental_edit)
        @user = user
        @sample_developmental_edit = sample_developmental_edit
        mail( :to => user.email,
        :subject => "You have successfully submitted #{sample_developmental_edit.title.titleize} for sample developmental editing" )
    end

    # Sends to admin when new sample developmental edit is created
    def new_sample_developmental_edit_admin(user, sample_developmental_edit)
        @user = user
        @sample_developmental_edit = sample_developmental_edit
        mail( :to => "gary@bubblecow.com",
        :subject => "#{sample_developmental_edit.title.titleize} has been submitted for sample developmental editing" )
    end    


    # Sends when sample developmental edit is rejected
    def sample_developmental_edit_rejected(user, sample_developmental_edit)
        @user = user
        @sample_developmental_edit = sample_developmental_edit
        mail( 
            :to => user.email,
            :subject => "Sample Developmental edit for #{sample_developmental_edit.title.titleize}",
        )
    end
    
end

