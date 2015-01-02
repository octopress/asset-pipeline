module Octopress
  module AssetPipeline
    class Asset < Ink::Assets::Asset
      def initialize(plugin, file)
        @plugin = plugin
        @file = file
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
        file.relative_path.sub(filename,'').sub(/^\/(.+)\/$/,'\1')
      end

      def destination
        File.join(base, filename)
      end

      def path
        Pathname.new file.path
      end

      # Copy is unncessary with local assets
      #
      def copy(target_dir); end
    end
  end
end
