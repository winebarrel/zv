class ZabbixUtils
  class << self
    def host_by_id(hostid)
      host = Zabbix.client.host.get(filter: {hostid: hostid}).first
      ActiveSupport::HashWithIndifferentAccess.new(host)
    end

    def build_hosts_by_hostgroup
      hash = Hash.new {|h, k| h[k] = {} }
      hosts = Zabbix.client.host.get(selectGroups: 'extend')

      hosts.each do |host|
        name = host['host']
        hostid = host['hostid']

        groups = host['groups'].map {|t| t['name'] }

        groups.each do |group|
          hash[group][hostid] = name
        end
      end

      hash
    end

    def build_hosts_by_template
      hash = Hash.new {|h, k| h[k] = {} }
      hosts = Zabbix.client.host.get(selectParentTemplates: 'extend')

      hosts.each do |host|
        name = host['host']
        hostid = host['hostid']

        templates = host['parentTemplates'].map {|t| t['host'] }

        templates.each do |template|
          hash[template][hostid] = name
        end
      end

      hash
    end

    def graphs_by_host(hostid)
      hash = {}
      host = Zabbix.client.host.get(selectGraphs: 'extend', filter: {hostid: hostid}).first
      graphs = host['graphs']

      graphs.each do |graph|
        graphid = graph['graphid']
        graph.delete('width')
        graph.delete('height')
        hash[graphid] = ActiveSupport::HashWithIndifferentAccess.new(graph)
      end

      hash
    end

    def graph_url(graphid, options = {})
      options = {
        form_refresh: 1,
      }.merge(options)

      options = ActiveSupport::HashWithIndifferentAccess.new(options)
      url = Zabbix.config[:url]
      File.join(url, "charts.php?graphid=#{graphid}&form_refresh=#{options[:form_refresh]}")
    end

    def graph_image_url(graphid, options ={})
      options = {
        width: 480,
        graphtype: "2",
      }.merge(options)

      options = ActiveSupport::HashWithIndifferentAccess.new(options)
      php_file = (options[:graphtype] == "2") ? 'chart6.php' : 'chart2.php'

      url = Zabbix.config[:url]
      File.join(url, "#{php_file}?graphid=#{graphid}&width=#{options[:width]}")
    end
  end # of class methods
end
