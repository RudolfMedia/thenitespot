module Sortable
  extend ActiveSupport::Concern

  included do
  	enum sort: %w(eat drink attend)
    validates :sort, presence: true, inclusion: { in: sorts }, unless: ->{ parent_id.present? }
    sorts.each do |k,v|
      scope k, ->{ where(sort: v) }
    end
  end
  
end