module ResourcesHelper

  def save_resource_label(resource)
    verb = (params[:action] == "new" ? "Create" : "Update")
    "#{verb} #{@resource.type}"
  end

end
