# Changelog

### 2.0.3 - 2015-03-04

- Added plugin reset and compatibility with the latest Octopress Ink.

### 2.0.2 - 2015-02-15

- Now using the default sorting built in to Octopress Ink.

### 2.0.1 - 2015-01-28

- Fix: javascripts ending in .min.js can be sorted manually.

### 2.0.0 - 2015-01-15

- Change: Reads stylesheets from: `css/` and `stylesheets/`.
- Change: Reads javascripts from: `js/` and `javascripts/`.
- New: set asset directories with configurations: `stylesheets_dir` and `javascripts_dir`.

### 1.1.7 - 2015-01-14

- Minified js support - file.min.js isn't compressed again, and is added first to build.

### 1.1.6 - 2015-01-09

- Fixed: Enforced default sorting by path.

### 1.1.5 - 2015-01-09

- Fixed: Some files weren't getting added to the compiled output. [#7](https://github.com/octopress/asset-pipeline/issues/7)

### 1.1.4 - 2015-01-05

- Removed unnecessary files from gem build.

### 1.1.3 - 2015-01-05

- Improvements to README.

### 1.1.2 - 2015-01-02

- Updated integration with Octopress Docs.

### 1.1.1 - 2015-01-02

- Added support for reading documentation through Octopress docs

### 1.1.0 - 2015-01-01

- Now reads configuration from _config.yml under `asset_pipeline`.

### 1.0.3 - 2014-08-17

- Updated to latest Octopress Ink.

### 1.0.3 - 2014-08-11

- Cleaned up asset methods, added back Sass rendering through liquid.

### 1.0.2 - 2014-08-11

- Fix: Updated integration with latest Octopress Ink.

### 1.0.1 - 2014-07-19

- Updated tests to reflect no longer rendering Sass through liquid.

### 1.0.0 - 2014-05-25

- Initial release 
