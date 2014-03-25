require "grape/kaminari/version"
require "kaminari/grape"

module Grape
  module Kaminari
    def self.included(base)
      base.class_eval do
        helpers do
          def paginate(collection)
            collection.page(params[:page]).per(params[:per_page])
          end
        end

        def self.paginate(options = {})
          options.reverse_merge!(per_page: 10)
          params do
            optional :page,     type: Integer, default: 1,
                                desc: 'Page offset to fetch.'
            optional :per_page, type: Integer, default: options[:per_page],
                                desc: 'Number of results to return per page.'
          end
        end
      end
    end
  end
end
