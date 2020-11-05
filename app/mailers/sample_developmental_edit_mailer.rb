class SampleDevelopmentalEditMailer < ApplicationMailer
    layout 'mailer' # use mailer.(html|text).erb as the layout
    default from: 'gary@bubblecow.com'
    helper :services
    
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
            :subject => "Sample developmental edit for #{sample_developmental_edit.title.titleize}",
        )
    end

    # send emails to writer when sample edit is accepted
    def sample_developmental_edit_accepted(user, sample_developmental_edit)
        @user = user
        @sample_developmental_edit = sample_developmental_edit
        mail( 
            :to => user.email,
            :subject => "Sample developmental edit for #{sample_developmental_edit.title.titleize} has been accepted",
        )
    end

    # Sends email to editor to tell them they have a sample edit 
    def sample_developmental_edit_editing_underway_editor(user, sample_developmental_edit)
        @user = user
        @sample_developmental_edit = sample_developmental_edit
            mail( 
                :to => sample_developmental_edit.editor.email,
                :subject => "#{sample_developmental_edit.title.titleize} has been assigned to your for sample editing" 
            )
    end    

    # Sends email to writer to say sample is ready
    def sample_developmental_edit_returned(user, sample_developmental_edit)
        @user = user
        @sample_developmental_edit = sample_developmental_edit
        mail( 
            :to => user.email,
            :subject => "Your sample developmental edit for #{sample_developmental_edit.title.titleize} is ready to download",
        )
    end    
    
end

