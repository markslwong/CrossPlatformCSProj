Cross Platform CSharp Projects
==============================

Tools for creating cross platform CSharp projects.

Best for creating a common library that compiles to Windows, MonoDevelop and MonoTouch.

<h3>Note: These instructions are for those who don't want to use the source code</h3>

Installation
============

<ol>
<li>Install Ruby: http://www.ruby-lang.org/</li>
<li>Enter this into the command line: 

<pre>gem install cross_platform_csproj</pre></li>
</ol>

Usage
=====

<ol>
<li>Create a file at the root folder of your project called: 

<pre>rakefile.rb</pre></li>
<li>Add the following to the file: 

<pre>require 'cross_platform_csproj'

task :default => [:updateProjectFiles]

task :updateProjectFiles do
    files = FileList.new('**/*.cs')
    CrossPlatformCSProj::updateProject('MyProject.csproj', files)
end</pre></li>
<li>Enter this into the command line (<i>current directory at project root</i>): 

<pre>rake</pre></li>
</ol>

See more elaborate example:

  https://github.com/markslwong/CrossPlatformCSProj/blob/master/example.rb
