Cross Platform CSharp Projects
==============================

Tools for creating cross platform CSharp projects.

Best for creating a common library that compiles to Windows, MonoDevelop and MonoTouch.

*Note: These instructions are for those who don't know Git or want to use the source code*

Installation
============

* Install Ruby: http://www.ruby-lang.org/
* Enter this into the command line: <pre>gem install cross_platform_csproj</pre>

Usage
=====

This example uses Rake (optional):

* Create a file at the root folder of your project called: <pre>rakefile.rb</pre>
* Add the following to the file:

<pre>
require 'cross_platform_csproj'

task :default => [:updateProjectFiles]

task :updateProjectFiles do
    files = FileList.new('**/*.cs')
    CrossPlatformCSProj::updateProject('MyProject.csproj', files)
end
</pre>

* Enter this into the command line (current directory at project root): <pre>rake</pre>

See more elaborate example:

  https://github.com/markslwong/CrossPlatformCSProj/blob/master/example.rb
