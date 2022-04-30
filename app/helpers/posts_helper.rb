module PostsHelper

    def post_content
        # if content is present, it shows that, otherwise it defaults to active_text/trix content -->
        if @post.content.present? 
            sanitize @post.content 
        else
            @post.body
        end
    end

end
