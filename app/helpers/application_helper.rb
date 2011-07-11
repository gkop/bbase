module ApplicationHelper

  def maybe_load(callback, *js_files)
    if !js_files.empty?
      js_files.map! do |f|
        f = "\'#{request.protocol + request.host_with_port}/javascripts/#{f}\'"
      end
      raw "BBase.maybeLoad(\"#{callback ? callback : 'null'}\", #{js_files * ', '});"
    end
  end

end
