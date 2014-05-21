module Octopress
  module Ink
    module Assets
      class LocalCssAsset < LocalAsset
        def media
          path.scan(/@(.+?)\./).flatten[0] || 'all'
        end

        def destination
          File.join(base, filename.sub(/@(.+?)\./,'.'))
        end

        def tag
          "<link href='#{Filters.expand_url(File.join(destination))}' media='#{media}' rel='stylesheet' type='text/css'>"
        end
      end
    end
  end
end
