module Octopress
  module AssetPipeline
    class Javascript < Asset
      def tag
        "<script src='#{Filters.expand_url(destination)}'></script>"
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
      end
    end
  end
end

