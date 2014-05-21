module Octopress
  module Ink
    module Assets
      class LocalCoffeeScriptAsset < LocalAsset
        def read
          compile
        end

        def path
          File.join(file.site.source, file.path)
        end

        def compile
          ::CoffeeScript.compile(render_page)
        end
      end
    end
  end
end
