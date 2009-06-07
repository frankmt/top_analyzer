# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{top_analyzer}
  s.version = "0.2.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Francisco Trindade"]
  s.date = %q{2009-06-07}
  s.default_executable = %q{top_analyzer}
  s.description = %q{Top Analyzer is a gem to analyzer top batch files, producing a csv output.}
  s.email = %q{frank@franktrindade.com}
  s.executables = ["top_analyzer"]
  s.extra_rdoc_files = [
    "README.markdown"
  ]
  s.files = [
    "README.markdown",
     "Rakefile",
     "VERSION.yml",
     "bin/top_analyzer",
     "lib/top_analyzer.rb",
     "lib/top_matcher.rb",
     "lib/top_process.rb",
     "rsc/long_example.csv",
     "rsc/long_example.log",
     "rsc/mini_example.log",
     "rsc/top_example.log",
     "rsc/top_example_results.csv",
     "spec/spec_helper.rb",
     "spec/top_analyzer_spec.rb",
     "spec/top_matcher_spec.rb",
     "spec/top_process_spec.rb",
     "top_analyzer.gemspec"
  ]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/frankmt/top_analyzer}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{Top Analyzer is a gem to analyzer top batch files, producing a csv output.}
  s.test_files = [
    "spec/spec_helper.rb",
     "spec/top_analyzer_spec.rb",
     "spec/top_matcher_spec.rb",
     "spec/top_process_spec.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
