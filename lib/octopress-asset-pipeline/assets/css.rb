module Octopress
  module AssetPipeline
    class Css < Asset
      def media
        path.to_s.scan(/@(.+?)\./).flatten[0] || 'all'
      end

      def destination
        File.join(base, filename.sub(/@(.+?)\./,'.'))
      end

      def tag
        "<link href='#{Filters.expand_url(destination)}' media='#{media}' rel='stylesheet' type='text/css'>"
      end
    end
  end
end
