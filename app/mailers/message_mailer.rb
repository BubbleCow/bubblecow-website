class MessageMailer < ApplicationMailer

    def new_message(message)
        @message = message
        mail( :to => "gary@bubblecow.com",
        :from => message.sender_email,
        :subject => 'You have a new message' )
    end
    
end

