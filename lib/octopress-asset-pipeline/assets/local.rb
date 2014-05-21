module Octopress
  module Ink
    module Assets
      class LocalAsset < Asset
        def initialize(plugin, file)
          @plugin = plugin
          @file = file
        end

        def info
          message = filename.ljust(35)
          message += "from: #{base}"
          "  - #{message}"
        end

        def filename
          File.basename(path)
        end

        def base
          file.relative_path.sub(filename,'').sub(/^\/(.+)\/$/,'\1')
        end

        def destination
          File.join(base, filename)
        end

        def path
          file.path
        end

        def read
          File.open(path).read
        end

        # Copy is unncessary with local assets
        #
        def copy(target_dir); end

        private

        def render_page
          payload = Ink.site.site_payload
          payload['page'] = file.data

          render_liquid(file.content, payload)
        end

      end
    end
  end
end
