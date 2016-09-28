require "active_support/core_ext/array/wrap"
###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

# With alternative layout
# page "/path/to/file.html", layout: :otherlayout

# Proxy pages (http://middlemanapp.com/basics/dynamic-pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", locals: {
# which_fake_page: "Rendering a fake page with a local variable" }

###
# Helpers
###

###
# Environment List
###

set :base_url, "/"

activate :i18n, langs: [:pl, :en]
activate :sprockets

# Server Environment
configure :server do

  # Debug assets
  set :debug_assets, true

end

# Development Environment
configure :development do

  # Automatic image dimensions on image_tag helpers
  activate :automatic_image_sizes

  # Reload the browser automatically whenever files change
  activate :livereload,  :no_swf => true

  # Assets Pipeline Sets
  set :haml, {ugly: false, format: :html5}
  set :css_dir, 'assets/stylesheets'
  set :js_dir, 'assets/javascripts'
  set :images_dir, 'assets/images'
  set :fonts_dir, 'assets/fonts'

  # Pretty URLs
  # activate :directory_indexes

end

# Build Environment
configure :build do
  set :base_url, "http://mandaryn.github.io/swinginlodz/"

  # Minify CSS on build
  activate :minify_css

  # Minify Javascript on build
  activate :minify_javascript

  # GZIP text files
  # activate :gzip

  activate :asset_host, host: 'http://mandaryn.github.io/swinginlodz/'

  activate :deploy do |deploy|
    deploy.deploy_method = :git
  end
end

# Production Environment
configure :production do

  # Assets Pipeline Sets
  set :css_dir, 'assets/stylesheets'
  set :js_dir, 'assets/javascripts'
  set :images_dir, 'assets/images'
  set :fonts_dir, 'assets/fonts'

  # Middleman Production dev server run code
  # 'middleman server -e production'

end

helpers do
  def url_for(*args)
    super.sub(%r{^/}, "")
  end

  def change_locale_link(locale)
    link_to(locale.to_s.upcase, unlocalize_current_path, locale: locale)
  end

  def unlocalize_current_path
    locale_without_first_slash = extensions[:i18n].path_root(I18n.locale).sub(%r{^/}, "")
    current_page.path.sub(locale_without_first_slash, "")
  end

  def nav_active(path)
    current_page.path.match(path) ? { class: "active" } : { class: current_page.path }
  end
end
