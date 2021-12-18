module DefaultPageContent
	extend ActiveSupport::Concern

	included do
		before_action :set_page_default
	end

	def set_page_default
		@page_title = "DasDevGuide"
		@set_keywords = "DasDevGuide"
	end
end