module ApplicationHelper
  def show_svg(path)
    File.open("lib/assets/images/#{path}", 'rb') do |file|
      raw file.read
    end
  end
end
