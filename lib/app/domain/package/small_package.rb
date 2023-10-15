class SmallPackage < Package
  def size
    PackageSize.new(1)
  end
end
