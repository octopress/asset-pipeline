# Octopress Asset Pipeline

Combine and compress and fingerprint Stylesheets (CSS and Sass) and Javascripts (JS and Coffeescript) to a single fingerprinted .css or .js file.

**How it works:** This plugin will automatically search Jekyll's site index for .js, .coffee, .css, .scss and .sass
files and combine, compress and fingerprint them so they're ready for deployment. Then add the liquid tags to your site layout to write
the necessary script or link tags.

## Installation

Add this line to your site's Gemfile:

    gem 'octopress-asset-pipeline'

And then execute:

    $ bundle

Or install it manually:

    $ gem install octopress-asset-pipeline


### Add gem to Jekyll

Add the gem to Jekyll's configuration file:

```yaml
gems:
  - octopress-asset-pipeline
```

## Liquid tags

Include these tags in your site's layout.

```
{% css_asset_tag %}
{% js_asset_tag %}
```

When Jekyll is compiled these will be replaced with something like this.

```
<link href='/stylesheets/all-b5c56f2652600cde201589531c453ba1.css' media='all' rel='stylesheet' type='text/css'>
<script src='/javascripts/all-75489c7b2da6efce7ee1bc45795d400b.js'></script>
```

## Configuration

This plugin integrates with the core asset pipeline system in Octopress Ink, therefore
the configurations are set in the `_config.yml` configuration file under the `asset_pipeline` key.

| Option               | Description                               | Default     |
|:---------------------|:------------------------------------------|:------------|
| `combine_css`        | Combine all .css, .scss and .sass files   | true        |
| `combine_js`         | Combine all .js and .coffee files         | true        |
| `compress_css`       | Compress stylesheets for production       | true        |
| `compress_js`        | Compress Javascripts for production       | true        |
| `order_js`           | Order for .js and .coffee files           | []          |
| `order_css`          | Order for .css, .scss, and .sass          | []          |
| `uglifier`           | Settings for Javascript Uglifier. [Documentaion](https://github.com/lautis/uglifier).  | {}          |

### Ordering assets

By default when scripts and stylesheets are combined, they added based on
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
