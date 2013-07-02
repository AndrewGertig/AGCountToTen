class FileUrl
  def initialize(file_name)
    now = Time.now
    @time = now.description
    @file_name = file_name
  end

  def dir
    # NSHomeDirectory().stringByAppendingPathComponent("Documents")
    App.documents_path
  end

  def recorderFilePath
    "#{dir}/sound_#{@file_name}.caf"
  end

  def renamedFilePath(new_name)
    "#{dir}/sound_#{new_name}.caf"
  end

  def defaultFilePath
    "#{App.resources_path}/sound_#{@file_name}.caf"
  end

  def url
    NSURL.fileURLWithPath(recorderFilePath)
  end

  def defaultUrl
    NSURL.fileURLWithPath(defaultFilePath)
  end


  def fileMgr
    NSFileManager.defaultManager
  end

  def showDirContents
    err = Pointer.new(:object) 
    contents = fileMgr.contentsOfDirectoryAtPath(dir, error:err)
    puts "Documents directory: #{contents}"
  end

  def deleteFile
    err = Pointer.new(:object)

    if (fileMgr.removeItemAtPath(recorderFilePath, error:err) != true)
      puts "Unable to delete file: #{err}"
    end
  end

  def exists
    fileMgr.fileExistsAtPath(recorderFilePath)
  end

  def renameFileTo(new_name)
    err = Pointer.new(:object)
    filePath = renamedFilePath(new_name)
 
    if (fileMgr.moveItemAtPath(recorderFilePath, toPath:filePath, error:err) != true) 
      puts "Unable to move file: #{err}"
    end
     
    # NSLog("Documents directory: %@", fileMgr.contentsOfDirectoryAtPath(documentsDirectory, error:err))
    showDirContents
  end

end
