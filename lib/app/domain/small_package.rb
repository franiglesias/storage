class SmallPackage < Package
  def size
    PackageSize.new("small")
  end
end
