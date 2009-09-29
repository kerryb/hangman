require 'rake'
require 'rake/gempackagetask'
require 'spec/rake/spectask'
require 'hangman_tournament/submit'
require 'metric_fu'

desc 'Run specs and stats; build and install gem; open app'
task :default => [:spec, :'metrics:all', :gem, :install, :run]

desc "Run all specs"
Spec::Rake::SpecTask.new('spec') do |t|
  t.spec_files = FileList['spec/**/*.rb']
  t.rcov = false
end

PKG_NAME = "kerryb"
PKG_VERSION   = "1.3"

spec = Gem::Specification.new do |s|
  s.name = "hangman_#{PKG_NAME}"
  s.version = PKG_VERSION
  s.files = Dir.glob('**/*').reject{ |f| f =~ /pkg/ }
  s.require_path = 'lib'
  s.test_files = Dir.glob('spec/*_spec.rb')
  s.bindir = 'bin'
  s.executables = []
  s.summary = "Hangman Player:kerryb"
  s.rubyforge_project = "sparring"
  s.homepage = "http://sparring.rubyforge.org/"

  ###########################################
  ##
  ## You are encouraged to modify the following
  ## spec attributes.
  ##
  ###########################################
  s.description = "Kerry's hangbot"
  s.author = "Kerry Buckley"
  s.email = "kerryjbuckley@gmail.com"
end

Rake::GemPackageTask.new(spec) do |pkg|
  pkg.need_zip = false
  pkg.need_tar = false
end

desc 'Install gem'
task :install do
  system "sudo gem install pkg/hangman_#{PKG_NAME}"
end

desc 'Run app'
task :run do
  system 'open hangman.lll'
end

desc "Submit your player"
task :submit do
  submitter = HangmanTournament::Submit.new("hangman_#{PKG_NAME}")
  submitter.submit
end
