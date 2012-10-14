module Popolo
  # An area, most often an administrative division.
  #
  # @note There is an upper limit to the number of administrative levels;
  #   however, there is little agreement as to what those levels are. Therefore,
  #   instead of having a different model for each administrative level – which
  #   would have advantages – we use a flexible tree structure.
  class Area
    include Mongoid::Document
    include Mongoid::Tree
    include Popolo::Mixins::Sluggable
    include Popolo::Mixins::Eventable

    # The area's name.
    field :name, type: String
    # Any additional information to store about the area.
    field :extra, type: Hash

    validates_presence_of :name

    # Woe to jurisdictions with non-unique administrative division names!

    index({name: 1}, unique: true)
  end
end
