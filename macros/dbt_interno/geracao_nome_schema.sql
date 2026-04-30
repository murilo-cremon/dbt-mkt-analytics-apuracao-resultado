{% macro generate_schema_name(custom_schema_name, node) %}
    {% if custom_schema_name is none %}
        {{ target.shema }}
    {% else %}
        {{ custom_schema_name }}
    {% endif %}
{% endmacro %}