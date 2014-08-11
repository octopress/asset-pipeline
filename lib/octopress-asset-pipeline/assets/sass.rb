module Octopress
  module Ink
    module Assets
      class LocalSassAsset < LocalCssAsset
        def read
          @compiled ||= compile
        end

        def content
          render
        end

        def ext
          file.ext
        end

        def path
          Pathname.new File.join(Octopress.site.source, file.path)
        end

        def destination
          File.join(base, filename.sub(/@(.+?)\./,'.').sub(/s.ss/, 'css'))
        end

        def compile
          PluginAssetPipeline.compile_sass(self)
        end
      end
    end
  end
end
