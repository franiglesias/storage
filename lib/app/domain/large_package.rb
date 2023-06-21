require_relative "package_size"

class LargePackage < Package
  def size
    PackageSize.new(3)
  end
end
