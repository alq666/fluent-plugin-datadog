fluent-plugin-datadog
=====================

Send metrics from fluentd into Datadog. Once you have installed this plugin you can automatically turn events from streams into a Datadog metric.

Installation
============

1. Locate the `plugin` directory of your fluentd installation. Mine is in `/etc/td-agent/plugin/`, on an Ubuntu 14.10 box.
2. Copy `out_datadog.rb` into that `plugin` directory.
3. Make sure that [dogapi](https://rubygems.org/gems/dogapi) is installed on your system.
4. Configure `td-agent.conf` as shown below.
4. Restart fluentd.

Configuration
=============

1. Get your [Datadog API key](https://app.datadoghq.com/account/settings#api).
2. Add the following section to `td-agent.conf`

```
<match datadog.**>
  type datadog
  dd_api_key PUT_YOUR_DATADOG_API_KEY_HERE
</match>
```

Test it
=======

```sh
echo '{"metric":"some.metric.name", "value":50.0}' | fluent-cat datadog.metric
```
