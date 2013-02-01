require 'cross_platform_csproj'

task :default => [:updateProjectFiles]

task :updateProjectFiles do
	puts "Updating Project Files"

	CrossPlatformCSProj::updateProject('Source/MyProject.Android.csproj', getAndroidFiles())
	CrossPlatformCSProj::updateProject('Source/MyProject.iOS.csproj', getIosFiles())
	CrossPlatformCSProj::updateProject('Source/MyProject.Windows.csproj', getWindowsFiles())
end

def getCoreFiles()
	fileList = FileList.new()

	fileList.include('Source/Core/**/*.cs')

	return fileList
end

def getAndroidFiles()
	fileList = getCoreFiles()

	fileList.include('Source/Platform/Android/**/*.cs')
	fileList.include('Source/Platform/Optional/Rendering/Renderer.OpenGLES.cs')

	return fileList
end

def getIosFiles()
	fileList = getCoreFiles()

	fileList.include('Source/Platform/iOS/**/*.cs')
	fileList.include('Source/Platform/Optional/Rendering/Renderer.OpenGLES.cs')

	return fileList
end

def getWindowsFiles()
	fileList = getCoreFiles()

	fileList.include('Source/Platform/Windows/**/*.cs')
	fileList.include('Source/Platform/Optional/Rendering/Renderer.DirectX.cs')

	return fileList
end