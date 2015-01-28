module Octopress
  module AssetPipeline
    class Coffeescript < Javascript
      def content
        ::CoffeeScript.compile(super)
      end

      def path
        File.join(Octopress.site.source, file)
      end

      def destination
        File.join(base, filename.sub(/\.coffee/,'.js'))
      end
    end
  end
end
