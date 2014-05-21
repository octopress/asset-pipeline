module Octopress
  module Ink
    module Assets
      class LocalCssAsset < LocalAsset
        def media
          path.scan(/@(.+?)\./).flatten[0] || 'all'
        end
      end
    end
  end
end
