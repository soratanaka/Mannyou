module TasksHelper
  def options_for_select_from_enum(klass,column)
    enum_list = klass.send(column.to_s.pluralize)
    enum_list.map do | name , _value |
      [ t("enums.#{klass.to_s.downcase}.#{column}.#{name}") , name ]
    end
  end
end
