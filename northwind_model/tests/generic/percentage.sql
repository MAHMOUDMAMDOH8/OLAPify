{% test percentage(model,column_name) %}

    Select *
    from {{ model }}
    where 
        {{column_name}} >  1
    and 
        {{column_name}} < 0

{% endtest %}