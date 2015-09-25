class HostsController < ApplicationController
  def index
    @hosts_by_hostgroup = ZabbixUtils.build_hosts_by_hostgroup.sort_by {|k, _| k }
    @hosts_by_template = ZabbixUtils.build_hosts_by_template.sort_by {|k, _| k }
  end

  def show
    hostid = params[:id]
    host = ZabbixUtils.host_by_id(hostid)
    @hostanme = host[:host]
    @graph_name_by_id = ZabbixUtils.graphs_by_host(hostid).sort_by {|_, g| g['name'] }
  end
end
