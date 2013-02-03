Cross Platform CSharp Projects
==============================

Tools for creating cross platform CSharp projects.

Best for creating a common library that compiles to Windows, MonoDevelop and MonoTouch.

Installation
============

1. Install Ruby: http://www.ruby-lang.org/
2. Enter this into the command line: <pre>gem install cross_platform_csproj</pre>

Usage
=====

This example uses Rake (optional):

1. Create a file at the root folder of your project called: <pre>rakefile.rb</pre>
2. Add the following to the file:

<pre>
require 'cross_platform_csproj'

task :default => [:updateProjectFiles]

task :updateProjectFiles do
    files = FileList.new('**/*.cs')
    CrossPlatformCSProj::updateProject('MyProject.csproj', files)
end
</pre>

3. Enter this into the command line (current directory at project root): <pre>rake</pre>

See more elaborate example:

  https://github.com/markslwong/CrossPlatformCSProj/blob/master/example.rb
