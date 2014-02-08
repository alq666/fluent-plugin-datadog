fluent-plugin-datadog
=====================

Output fluentd to Datadog

Configuration
=============

```
<match datadog.**>
  type datadog
  dd_api_key ...
  #dd_app_key ...
  #host my_host.example.com
</match>
```

Usage
=====

```sh
echo '{"metric":"some.metric.nam", "value":50.0}' | fluent-cat datadog.metric
```
