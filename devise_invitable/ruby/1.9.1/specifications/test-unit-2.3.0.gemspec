# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{test-unit}
  s.version = "2.3.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Kouhei Sutou", "Ryan Davis"]
  s.date = %q{2011-04-17}
  s.default_executable = %q{testrb}
  s.description = %q{Test::Unit 2.x - Improved version of Test::Unit bundled in
Ruby 1.8.x.

Ruby 1.9.x bundles minitest not Test::Unit. Test::Unit
bundled in Ruby 1.8.x had not been improved but unbundled
Test::Unit (Test::Unit 2.x) will be improved actively.}
  s.email = ["kou@cozmixng.org", "ryand-ruby@zenspider.com"]
  s.executables = ["testrb"]
  s.files = ["test/ui/test_testrunmediator.rb", "test/ui/test_tap.rb", "test/test_testresult.rb", "test/test_failure.rb", "test/test_testsuite.rb", "test/collector/test_objectspace.rb", "test/collector/test_dir.rb", "test/util/test_backtracefilter.rb", "test/util/test_observable.rb", "test/util/test_procwrapper.rb", "test/test_error.rb", "bin/testrb"]
  s.homepage = %q{http://rubyforge.org/projects/test-unit/}
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{test-unit}
  s.rubygems_version = %q{1.6.0}
  s.summary = %q{Test::Unit 2.x - Improved version of Test::Unit bundled in Ruby 1.8.x}
  s.test_files = ["test/ui/test_testrunmediator.rb", "test/ui/test_tap.rb", "test/test_testresult.rb", "test/test_failure.rb", "test/test_testsuite.rb", "test/collector/test_objectspace.rb", "test/collector/test_dir.rb", "test/util/test_backtracefilter.rb", "test/util/test_observable.rb", "test/util/test_procwrapper.rb", "test/test_error.rb"]

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rubyforge>, [">= 2.0.4"])
      s.add_development_dependency(%q<hoe>, [">= 2.6.1"])
    else
      s.add_dependency(%q<rubyforge>, [">= 2.0.4"])
      s.add_dependency(%q<hoe>, [">= 2.6.1"])
    end
  else
    s.add_dependency(%q<rubyforge>, [">= 2.0.4"])
    s.add_dependency(%q<hoe>, [">= 2.6.1"])
  end
end
