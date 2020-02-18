module ApplicationHelper
    
    def sortable(column, title = nil)
        title ||= column.titleize
        css_class = column == sort_column ? "hilite" : nil
        # ratings = params[:ratings].nil? ? params[:ratings][1] : params[:ratings]
        link_to title, {:sort => column, :ratings => params[:ratings]}, {:class => css_class}
    end
    
    def get_check(rating)
       checked = rating.nil? ? 1 : rating
    end
end
