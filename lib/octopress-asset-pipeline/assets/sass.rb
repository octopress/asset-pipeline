module Octopress
  module AssetPipeline
    class Sass < Css
      attr_reader :render

      def ext
        file_object.ext
      end

      def path
        File.join(Octopress.site.source, file)
      end

      def destination
        super.sub(/\.s[ca]ss$/, '.css')
      end

      def add
        Ink::Plugins.static_files << Ink::StaticFileContent.new(content, destination)
      end

      def data
        file_object.data
      end

      def content
        @render ||= begin
          contents = super
          if asset_payload = payload
            Liquid::Template.parse(contents).render!(payload)
          else
            contents
          end
        end

        Ink::PluginAssetPipeline.compile_sass(self)
      end
    end
  end
end
