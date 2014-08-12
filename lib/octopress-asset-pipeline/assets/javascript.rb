module Octopress
  module Ink
    module LocalAssets
      class Javascript < LocalAssets::Asset
        def tag
          "<script src='#{Filters.expand_url(destination)}'></script>"
        end
      end
    end
  end
end

