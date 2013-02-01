Cross Platform CSharp Projects
==============================

Tools for creating cross platform CSharp projects.  Best for creating a common library that compiles to Windows, MonoDevelop and MonoTouch.

Usage
=====

Best used with Rake

  files = FileList.new('Source/**/*.cs')
  CrossPlatformCSProj::updateProject('Source/MyProject.csproj', files)

See more elaborate example:

  https://github.com/markslwong/CrossPlatformCSProj/blob/master/example.rb
