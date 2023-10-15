require_relative "package_size"

require_relative "package"
class LargePackage < Package
  def size
    PackageSize.new(3)
  end
end
