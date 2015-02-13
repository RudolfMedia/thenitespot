
class UrlValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, value)
  	unless value =~ URI::regexp(%w( http https ))
      record.errors[attribute] << (options[:message] || "invalid url")
    end
  end

end