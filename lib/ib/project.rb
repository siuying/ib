class IB::Project
  def write app_path = "./app", resources_path = "./resources"
    project = Xcodeproj::Project.new
    target = project.targets.new_static_library(:ios, 'design')

    resources = project.groups.new('path' => resources_path, 'name' => 'Resources')
    support = project.groups.new('name' => 'Support Files')

    IB::Generator.new.write(app_path, "ui.xcodeproj")
    support.files.new 'path' => "ui.xcodeproj/stubs.h"

    Dir.glob("#{resources_path}/**/*.{xcdatamodeld,png,jpg,jpeg,storyboard,xib}") do |file|
      resources.files.new('path' => file)
    end

    project.save_as("ui.xcodeproj")
  end
end