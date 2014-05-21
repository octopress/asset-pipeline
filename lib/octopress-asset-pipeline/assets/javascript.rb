module Octopress
  module Ink
    module Assets
      class LocalJavaScriptAsset < LocalAsset
        def tag
          "<script src='#{Filters.expand_url(destination)}'></script>"
        end
      end
    end
  end
end

