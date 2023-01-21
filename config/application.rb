require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
# require "action_mailer/railtie"
# require "action_mailbox/engine"
# require "action_text/engine"
require "action_view/railtie"
# require "action_cable/engine"
require "sprockets/railtie"
require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module AwesomeEvents
  class Application < Rails::Application
    config.load_defaults 6.0
    config.time_zone = "Tokyo"
    # エラーメッセージを日本語に設定（但し、辞書は別途設定が必要）
    config.i18n.default_locale = :ja
    config.active_storage.variant_processor = :vips
    # 独自に定義したエラーが発生した時にpublic/500.html以外を返したい時は以下のように設定する
    config.action_dispatch.rescue_responses.merge!(
      "独自に定義したエラー" => :not_found
    )
  end
end
