Cross Platform CSharp Projects
==============================

Tools for creating cross platform CSharp projects.

Best for creating a common library that compiles to Windows, MonoDevelop and MonoTouch.

<b>Note: These instructions are for those who don't know Git or want to use the source code</b>

Installation
============

* Install Ruby: http://www.ruby-lang.org/
* Enter this into the command line: <pre>gem install cross_platform_csproj</pre>

Usage
=====

This example uses Rake (optional):

<ul>
<li>Create a file at the root folder of your project called: <pre>rakefile.rb</pre></li>
<li>Add the following to the file:
<pre>
require 'cross_platform_csproj'

task :default => [:updateProjectFiles]

task :updateProjectFiles do
    files = FileList.new('**/*.cs')
    CrossPlatformCSProj::updateProject('MyProject.csproj', files)
end
</pre></li>
<li>Enter this into the command line (current directory at project root): <pre>rake</pre></li>

See more elaborate example:

  https://github.com/markslwong/CrossPlatformCSProj/blob/master/example.rb
