module Popolo
  module Sluggable
    extend ActiveSupport::Concern

    included do
      # The resource's name.
      field :name, type: String, localize: true
      # A lowercase identifier composed of letters, numbers and dashes.
      field :slug, type: String

      index({slug: 1}, unique: true)

      validates_presence_of :name, :slug

      before_validation :set_slug
    end

    module ClassMethods
      # @param [String] slug a slug or ID
      # @return a matching resource
      def find_by_slug(slug)
        where(slug: slug).first || find(slug)
      end
    end

  private

    # @note Leave it to the content manager to choose a slug in case of conflicts.
    def set_slug
      self.slug ||= name.parameterize if name
    end
  end
end
