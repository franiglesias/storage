class CliApp < Thor
  desc "health", "To check that the application runs"
  def health
    puts "OK"
  end
end
