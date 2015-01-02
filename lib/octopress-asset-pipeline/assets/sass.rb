module Octopress
  module AssetPipeline
    class Sass < Css
      def ext
        file.ext
      end

      def path
        Pathname.new File.join(Octopress.site.source, file.path)
      end

      def destination
        super.sub(/\.s[ca]ss$/, '.css')
      end

      def add
        Ink::Plugins.static_files << Ink::StaticFileContent.new(compile, destination)
      end

      def data
        file.data
      end

      def compile
        Ink::PluginAssetPipeline.compile_sass(self)
      end
    end
  end
end
