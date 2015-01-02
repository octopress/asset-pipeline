require 'octopress'
require 'octopress-ink'
require 'octopress-asset-pipeline/version'

require 'octopress-asset-pipeline/assets/local'
require 'octopress-asset-pipeline/assets/css'
require 'octopress-asset-pipeline/assets/sass'
require 'octopress-asset-pipeline/assets/javascript'
require 'octopress-asset-pipeline/assets/coffeescript'

module Octopress
  module AssetPipeline
    class Plugin < Ink::Plugin
      def configuration
        {
          name:          "Octopress Asset Pipeline",
          path:          File.expand_path(File.join(File.dirname(__FILE__), "../")),
          type:          "plugin",
          version:       Octopress::AssetPipeline::VERSION,
          description:   "Combine and compress CSS and Sass, Javascript and Coffeescript to a single fingerprinted file.",
          source_url:    "https://github.com/octopress/asset-pipeline",
          local: true
        }
      end

      def register
        # Tell Jekyll to read static files and pages
        # This is necessary when Jekyll isn't being asked to build a site,
        # like when a user runs the list command to list assets
        #
        if ENV['OCTOPRESS_DOCS']
          add_docs
        else
          add_files
        end
      end

      def add_files
        if Octopress.site.pages.empty? && Octopress.site.posts.empty?
          Octopress.site.read_directories 
        end

        add_stylesheets
        add_javascripts
      end

      def config
        @config ||= begin
          Ink.configuration['asset_pipeline'].merge({'disable' => {}})
        end
      end

      # Return stylesheets to be combined in the asset pipeline
      def stylesheets
        sort(@css.clone.concat(@sass), config['order_css'] || [])
      end

      def javascripts
        sort(@js.clone.concat(@coffee), config['order_js'] || [])
      end

      private

      def combine_js
        config['combine_js']
      end

      def combine_css
        config['combine_css']
      end

      def add_stylesheets
        add_css
        add_sass

        if !combine_css
          # Add tags for {% css_asset_tag %}
          stylesheets.each { |f| Ink::Plugins.add_css_tag(f.tag) }
          @css.clear
        end

      end

      def add_javascripts
        add_js
        add_coffee

        if !combine_js
          # Add tags for {% js_asset_tag %}
          javascripts.each { |f| Ink::Plugins.add_js_tag(f.tag) }
          @js.clear
          @coffee.clear
        end
      end

      def sort(files, config)
        sorted = []
        config.each do |item|
          files.each do |file|
            sorted << files.delete(file) if file.path.to_s.include? item
          end
        end

        sorted.concat files
      end

      # Finds all Sass files registered by Jekyll
      #
      def add_sass
        Octopress.site.pages.each do |f| 
          if f.ext =~ /\.s[ca]ss/ 
            @sass << Sass.new(self, f)
            Octopress.site.pages.delete(f)
          end
        end
      end

      # Finds all CSS files registered by Jekyll
      #
      def add_css
        Octopress.site.static_files.each do |f| 
          if f.path =~ /\.css$/ 
            @css << Css.new(self, f)
            Octopress.site.static_files.delete(f) if combine_css
          end
        end
      end

      # Finds all Coffeescript files registered by Jekyll
      #
      def add_coffee
        Octopress.site.pages.each do |f| 
          if f.ext =~ /\.coffee$/ 
            @coffee << Coffeescript.new(self, f)
            Octopress.site.pages.delete(f) if combine_js
          end
        end
      end

      # Finds all Javascript files registered by Jekyll
      #
      def add_js
        Octopress.site.static_files.each do |f| 
          if f.path =~ /\.js$/ 
            @js << Javascript.new(self, f)
            Octopress.site.static_files.delete(f) if combine_js
          end
        end
      end
    end
  end
end

Octopress::Ink.register_plugin(Octopress::AssetPipeline::Plugin)
