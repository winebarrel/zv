require 'zabbix/client'

Rails.application.config.zabbix = ActiveSupport::HashWithIndifferentAccess.new(
  YAML.load_file(Rails.root.join('config/zabbix.yml'))
)

module ZabbixExtend
  EXTRA_KEYS = %w(
    url
  )

  def build_client
    cnfg = self.config

    EXTRA_KEYS.each do |key|
      cnfg.delete(key)
    end

    endpoint = cnfg.delete(:endpoint)
    user = cnfg.delete(:user)
    password = cnfg.delete(:password)

    client = Zabbix::Client.new(endpoint, cnfg)
    client.user.login(user: user, password: password)
    client
  end

  def client
    @client ||= build_client
  end

  def config
    Rails.application.config.zabbix.dup
  end
end

Zabbix.extend(ZabbixExtend)
