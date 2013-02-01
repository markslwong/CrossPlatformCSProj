Gem::Specification.new do |s|
  s.name        = 'cross_platform_csproj'
  s.version     = '0.0.2'
  s.date        = '2013-01-31'
  s.summary     = "Tools for creating cross platform CSharp projects."
  s.description = "Offers functions which synchronize the file and folder structure to a CSharp project.  Users maintain a cross platform CSharp library using the file system.  Running these functions will update CSProject files to any changes as done on the file system.  This is particularly useful for creating cross platform libraries that would work with Windows, MonoAndroid and MonoTouch."
  s.authors     = ["Tyler Hamilton, Mark Wong"]
  s.email       = 'xqdeveloper@gmail.com'
  s.files       = ["lib/cross_platform_csproj.rb", "README.rdoc", "LICENSE.txt"]
  s.homepage    = 'http://github.com/markslwong/CrossPlatformCSProj'
end