module Octopress
  module AssetPipeline
    class Asset < Ink::Assets::Asset
      attr_reader :file_object

      def initialize(plugin, object)
        @plugin = plugin
        @file_object = object
        @file = object.path
      end

      def info
        message = filename.ljust(35)
        message += "from: #{base}"
        "  - #{message}"
      end

      def filename
        File.basename(path)
      end

      def base
        file_object.relative_path.sub(filename,'').sub(/^\/(.+)\/$/,'\1')
      end

      def destination
        File.join(base, filename)
      end

      def path
        file
      end

      # Copy is unncessary with local assets
      #
      def copy(target_dir); end
    end
  end
end
