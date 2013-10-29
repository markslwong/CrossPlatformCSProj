require 'nokogiri'

class CrossPlatformCSProj

	def self.updateProject(projectFile, fileList)
		if !File.exists?(projectFile)
			puts "CSProject file does not point to any file: #{projectFile}" 
		end

		for file in fileList do
			if !File.exists?(file)
				puts "A file in the in the file list is not a valid file: #{fileList}"
			end
		end

		rootPath = File.dirname(projectFile).gsub('/', '\\')
		document = openDocument(projectFile)
		parent = getParentNode(document)

		if parent != nil
			parent.children.remove

			for file in fileList do
				compileNode = Nokogiri::XML::Node.new 'Compile', document

				parent.add_child(compileNode)

				relativeFile = getRelativePath(file, rootPath)

				compileNode.set_attribute('Include', relativeFile)
			end
		end

		saveDocument(document, projectFile)
	end

	private

	def self.openDocument(projectFile)
		fileHandle = File.open(projectFile)
		document = Nokogiri::XML(fileHandle) do |config|
			config.default_xml.noblanks
		end
		fileHandle.close

		return document
	end

	def self.saveDocument(document, projectFile)
		documentContents = document.to_xml(:indent => 2)

		# Formatting to appease Visual Studio.  
		# Visual Studio will self terminating XML blocks (eg: <br/>) with a space (eg: <br />)
		documentContents = documentContents.gsub(/([^\s])\/\>/, '\1 />')

		# Visual Studio will remove any newline characters on the final line
		documentContents = documentContents.gsub(/\n$/, '')

		# Visual Studio will add a strange character at the start of every project
		documentContents = "\u{FEFF}" + documentContents
		
		fileHandle = File.open(projectFile)
		documentContentsOld = fileHandle.read
		fileHandle.close

		# Only write to the file if there has been changes.  This will allow updateProject to be called many times without Visual Studio from needing to reload the project
		if documentContentsOld != documentContents
			fileHandle = File.open(projectFile, 'w')
			fileHandle.print(documentContents)
			fileHandle.close
		end
	end

	def self.getParentNode(document)
		nodes = document.css('Project > ItemGroup')
		parentNode = nil

		for node in nodes do
			if (node.css('Compile').length > 0)
				if (parentNode != nil)
					puts "ERROR: more than one ItemGroup element has Compile elements"
					return nil
				end

				parentNode = node
			end
			if node.children.length == 0 && node.attributes.length == 0
				node.remove()
			end
		end

		if parentNode == nil
			projectNodes = document.css('Project')

			if projectNodes.length == 0
				puts 'ERROR: invalid CSharp project file'
				return nil
			end

			parentNode = Nokogiri::XML::Node.new('ItemGroup', document)

			projectNodes[0].add_child(parentNode)
		end 

		return parentNode
	end

	def self.getRelativePath(path, pathRelative)
		pathRelative = pathRelative.gsub('/', '\\')
		path = path.gsub('/', '\\')
		
		if path.start_with?(pathRelative)
			path = path[pathRelative.length..path.length - 1]
		end
		
		if (path.length > 0 and path.start_with?('\\'))
			return path[1..path.length - 1]
		end

		return path
	end

	def self.getCoreFiles(path = '.')
		fileList = FileList.new()
		
		fileList.include("#{path}/**/*.cs")

		fileList.exclude("#{path}/**/bin/**/*.cs")
		fileList.exclude("#{path}/**/obj/**/*.cs")

		return fileList
	end

	def self.getAndroidFiles(path = '.')
		fileList = getCoreFiles(path);

        fileList.exclude("#{path}/**/iOS/**/*.cs")
		fileList.exclude("#{path}/**/IOS/**/*.cs")
		fileList.exclude("#{path}/**/Windows/**/*.cs")

		fileList.exclude("#{path}/**/*.iOS.cs")
		fileList.exclude("#{path}/**/*.IOS.cs")
		fileList.exclude("#{path}/**/*.Windows.cs")

		return fileList;
	end

	def self.getIOSFiles(path = '.')
		fileList = getCoreFiles(path);

		fileList.exclude("#{path}/**/Android/**/*.cs")
		fileList.exclude("#{path}/**/Windows/**/*.cs")

		fileList.exclude("#{path}/**/*.Android.cs")
		fileList.exclude("#{path}/**/*.Windows.cs")

		fileList.exclude("#{path}/**/Resource.Designer.cs")
		fileList.exclude("#{path}/**/Resource.designer.cs")

		return fileList;
	end

	def self.getWindowsFiles(path = '.')
		fileList = getCoreFiles(path);

		fileList.exclude("#{path}/**/Android/**/*.cs")
		fileList.exclude("#{path}/**/iOS/**/*.cs")
		fileList.exclude("#{path}/**/IOS/**/*.cs")

		fileList.exclude("#{path}/**/*.Android.cs")
		fileList.exclude("#{path}/**/*.iOS.cs")
		fileList.exclude("#{path}/**/*.IOS.cs")

		fileList.exclude("#{path}/**/Resource.Designer.cs")
		fileList.exclude("#{path}/**/Resource.designer.cs")
		
		return fileList;
	end

	def self.getVoidFiles(path = '.')
		fileList = getCoreFiles(path);

		fileList.exclude("#{path}/**/Android/**/*.cs")
		fileList.exclude("#{path}/**/iOS/**/*.cs")
		fileList.exclude("#{path}/**/IOS/**/*.cs")
		fileList.exclude("#{path}/**/Windows/**/*.cs")

		fileList.exclude("#{path}/**/*.Android.cs")
		fileList.exclude("#{path}/**/*.iOS.cs")
		fileList.exclude("#{path}/**/*.IOS.cs")
		fileList.exclude("#{path}/**/*.Windows.cs")

		fileList.exclude("#{path}/**/Resource.Designer.cs")
		fileList.exclude("#{path}/**/Resource.designer.cs")
		
		return fileList;
	end

end
