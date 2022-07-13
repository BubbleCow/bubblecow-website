module PostsHelper

    def post_content
        # if content is present, it shows that, otherwise it defaults to active_text/trix content -->
        if @post.content.present? 
            content_tag(:div, @post.content.html_safe, class: 'blog-post' )
        else
            @post.body
        end
    end

    def blog_post_advert(advert_category)
        if advert_category.blank?
            render 'blog/posts/adverts/writing_manual'
        elsif advert_category == 'dialogue'
            render 'blog/posts/adverts/dialogue'
        elsif advert_category == 'book proposal'
            render 'blog/posts/adverts/book_proposal'
        else
            render 'blog/posts/adverts/writing_manual'
        end
    end

    def current_advert_category
        if @post.advert_category.blank?
            'None selected will show Writing Manual'
        else
            @post.advert_category 
        end

    end

end
