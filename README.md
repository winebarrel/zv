# ZV - Zabbix Gpaph Dashbord

This is a dashboard that displays zabbix hosts and graphs.

Zabbix screen is not used.

# Installation

```sh
bundle install
cp config/zabbix.yml.sample config/zabbix.yml
vi config/zabbix.yml
```

## zabbix.yml

```yaml
endpoint: http://localhost/zabbix/api_jsonrpc.php
user: Admin
password: zabbix
url: http://localhost/zabbix
```

# Start app

```sh
bundle exec rails s
```

Then please go to `http://localhost:3000`.

# Screenshot

![](https://i.gyazo.com/b64bf2f741f22304b52f9593d894def1.png)

![](https://i.gyazo.com/84be6a93ff92440145b9fe4cef85b609.png)
