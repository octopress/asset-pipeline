module Octopress
  module Ink
    module Assets
      class LocalCoffeeScriptAsset < LocalJavaScriptAsset
        def read
          @compiled ||= compile
        end

        def compile
          ::CoffeeScript.compile(file.content)
        end

        def path
          Pathname.new File.join(Octopress.site.source, file.path)
        end

        def destination
          File.join(base, filename.sub(/\.coffee/,'.js'))
        end
      end
    end
  end
end
