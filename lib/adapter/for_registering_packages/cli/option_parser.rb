class OptionParser
  def initialize(args)
    @args = args
  end

  def by_name_or_default(name, default)
    @args.each do |part|
      part.match(/--#{name}=(.*)/) do |matches|
        return matches[1] unless matches[1] == ""
      end
    end
    default
  end
end
