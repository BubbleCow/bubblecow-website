class OrderStateManager
    def initialize(order)
      @order = order
    end
  
    def reject
      # Logic for rejection
      send_rejection_email
      @order.reject! # AASM state transition
    end
  
    def accept
      # Logic for acceptance
      send_acceptance_email
      @order.accept! # AASM state transition
    end

    def send_invoice
        # Logic for sending an invoice
        send_invoice_email
        @order.send_invoice! # AASM state transition
    end
    
    def mark_as_paid
        # Logic for marking as paid
        send_payment_confirmation_email
        @order.mark_as_paid! # AASM state transition
    end
    
    def start_editing
        # Logic for starting the editing process
        notify_editing_team
        @order.start_editing! # AASM state transition
    end
      
    # Define other state transition methods...
  
    private
  
    def send_rejection_email
      ProductMailer.rejection_email(@order).deliver_later
    end
  
    def update_rejection_message
      # Update message logic
    end
  
    def send_acceptance_email
      ProductMailer.acceptance_email(@order).deliver_later
    end
  
    def update_acceptance_message
      # Update message logic
    end

    def send_invoice_email
      # Logic to send invoice email
    end
  
    def update_invoice_message
      # Logic to update invoice message
    end
  
    # Additional methods for other actions...
  end
  