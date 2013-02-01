Cross Platform CSharp Projects
==============================

Tools for creating cross platform CSharp projects.  Best for creating a common library that compiles to Windows, MonoDevelop and MonoTouch.

Usage
=====

This example uses Rake (optional install):

<pre>
  files = FileList.new('Source/**/*.cs')
  CrossPlatformCSProj::updateProject('Source/MyProject.csproj', files)
</pre>

See more elaborate example:

  https://github.com/markslwong/CrossPlatformCSProj/blob/master/example.rb

Installation
============

1. Install Ruby: http://www.ruby-lang.org/
2. Enter this into the command line:

<pre>
gem install cross_platform_csproj
</pre>

3. Optional install Rake: http://rake.rubyforge.org/

<pre>
gem install rake
</pre>
