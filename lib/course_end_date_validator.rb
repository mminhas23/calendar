class CourseEndDateValidator < ActiveModel::EachValidator
  def validate_each(object, attribute, value)
    if object.errors[attribute].blank? && object.errors[:start_date].blank?
      if value < object.start_date
      object.errors[attribute] << "cannot be later than start date"
    end
    end
  end
end