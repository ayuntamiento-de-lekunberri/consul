module Consul
  class Application < Rails::Application
	config.i18n.default_locale= :eu
	config.i18n.available_locales = [ :es, :eu ]
  end
end
