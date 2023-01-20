source "https://rubygems.org"

gem "jekyll", "~> 4.3" # installed by `gem jekyll`
# gem "webrick"        # required when using Ruby >= 3 and Jekyll <= 4.2.2

gem "just-the-docs", "0.4.0.rc4" # currently the latest pre-release
# gem "just-the-docs"            # the latest release - currently 0.3.3

# gem "webrick", "~> 1.7"

# If you want to use GitHub Pages, remove the "gem "jekyll"" above and
# uncomment the line below. To upgrade, run `bundle update github-pages`.
# gem "github-pages", group: :jekyll_plugins
# If you have any plugins, put them here!
group :jekyll_plugins do
  gem "jekyll-feed", "~> 0.12"
end

# Windows and JRuby does not include zoneinfo files, so bundle the tzinfo-data gem
# and associated library.
platforms :mingw, :x64_mingw, :mswin, :jruby do
  gem "tzinfo", ">= 1", "< 3"
  gem "tzinfo-data"
end

# Performance-booster for watching directories on Windows
gem "wdm", "~> 0.1.1", :platforms => [:mingw, :x64_mingw, :mswin]

# Lock `http_parser.rb` gem to `v0.6.x` on JRuby builds since newer versions of the gem
# do not have a Java counterpart.
# gem "http_parser.rb", "~> 0.6.0", :platforms => [:jruby]
