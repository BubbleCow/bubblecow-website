module OrdersHelper
    def render_state_message(order)
      partial_path = "orders/state_messages/#{order.aasm_state}"
      if lookup_context.template_exists?(partial_path, [], true)
        render partial: partial_path, locals: { order: order }
      else
        render partial: "orders/state_messages/default", locals: { order: order }
      end
    end
end
  