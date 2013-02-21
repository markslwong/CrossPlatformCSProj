require 'cross_platform_csproj'

task :default do
	project = 'Test'

	CrossPlatformCSProj::updateProject("#{project}.Android.csproj", CrossPlatformCSProj::getAndroidFiles())
	CrossPlatformCSProj::updateProject("#{project}.Windows.csproj", CrossPlatformCSProj::getWindowsFiles())
	
	puts "Project Files Updated!"
end
