require './test_suite'
ENV['JEKYLL_ENV'] = 'test'

@failures = []

build

test_dirs('Site build', 'site', 'expected')

#build({:octopress_config => '_concat_false.yml'})

#test_dirs('Site build', 'site', 'concat_false')

print_results
