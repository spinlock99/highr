# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{autotest-notification}
  s.version = "2.3.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Carlos Brando"]
  s.date = %q{2010-08-01}
  s.description = %q{This gem set the autotest (ZenTest) to send messages to software as Growl, LibNotify, and Snarl, displaying a window with the results.}
  s.email = ["eduardobrando@gmail.com"]
  s.executables = ["an-install", "an-uninstall", "playsound"]
  s.files = ["test/autotest_notification/test_cygwin.rb", "test/autotest_notification/test_linux.rb", "test/autotest_notification/test_mac.rb", "test/autotest_notification/test_windows.rb", "test/test_autotest_notification.rb", "test/test_helper.rb", "bin/an-install", "bin/an-uninstall", "bin/playsound"]
  s.homepage = %q{http://github.com/carlosbrando/autotest-notification/}
  s.post_install_message = %q{PostInstall.txt}
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{autotest-notification.rb}
  s.rubygems_version = %q{1.6.0}
  s.summary = %q{This gem set the autotest (ZenTest) to send messages to software as Growl, LibNotify, and Snarl, displaying a window with the results.}
  s.test_files = ["test/autotest_notification/test_cygwin.rb", "test/autotest_notification/test_linux.rb", "test/autotest_notification/test_mac.rb", "test/autotest_notification/test_windows.rb", "test/test_autotest_notification.rb", "test/test_helper.rb"]

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<autotest>, ["~> 4.3"])
      s.add_development_dependency(%q<rubyforge>, [">= 2.0.4"])
      s.add_development_dependency(%q<hoe>, [">= 2.6.0"])
    else
      s.add_dependency(%q<autotest>, ["~> 4.3"])
      s.add_dependency(%q<rubyforge>, [">= 2.0.4"])
      s.add_dependency(%q<hoe>, [">= 2.6.0"])
    end
  else
    s.add_dependency(%q<autotest>, ["~> 4.3"])
    s.add_dependency(%q<rubyforge>, [">= 2.0.4"])
    s.add_dependency(%q<hoe>, [">= 2.6.0"])
  end
end
