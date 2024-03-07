SitemapGenerator::Sitemap.default_host = 'http://bubblecow.com'
include Rails.application.routes.url_helpers
default_url_options[:host] = 'http://bubblecow.com'

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
  add '/about'
  add '/thanks'
  add '/file-safety'
  add '/book-editing-portal'
  add '/terms-and-conditions'
  add '/privacy-policy'
  add '/services/developmental-editing'
  add '/services/content-editing'
  add '/services/substantive-editing'
  add '/services/novel-editing'
  add '/services/manuscript-editing'
  add '/services/book-editing'
  add '/services/mentoring'
  add '/services/manuscript-assessment'
  add '/services/copy-editing'

  # Dynamic content: Blog posts
  Post.published.find_each do |post|
    add post_path(post), lastmod: post.updated_at, priority: 0.7, changefreq: 'weekly'
  end

end
