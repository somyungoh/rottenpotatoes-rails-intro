module ApplicationHelper
    
    def sortable(column, title = nil)
        title ||= column.titleize
        css_class = column == sort_column ? "hilite" : nil
        link_to title, {:sort => column, :ratings => params[:ratings]}, {:class => css_class}
    end
end
