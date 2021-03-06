# Octopress Asset Pipeline

Combine and compress and fingerprint Stylesheets (CSS and Sass) and Javascripts (JS and Coffeescript) to a single fingerprinted .css or .js file.

[![Build Status](https://travis-ci.org/octopress/asset-pipeline.svg?branch=master)](https://travis-ci.org/octopress/asset-pipeline)
[![Gem Version](https://badge.fury.io/rb/octopress-asset-pipeline.svg)](http://badge.fury.io/rb/octopress-asset-pipeline)

**How it works:** This plugin will automatically read .js, .coffee, .css, .scss and .sass files from your site, combine, compress and fingerprint them so they're ready for deployment. Then add the liquid tags to your site layout to write
the necessary script or link tags.

## Installation

### Using Bundler

Add this gem to your site's Gemfile in the `:jekyll_plugins` group:

    group :jekyll_plugins do
      gem 'octopress-asset-pipeline'
    end

Then install the gem with Bundler

    $ bundle

### Manual Installation

    $ gem install octopress-asset-pipeline

Then add the gem to your Jekyll configuration.

    gems:
      -octopress-asset-pipeline

## Basic usage

This should be very simple to use.

1. Add Sass or CSS to `stylesheets/` or `css/` directory in your site's source.
1. Add Coffeescript or JS to `stylesheets/` or `css/` directory in your site's source.
2. Put Coffeescript and JS in `[source]/javascripts/`.
3. Add liquid tags (see below) to your sites layout.
4. Build.

If you want, you can configure which directories this plugin reads from. See the configuration section below.

## Liquid tags

Include these tags in your site's layout.

```
{% css_asset_tag %}
{% js_asset_tag %}
```

When Jekyll builds your site, these will be replaced with something like this.

```
<link href='/stylesheets/all-b5c56f2652600cde201589531c453ba1.css' media='all' rel='stylesheet' type='text/css'>
<script src='/javascripts/all-75489c7b2da6efce7ee1bc45795d400b.js'></script>
```

## Configuration

This plugin integrates with the core asset pipeline system in Octopress Ink, therefore
the configurations are set in the `_config.yml` configuration file under the `asset_pipeline` key.

| Option               | Description                               | Default     |
|:---------------------|:------------------------------------------|:------------|
| `stylesheets_dir`    | Directory to read stylesheets from        | ['css', 'stylesheets'] |
| `javascripts_dir`    | Directory to read javascripts from        | ['js', 'javascripts'] |
| `combine_css`        | Combine all .css, .scss and .sass files   | true        |
| `combine_js`         | Combine all .js and .coffee files         | true        |
| `compress_css`       | Compress stylesheets for production       | true        |
| `compress_js`        | Compress Javascripts for production       | true        |
| `order_js`           | Order for .js and .coffee files           | []          |
| `order_css`          | Order for .css, .scss, and .sass          | []          |
| `uglifier`           | Settings for Javascript Uglifier. [Documentaion](https://github.com/lautis/uglifier).  | {}          |

### Ordering assets

By default when scripts and stylesheets are combined, they are added based on
their order in the file system. You can manually specify order like this:

```
asset_pipeline:
  order_js:
   - jquery.js
   - kittens.coffee

  order_css:
   - normalize.css
   - site.sass
```
Assets will ordered as specified. Any additional assets will be appended based on their order in the file system.

Note: It is not necessary to write full paths in these configurations. An asset at `javascripts/lib/jquery.js` will match `jquery.js` and be ordered accordingly.

## Media files

Usually it's better to define print styles inside of the main CSS file beneath a print media query, like this.

```
@media print {
  * { background: none }
  * { color: #000 }
  ...
}
```

If you want to specify a separate print stylesheet, include `@print` in your filename, before the extension. 

When your site is compiled, this file will be written separately and its `<link>` tag will include a `media='print'` attribute.

## Contributing

1. Fork it ( https://github.com/octopress/asset-pipeline/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
