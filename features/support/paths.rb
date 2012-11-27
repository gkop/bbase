module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    when /my dashboard/
      '/dashboard'
    when /the biography page/
      '/biography'
    when /the create invite page/
      '/users/invitation/new'
    when /the edit settings page/
      '/settings/edit'
    when /the homepage/
      root_path
    when /the Drawings page/
      '/artworks?tags=drawing'
    when /the Paintings page/
      '/artworks?tags=painting'
    when /the Prints page/
      '/artworks?tags=print'
    when /the Sculptures page/
      '/artworks?tags=sculpture'
    when /the Request an Invite page/
      '/users/sign_up'
    when /the page for the artwork/
      artwork_path(@artwork)
    when /the page for the gallery/
      gallery_path(@gallery || @gallery)
    when /the user page of the gallery owner/
      user_path(@gallery.user)

    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      begin
        page_name =~ /the (.*) page/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue Object => e
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)
