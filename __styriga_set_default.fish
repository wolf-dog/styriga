function __styriga_set_default --argument-names var_name default_value
  if not set -q $var_name
    set -g $var_name $default_value
  end
end

