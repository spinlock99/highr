module LinkedIn
  class Education < LinkedIn::Base

    def educations
      @educations ||= @doc.children.inject([]) do |list, edu|
        list << Resource.new(edu) unless edu.blank?
        list
      end
    end

    class Resource

      def initialize(education)
        @education = education
      end

      %w[id school_name degree field_of_study activities notes].each do |f|
        define_method(f.to_sym) do
          @education.xpath("./#{f.gsub(/_/,'-')}").text
        end
      end

      def start_month
        @education.xpath('./start-date/month').text.to_i
      end

      def start_year
        @education.xpath('./start-date/year').text.to_i
      end

      def end_month
        @education.xpath('./end-date/month').text.to_i
      end

      def end_year
        @education.xpath('./end-date/year').text.to_i
      end
    end # resource class

  end # education class
end
