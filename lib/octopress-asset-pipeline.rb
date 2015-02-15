require 'octopress'
require 'octopress-ink'
require 'octopress-asset-pipeline/version'

require 'octopress-asset-pipeline/assets/asset'
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
          gem:           "octopress-asset-pipeline",
          path:          File.expand_path(File.join(File.dirname(__FILE__), "../")),
          type:          "plugin",
          version:       Octopress::AssetPipeline::VERSION,
          description:   "Combine and compress Stylesheets and Javascripts into a single fingerprinted file.",
          source_url:    "https://github.com/octopress/asset-pipeline",
          local: true
        }
      end

      def register
        # Tell Jekyll to read static files and pages
        # This is necessary when Jekyll isn't being asked to build a site,
        # like when a user runs the list command to list assets
        #
        if Octopress::Docs.enabled?
          add_docs
        end
        if Octopress::Ink.enabled?
          add_files
        end
      end

      def add_files
        if Octopress.site.pages.empty? && Octopress.site.posts.empty?
          Octopress.site.read_directories 
        end

        add_static_files
        add_page_files
        add_stylesheets
        add_javascripts
      end

      def config(*args)
        @config ||= begin
          c = Ink.configuration['asset_pipeline']
          {
            'stylesheets_dir' => ['stylesheets', 'css'],
            'javascripts_dir' => ['javascripts', 'js']
          }.merge(c).merge({ 'disable' => {} })
        end
      end

      private

      def asset_dirs
        [config['stylesheets_dir'], config['javascripts_dir']].flatten
      end

      def css_dirs
        config['stylesheets_dir']
      end

      def combine_css
        config['combine_css']
      end

      def combine_js
        config['combine_js']
      end

      def add_stylesheets
        if !combine_css
          # Add tags for {% css_asset_tag %}
          stylesheets.each { |f| Ink::Plugins.add_css_tag(f.tag) }
          @css.clear
        end
      end

      def add_javascripts
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

      # Finds css and js files files registered by Jekyll
      #
      def add_static_files
        find_static_assets(asset_dirs, '.js', '.css').each do |f|
          if File.extname(f.path) == '.js'
            @js << Javascript.new(self, f)
            Octopress.site.static_files.delete(f) if combine_js
          elsif File.extname(f.path) == '.css'
            @css << Css.new(self, f)
            Octopress.site.static_files.delete(f) if combine_css
          end
        end
      end

      # Finds Sass and Coffeescript files files registered by Jekyll
      #
      def add_page_files
        find_page_assets(asset_dirs, '.scss', '.sass', '.coffee').each do |f|
          if f.ext =~ /\.coffee$/ 
            @coffee << Coffeescript.new(self, f)
            Octopress.site.pages.delete(f) if combine_js
          elsif f.ext =~ /\.s[ca]ss/ 
            @sass << Sass.new(self, f)
            Octopress.site.pages.delete(f) if combine_css
          end
        end
      end

      def find_static_assets(dirs, *extensions)
        assets = Octopress.site.static_files.dup.sort_by(&:path)
        find_assets(assets, dirs, extensions)
      end

      def find_page_assets(dirs, *extensions)
        assets = Octopress.site.pages.dup.sort_by(&:path)
        find_assets(assets, dirs, extensions)
      end

      def find_assets(assets, dirs, extensions)
        assets.select do |f| 
          if extensions.include?(File.extname(f.path))
            path = f.path.sub(File.join(Octopress.site.source, ''), '')
            in_dir?(path, dirs)
          end
        end
      end

      def in_dir?(file, *dirs)
        dirs.flatten.select do |d| 
          file.match(/^#{d}\//) 
        end.size > 0
      end
    end
  end
end

Octopress::Ink.register_plugin(Octopress::AssetPipeline::Plugin)
