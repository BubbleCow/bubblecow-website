# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "http://bubblecow.com"

SitemapGenerator::Sitemap.create do
  # Put links creation logic here.
  #
  # The root path '/' and sitemap index file are added automatically for you.
  # Links are added to the Sitemap in the order they are specified.
  #
  # Usage: add(path, options={})
  #        (default options are used if you don't specify)
  #
  # Defaults: :priority => 0.5, :changefreq => 'weekly',
  #           :lastmod => Time.now, :host => default_host
  #
  # Examples:
  #
  # Add '/articles'
  #
  #   add articles_path, :priority => 0.7, :changefreq => 'daily'
  #
  # Add all articles:
  #
  #   Article.find_each do |article|
  #     add article_path(article), :lastmod => article.updated_at
  #   end

  # Pages
  add about_path, :priority => 0.7, :changefreq => 'weekly'
  add file_safety_path, :priority => 0.7, :changefreq => 'weekly'
  add testimonials_path, :priority => 0.7, :changefreq => 'weekly'

  # Editorial Services
  add book_editing_path, :priority => 0.7, :changefreq => 'weekly'

  #  Blog
  add blog_root_path, :priority => 0.7, :changefreq => 'weekly'

  Post.find_each do |post|
    add blog_post_path(post), :lastmod => post.updated_at
  end

end
