# frozen_string_literal: true

set :output, 'log/cron.log'

every 1.hour do
  rake 'refresh_skins:refresh'
end
