module StringifyTags

  def self.stringify(tags_array)
    and_string = (tags_array.size == 2 ? " and " : ", and ")
    friendly_tags = tags_array.map! {|t| t.pluralize }
                              .push(tags_array.pop(2).join and_string )
                              .join ", "
    friendly_tags.capitalize
  end

end
