module Octopress
  module Ink
    module LocalAssets
      class Sass < LocalAssets::Css
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
          Plugins.static_files << StaticFileContent.new(compile, destination)
        end

        def data
          file.data
        end

        def compile
          PluginAssetPipeline.compile_sass(self)
        end
      end
    end
  end
end
