# encoding: UTF-8

# Выполняется перед сценарием
Before do |scenario|
  # nothing
end

After do |scenario|
  if scenario.failed?
    puts scenario.name
    puts scenario.exception.message
  end
end

