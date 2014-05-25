require './test_suite'
ENV['JEKYLL_ENV'] = 'test'

@failures = []

build

test_dirs('Site build', 'site', 'expected')

print_results
