module Octopress
  module Ink
    module Assets
      class LocalCoffeeScriptAsset < LocalJavaScriptAsset
        def read
          compile
        end

        def path
          File.join(file.site.source, file.path)
        end

        def compile
          ::CoffeeScript.compile(render_page)
        end

        def destination
          File.join(base, filename.sub(/\.coffee/,'.js'))
        end
      end
    end
  end
end
