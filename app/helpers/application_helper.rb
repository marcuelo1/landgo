module ApplicationHelper
    def date_form_format date
        "#{date['day']}/#{date['month']}/#{date['year']}".to_datetime
    end

    def formated_datetime datetime
        datetime.strftime("%b %d, %Y")
    end
end
