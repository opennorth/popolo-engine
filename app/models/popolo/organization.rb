module Popolo
  # A structured collection of people.
  #
  # Turtle document:
  #
  #     <http://example.com/organizations/17cc67093475061e3d95369d.ttl>
  #       a org:Organization;
  #       skos:prefLabel "ABC, Inc.";
  #       org:classification [
  #         a skos:Concept;
  #         skos:prefLabel "Company";
  #       ];
  #       rdfs:seeAlso <http://example.com/people/17cc67093475061e3d95369d>;
  #       dcterms:created "2012-01-01T00:00:00Z"^^xsd:dateTime;
  #       dcterms:modified "2012-01-01T00:00:00Z"^^xsd:dateTime .
  #
  # @see http://www.w3.org/TR/vocab-org/
  # @see http://www.w3.org/TR/skos-reference/
  # @see http://dublincore.org/documents/dcmi-terms/
  class Organization
    include Mongoid::Document
    include Mongoid::Timestamps
    include Mongoid::Tree
    include Popolo::Mixins::Sluggable
    include Popolo::Mixins::Eventable

    has_many :memberships, class_name: 'Popolo::Membership'
    belongs_to :spatial, polymorphic: true, index: true, class_name: 'Popolo::Area'

    # The organization's official name.
    field :name, type: String
    # The organization's category.
    field :classification, type: String

    validates_presence_of :name
  end
end
