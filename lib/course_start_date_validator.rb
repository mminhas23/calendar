require 'date'
class CourseStartDateValidator < ActiveModel::EachValidator
  def validate_each(object, attribute, value)
    if object.errors[attribute].blank?
      if value < DateTime.now.to_date
      object.errors[attribute] << "cannot be later than today"
    end
    end
  end
end