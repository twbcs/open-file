class ApplicationController < ActionController::Base

  private

  def player(main_dir, item, file)
    system `osascript -e 'tell app "MPlayerX" to close front window'
    osascript -e 'quit app "/Applications/MPlayerX.app"'
    open -a MPlayerX
    osascript -e 'tell application "MPlayerX"
    open "#{main_dir}/#{item.dir_name}/#{file}"
    end tell'`
  end

  def look(main_dir, item, file)
    system `osascript -e 'tell app "Simple Comic" to close front window'
    osascript -e 'quit app "/Applications/Simple Comic.app"'
    osascript -e 'tell application "Simple Comic"
      activate
      open "#{main_dir}/#{item.dir_name}/#{file}"
    end tell'`
  end

  def finder(main_dir, item)
    begin
      Dir.chdir("#{main_dir}/#{item.dir_name}")
    rescue => ex
      Dir.chdir(main_dir)
    end

    unless Dir.pwd == main_dir
      folders = "#{main_dir}/#{item.dir_name}".split('/').reverse!
      folders.pop
      folders.pop
      disk = folders.pop
      string = []
      folders.each do |folder|
        string << 'folder "' + folder + '"'
      end
      text = string * ' of '
      system `osascript -e 'tell application "Finder" to make new Finder window'`
      system `osascript -e 'tell application "Finder"
      if front Finder window exists then
        activate
        set target of Finder window 1 to #{text} of disk "#{disk}"
      end if
      end tell'`
    end
  end
end
