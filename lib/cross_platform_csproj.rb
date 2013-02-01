require 'nokogiri'

class CrossPlatformCSProj

	def self.updateProject(projectFile, fileList)
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
		documentContents = document.to_xml(:indent => 4)

		fileHandle = File.open(projectFile)
		documentContentsOld = fileHandle.read
		fileHandle.close

		# Only write to the file if there has been changes.  This will allow updateProject to be called many times without Visual Studio from needing to reload the project
		if documentContentsOld != documentContents
			fileHandle = File.open(projectFile, 'w')
			fileHandle.puts(documentContents)
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
		end

		if parentNode == nil
			projectNode = document.css('Project')

			if projectNode.length == 0
				puts 'ERROR: invalid CSharp project file'
				return nil
			end

			parentNode = Nokogiri::XML::Node.new('ItemGroup', document)

			projectNode.add_next_sibling(parentNode)
		end 

		return parentNode
	end

	def self.getRelativePath(path, pathRelative)
		pathRelative = pathRelative.gsub('/', '\\')
		path = path.gsub('/', '\\')
		path = path.gsub(pathRelative, "")
		
		if (path.length > 0 and path.start_with?('\\'))
			return path[1..path.length - 1]
		end

		return path
	end

end
