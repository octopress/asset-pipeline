module Octopress
  module AssetPipeline
    class Css < Asset
      def media
        path.to_s.scan(/@(.+?)\./).flatten[0] || 'all'
      end

      def destination
        File.join(base, output_file_name)
      end
      
      def tag
        "<link href='#{Filters.expand_url(destination)}' media='#{media}' rel='stylesheet' type='text/css'>"
      end

      def output_file_name
        filename.sub(/@/,'-')
      end
    end
  end
end
