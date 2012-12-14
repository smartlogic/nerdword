Gem::Specification.new do |s|
  s.name        = "nerdword"
  s.version     = "0.0.1"
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Tom von Schwerdtner", "Nestor Walker", "Eric Ostrich", "Sam Goldman"]
  s.email       = ["dev@smartlogicsolutions.com"]
  s.homepage    = "http://github.com/smartlogic/nerdword"
  s.summary     = %q{Get nerdy... with words!}
  s.description = %q{Play crossword games with your friends.}

  s.add_development_dependency "rspec"

  # Man files are required because they are ignored by git
  git_files            = `git ls-files`.split("\n") rescue ""
  s.files              = `git ls-files -- lib`.split("\n")
  s.test_files         = `git ls-files -- spec`.split("\n")
  s.require_paths      = ["lib"]
end
