module ApplicationHelper
  def bootstrap_class_for type
    case type
      when 'success'
        "alert-success"
      when 'error'
        "alert-error"
      when 'alert'
        "alert-block"
      when 'notice'
        "alert-info"
      else
        type.to_s
    end
  end

  def status_name status
    status == 1 ? 'Ativo' : 'Inativo'
  end

  def date_format(date)
    date.strftime("%d/%m/%Y - %H:%M")
  end
end
