module MessagesHelper


    def message_status_actions(message)

        # create unread link and icon
        def link_to_mark_as_unread(message)
            link_to unread_message_path(message), data: { "turbo-method": :put} do 
                content_tag(:i, " ", class: "bi bi-book", "bs-data-toggle": "tooltip", "data-bs-placement": "top", "title": "Mark as unread")
             end
        end

        # create read link and icon
        def link_to_mark_as_read(message)
            link_to read_message_path(message), data: { "turbo-method": :put} do 
                content_tag(:i, " ", class: "bi bi-book-fill", "bs-data-toggle": "tooltip", "data-bs-placement": "top", "title": "Mark as read")
            end
        end
    
        # create unarchived link and icon
        def link_to_unarchive(message)
            link_to unarchive_message_path(message), data: { "turbo-method": :put} do 
                content_tag(:i, " ", class: "bi bi-archive-fill", "bs-data-toggle": "tooltip", "data-bs-placement": "top", "title": "Unarchive message")
            end
        end

        # create archived link and icon
        def link_to_archive(message)
            link_to archive_message_path(message), data: { "turbo-method": :put} do 
                content_tag(:i, " ", class: "bi bi-archive", "bs-data-toggle": "tooltip", "data-bs-placement": "top", "title": "Archive message")
            end
        end

        # Create inbox link and icon
        def link_to_inbox
            link_to messages_path do 
                content_tag(:i, " ", class: "bi bi-inbox", "bs-data-toggle": "tooltip", "data-bs-placement": "top", "title": "Inbox")
            end
        end

        # Create in link and icon
        def link_to_delete_message(message)
            link_to message, data: {"turbo-method": :delete, turbo_confirm: "Are you sure?"} do
                content_tag(:i, " ", class: "bi bi-trash", "bs-data-toggle": "tooltip", "data-bs-placement": "top", "title": "Inbox")
            end
        end
        
        # Logic for read message (not displayed on show action)
        if action_name == "show"
            concat(link_to_inbox)
        else
            if message.read?
                concat(link_to_mark_as_unread(message))
            else
                concat(link_to_mark_as_read(message))
            end
        end
        
        # Logic for archived message
        if message.archived?
            concat(link_to_unarchive(message)) 
        else
            concat(link_to_archive(message)) 
        end

        # Delete message 
        capture do 
            concat(link_to_delete_message(message))
        end

    end

end
