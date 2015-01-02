module Octopress
  module AssetPipeline
    class Javascript < Asset
      def tag
        "<script src='#{Filters.expand_url(destination)}'></script>"
      end
    end
  end
end

